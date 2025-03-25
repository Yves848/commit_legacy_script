$path = (Get-Location).Path


get-version {
  param(
    [string]$path
  )
    [xml]$proj = Get-content -Path $path
    $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo
}


function Get-Dproj {
  param (
    [string]$loc
  )
  $list = Get-ChildItem -Path . -Recurse -Filter "*.dproj"
  $result = 
  $list = $list | Where-Object { -not $_.FullName.Contains("Composant") }
  $dproj = [System.Collections.Generic.List[PSCustomObject]]@()
  $list | ForEach-Object {
    $verision = get-version -Path $_.FullName
  }
  return $list
}

Get-Dproj | select-object -ExpandProperty name | Format-SpectreTable
