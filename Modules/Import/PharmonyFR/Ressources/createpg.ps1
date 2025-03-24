param (
  [string]$path = (Get-Location).Path
)
<#
  Le script prend le chemin du répertoire où se trouvent les csv.
  Si il n'est pas renseigné, par défaut, le chemin sera celui du répertoire courant, là où le script est exécuté.
#>

$reserved = @{
  "user" = "_user"
  "default" = "_default"
}

$template = @"
CREATE OR REPLACE FUNCTION FCTCREATE%%TABLE%%(CSVFILE text) RETURNS integer
AS `$`$
DECLARE %%TABLE%%exists BOOLEAN;
BEGIN
        SELECT EXISTS into %%TABLE%%exists (
           SELECT FROM information_schema.tables
           WHERE  table_schema = 'public'
           AND    table_name   = '%%TABLE%%'
        );

        if %%TABLE%%exists then
           drop table %%TABLE%%;
        end if;
        
        CREATE TABLE public.%%TABLE%%
            (
        %%FIELDS%%
    )
            WITH (
                OIDS = FALSE
            )
            TABLESPACE pg_default;

        execute 'COPY %%TABLE%%(
            %%CSVFIELDS%%
        )
            from ''' || `$1 || '''
            DELIMITER '',''
            CSV HEADER';

            return 0;
END;
`$`$ 
LANGUAGE PLPGSQL;
"@

function cleanCSV {
  param(
    [string]$table
  )
  # On vérifie si la première ligne contient le mot 'PHARMONY ONE'
  $firstline = Get-Content -Path $table | Select-Object -First 1
  if ($firstline -match 'PHARMONY ONE') {
    #  Si c'est le cas, le CSV n'est pas correctement formaté, il faut le "nettoyer"
    $origine = $table
    $destination = "$([System.IO.Path]::GetFileNameWithoutExtension($origine)).csv0"
    Write-Host "   Nettoyage de $origine" -ForegroundColor Green
    Get-Content -Path $origine | Select-Object -Skip 1 | Out-File $destination -encoding utf8
    Move-Item -Path $destination -Destination $origine -Force -ErrorAction SilentlyContinue
  }
   $csv = Import-Csv -Path $table
   $csv | Export-Csv -Path $table -Delimiter ',' -NoTypeInformation -Force
} 

function updateHeaders {
  param(
  [string]$table,
  [string[]]$fields
  )

  $headers = $fields -join ','
  $content = Get-Content -Path $table | Select-Object -Skip 1 
  $headers + "`n" + $content | Out-File -FilePath $table -Force
}

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8 

Write-Host "path : $path"

if (Test-Path -Path $path -PathType Container) {
  #  Récupération de TOUS les fichiers CSV du répertoire traité
  $files = Get-ChildItem -Path $path -Filter "*.csv"
  foreach ($file in $files) {
    $table = $file.FullName
    $tablename = [System.IO.Path]::GetFileNameWithoutExtension($table)
    cleanCSV -table $table # Nettoyage du CSV si besoin
    $fields = (Get-Content -Path $table | Select-Object -First 1) -split ',' 
    $headersChanged = $false
    $fields = $fields | ForEach-Object {
      if ($reserved.ContainsKey($_.ToLower())) {
         $reserved[$_.ToLower()]
         $headersChanged = $true
      }
      else {
        $_
      }
    }
    if ($headersChanged) {
      updateHeaders -table $table -fields $fields
    }
    # Extraction des champs du CSV
    $csvfields = $fields -join ',' # Création de la liste des champs pour le COPY
    $fields = $fields | ForEach-Object { "    $_ text" } # Création des champs pour la création de la table
    # $fields = $fields.TrimEnd(",")
    $fields = $fields -join ",`n"
    $destination = "$([System.IO.Path]::GetFileNameWithoutExtension($table)).pg"
    ($template -replace '%%TABLE%%', $tablename -replace '%%FIELDS%%', $fields -replace '%%CSVFIELDS%%', $csvfields) | Out-File -FilePath "$destination" # Création du script pg 
    Write-Host "Script $destination créé"
  }
}
else {
  Write-Host "Le chemin $path n'existe pas"
}



