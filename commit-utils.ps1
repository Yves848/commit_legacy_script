$path = (Get-Location).Path


function get-version {
  param(
    [string]$path
  )
  [xml]$proj = Get-Content -Path $path
  try {
    $MajorVer = $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[2]."#text"
    $MinorVer = $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[3]."#text"
    $Realease = $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[4]."#text"
    $Build = $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[5]."#text"  
  }
  catch {
    $MajorVer = "0"
    $MinorVer = "0"
    $Realease = "0"
    $Build = "0"
  }

  return @{"MajorVer" = $MajorVer; "MinorVer" = $MinorVer; "Realease" = $Realease; "Build" = $Build }
}

function set-version {
  param (
    [string]$path,
    [PSCustomObject]$version
  )

  if (Test-Path -Path $path) {

  }
}

function increment-version {
  param (
    [string]$path
  )
  if (Test-Path -Path $path) {
    $version = get-version -path $path
    $version.build = $version.build + 1
    set-version -path $path -version $version
  }
}


function Get-Dproj {
  param (
    [string]$loc
  )
  $list = Get-ChildItem -Path . -Recurse -Filter "*.dproj"
  $list = $list | Where-Object { -not $_.FullName.Contains("Composant") }
  $dproj = [System.Collections.Generic.List[PSCustomObject]]@()
  $list | ForEach-Object {
    $version = get-version -Path $_.FullName
    $v = "$($version.MajorVer).$($version.MinorVer).$($version.Realease).$($version.Build)"
    $dproj.Add(@{"dproj" = $_.Name; "Version" = $v })
  }
  return $dproj
}

get-version -path .\Modules\Commit\COMMIT.dproj