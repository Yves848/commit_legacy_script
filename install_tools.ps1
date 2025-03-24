function isGumInstalled {
  $gum = Get-Command -CommandType Application -Name gum -ErrorAction SilentlyContinue
  if ($gum) {
    return $true
  }
  return $false
}

function  ispsCandyInstalled {
  $CLI = Get-Module -ListAvailable -Name psCandy
  if ($CLI) {
    return $true
  } 
  return $false
}

function installGum {
  $command = "winget install --id charmbracelet.gum -v 0.13.0"
  Invoke-Expression $command | Out-Null
  $env:path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

if (-not (isGumInstalled)) {
  installGum
}

if (-not (ispsCandyInstalled)) {
 Install-Module -Name psCandy -Force -Scope CurrentUser
 $env:path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}