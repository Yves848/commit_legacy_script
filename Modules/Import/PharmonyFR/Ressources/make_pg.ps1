param(
  [string]$path
)

function Make-PG {
  param(
    [string]$csvpath
  )
  $csvname = [System.IO.Path]::GetFileNameWithoutExtension($csvpath)
  $templatepath = "$PSScriptRoot\templates\$csvname.pg"
  if ((Test-Path -Path $templatepath) -eq $true) {
    $pgpath = "$PSScriptRoot\$csvname.pg"

    $headers = (Get-Content -Path $csvpath -TotalCount 1) -replace ";", ",`n"

    (Get-Content -Path $templatepath ) -replace "##FIELDS##", $headers |  Set-Content -Path $pgpath
    return $true
  }
  return $false
}

function Get-PathType {
  param(
    [string]$path
  )
  if ($true -eq (Test-Path -Path $path)) {
    return (Get-Item -Path $path).Attributes
  }
  else {
    return $null
  }
}
write-host "path: $path"
$type = Get-PathType -path $path
switch ($type) {
  "Archive" {
    if ((Make-PG -csvpath $path) -eq $true) {
      $name = [System.IO.Path]::GetFileNameWithoutExtension($path)
      Write-Host "$Name.pg généré" -ForegroundColor Green
    }
    
  }
  "Directory" {  
    Get-ChildItem -Path $path -Filter "*.csv" | ForEach-Object {

      if ((Make-PG -csvpath $_.FullName) -eq $true) {
        $name = [System.IO.Path]::GetFileNameWithoutExtension($_.FullName)
        Write-Host "$Name.pg généré" -ForegroundColor Green
      }
      

      
    }
  }
  Default {
    # Pas de .pg trouvés
    Write-Host "$path non trouvé" -ForegroundColor Red
  }
}

