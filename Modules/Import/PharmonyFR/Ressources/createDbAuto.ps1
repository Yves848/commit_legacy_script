param (
  [string]$PASS = "postgres",
  [string]$USER = "postgres",
  [string]$DB = "test"
)

[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$service = Get-WmiObject -Class Win32_Service -Filter "Name='postgrescommit'"
if ($null -ne $service) {
  Start-Service -Name "postgrescommit"

  if ($service.State -ne "Running") {
    Start-Service -Name "postgrescommit"
  }

  $env:PGPASSWORD = $PASS
  $path = $env:Path -split ";"
  $path += "c:\opt\pgsql\bin\"
  $env:Path = $path -join ";"
  Invoke-Expression "c:\opt\pgsql\bin\createuser.exe -s postgres" | Out-Null
  Invoke-Expression "c:\opt\pgsql\bin\createdb.exe -U $USER -w -E UTF8 -T template0 $DB" | Out-Null
  Invoke-Expression "c:\opt\pgsql\bin\psql.exe -U $USER -w -d $DB -f 'dump.sql'" | Out-Null
}
else {
  Write-Host "Le service postgrescommit n'est pas installé"
}