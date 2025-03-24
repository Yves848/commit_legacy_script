param(
  [string]$path,
  [string]$projetPath
)

function Make-PG {
  param(
      [string]$csvpath
  )

  $csvname = [System.IO.Path]::GetFileNameWithoutExtension($csvpath)
  $templatepath = "$PSScriptRoot\templates\$csvname.pg"

  if ((Test-Path -Path $templatepath) -eq $true) {
    $pgpath = "$projetPath\$csvname.pg"

    $csvHeaders = ''
    Get-Content -Path $csvpath -ReadCount 1 | ForEach-Object {
        if ($csvHeaders -eq '') {
            $csvHeaders = $_ -split ';' | ForEach-Object { $_.Trim() }
            }
    }    
    $templateContent = Get-Content -Path $templatepath -Raw
    $regexPattern = 'CREATE\s+TABLE\s+public\.' + [regex]::Escape($csvname) + '\s*\(\s*(.*?)\s*\)\s*(WITH|TABLESPACE|;|\))'

    $match = [regex]::Match($templateContent, $regexPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($match.Success) {
        $columnsBlock = $match.Groups[1].Value
        # $columns = [regex]::Split($columnsBlock, ',(?![^\(]*\))$')
        $columns = $columnsBlock -split "`n"
        $columnDefinitions = @{}
        $orderedTableColumns = @()

        foreach ($colDef in $columns) {
            $colDef = $colDef.Trim()
            # On skippe les descriptions de contraintes
            if ($colDef -match '^(CONSTRAINT|PRIMARY KEY|UNIQUE|FOREIGN KEY|CHECK)\b') {
                continue
            }

            # On matche les définitions de colonnes : nom_de_colonne type [contraintes...]
            if ($colDef -match '^(?<colName>\w+)') {
                $colName = $matches['colName']
                $dataType = $coldef.Substring($matches['colName'].Length)
                # On supprime les contraintes (attention si ajout)
                $dataType = $dataType -replace '\s+COLLATE\b.*', ''
                $dataType = $dataType -replace '\s+NOT\s+NULL\b.*', ''
                $dataType = $dataType -replace '\s+DEFAULT\b.*', ''
                $dataType = $dataType -replace '\,$', ''
                $dataType = $dataType.Trim()
                $columnDefinitions[$colName] = $dataType
                $orderedTableColumns += $colName
            }
        }

        $tableColumns = $orderedTableColumns

        # Colonnes qui sont aussi dans le header fourni
        $tableColumnsInCSV = $tableColumns | Where-Object { $csvHeaders -contains $_ }


        $extraColumns = $csvHeaders | Where-Object { -not ($tableColumns -contains $_) }
        foreach ($col in $extraColumns) {
            Write-Host "Colonne '$col' non trouvée dans la définition. Ne sera pas insérée dans la définition finale." -ForegroundColor Yellow
        }

        # On génère la table temporaire, colonnes basées sur le header réel
        $tempTableCreation = "CREATE TEMP TABLE temp_$csvname (`n"
        $tempTableCreation += ($csvHeaders | ForEach-Object { "`t$_ TEXT" }) -join ",`n"
        $tempTableCreation += "`n);`n"

        $copyCommand = "COPY temp_$csvname FROM '" + $csvpath.Replace("'", "''") + "' DELIMITER ';' CSV HEADER;"
        $insertColumns = ($tableColumnsInCSV | ForEach-Object { $_ }) -join ",`n    "

        # On génère les colonnes du SELECT, avec les casts
        $selectColumns = @()
        foreach ($colName in $tableColumnsInCSV) {
            $colName = $colName.Trim()
            $dataType = $columnDefinitions[$colName]
            $cleanDataType = $dataType -replace '\s+COLLATE\b.*$', ''
            if ($cleanDataType -match '^text$') {
                $selectColumns += "temp.$colName AS $colName"
            } else {
                $selectColumns += "CAST(temp.$colName AS $cleanDataType) AS $colName"
            }
            }
        $selectColumnsText = $selectColumns -join ",`n    "

        # Remplacement des placeholders
        $newContent = $templateContent -replace "##TEMP_TABLE_CREATION##", $tempTableCreation
        $newContent = $newContent -replace "##TEMP_COPY##", $copyCommand
        $tempTableName = "temp_$csvname"
        $newContent = $newContent -replace "##TEMP_TABLENAME##", $tempTableName
        $newContent = $newContent -replace "##INSERT_COLUMNS##", $insertColumns
        $newContent = $newContent -replace "##SELECT_COLUMNS##", $selectColumnsText

        $newContent | Set-Content -Path $pgpath -Encoding UTF8

        Write-Host "$csvname.pg generated" -ForegroundColor Green
        return $true
      } else {
              Write-Host "Could not find column definitions in the template." -ForegroundColor Red
              return $false
          }
    } else {
        Write-Host "$templatepath not found" -ForegroundColor Red
        return $false
    }
}

function Get-PathType {
    param(
        [string]$path
    )
    if (Test-Path -Path $path) {
        if ((Get-Item -Path $path).PSIsContainer) {
            return "Directory"
        }
        else {
            return "File"
        }
    }
    else {
        return $null
    }
}

Write-Host "path: $path"
# Make-PG -csvpath $path
$type = Get-PathType -path $path
Write-Host "$type"
switch ($type) {
  "File" {
      Make-PG -csvpath $path
  }
  "Directory" {
      Get-ChildItem -Path $path -Filter "*.csv" | ForEach-Object {
          Make-PG -csvpath $_.FullName
      }
  }
  Default {
  # Pas de .pg trouvés
  Write-Host "$path non trouvé" -ForegroundColor Red
  }
}
