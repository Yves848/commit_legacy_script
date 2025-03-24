$env:path = ($env:path + ";" + (Get-Location).path)
$script:width = $host.UI.RawUI.WindowSize.Width - 2
$script:height = $host.UI.RawUI.WindowSize.Height - 2
. $((Get-Location).Path)\gumenv.ps1
. $((Get-Location).Path)\classes.ps1


$get_dblist = 'SELECT datname FROM pg_database WHERE datistemplate = false';
$get_db_age = 'select stats_reset from pg_stat_database where datname=''%s''';
$get_db_size = 'SELECT pg_size_pretty(pg_database_size(''%s'')) as size';
$drop_db = 'DROP DATABASE IF EXISTS "%s";';

function Get-Postgres {
  $ftp = "ftp://repf.groupe.pharmagest.com/pgInstall"
  $user = "admin_ftp" 
  $pass = "admin_ftp"
  $webclient = New-Object System.Net.WebClient
  $webclient.Credentials = New-Object System.Net.NetworkCredential($user, $pass)
  $localpath = (Get-Location).Path
  $webclient.Downloadfile($ftp + "/postgresql.zip", "$localpath\postgres.zip")
 
  $webclient.Dispose()
}

function Install-Postgres {

}

function Remove-Postgres {

}

function Get-DatabaseList {
  $cmd = "psql.exe -U postgres -w"
  $tables = Invoke-Expression "$script:pgPath\$cmd -t -c `"$get_dblist`"" 
  return $tables
}

function Get-PostgresVersion {
  $cmd = "psql.exe -V"
  $version = (Invoke-Expression "$script:pgPath\$cmd") -match "(\d+\.\d+)"
  if ($version) {
    return $Matches[1]
  }
  else {
    return "Version non trouvée"
  }
}

function displayTitle {
  param (
    [PSObject]$service
  )
  $script:pgPath = [System.IO.Path]::GetDirectoryName(($service.pathName -split " ")[0]).TrimEnd("`"").TrimStart("`"")
  # Write-Host "$script:pgPath"
  $titreG = "Commit - Utilitaires Postgresql" 
  $titreD = "v$(Get-PostgresVersion)"
  if ($service.State -eq "Running") {
    $lenD = ($titreD + " (Running)").Length
    $titreD = $titreD + (gum style " (Running)" --foreground="#00FF00")
  }
  $titre = $titreG + "".PadLeft((($script:width - $titreG.Length) - $lenD), " ") + $titreD
  gum style $titre --width $script:width --height 1 --border rounded
}

function menuPostgres {
  $service = Get-Postgres
  Clear-Host
  displayTitle -service $service
  while ($true) {
    $options = @("Stop Postgres Service", "Start Postgres Service", "Install Postgres", "Uninstall Postgres", "Back")
    $menu = @()
    if ($service) {
      if ($service.State -eq "Running") {
        $menu += $options[0]
      }
      else {
        $menu += $options[1]
      }
      $menu += $options[3]
    }
    else {
      $menu += $options[2]
    }
    $menu += $options[4]
    

    $choix = $menu -join "`n" | gum choose #  Get-DatabaseList | gum choose
    $index = $options.IndexOf($choix)
    switch ($index) {
      0 {
        $service.StopService()
        $service = Get-Postgres
      }
      1 { 
        
      }
      2 {
        
      }
      3 {
        
      }
      4 {
        Clear-Host
        $index = -1
      }
      default {
        Clear-Host
        $index = -1
      }
    }
    if ($index -eq -1) {
      break
    }
  }
}

function Get-Postgres {
  $service = Get-WmiObject -Class Win32_Service -Filter "Name='postgresqlcommit'"
  return $service
}
# $service = Get-WmiObject -Class Win32_Service -Filter "Name='NomDuService'"
while ($true) {
  Clear-Host
  # Get-Postgres
  $service = Get-Postgres
  if ($service) {
    displayTitle -service $service
    $menu = @("Postgres Management", "Databases Management", "Backup Restore", "Quit")
    $choix = $menu -join "`n" | gum choose #  Get-DatabaseList | gum choose
    $index = $menu.IndexOf($choix)
    switch ($index) {
      0 {
        menuPostgres 
      }
      1 { 
        Get-DatabaseList
      }
      2 {
      
      }
      3 {
        Exit(0)
      }
      default {
        Clear-Host
        exit(1)
      }
    }
  }
}
else {
  $title = "Le service postgresqlcommit n'est pas installé"
  
}
