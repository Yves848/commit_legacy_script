$path = (Get-Location).Path

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class WinAPI {
    [DllImport("user32.dll")]
    public static extern int ShowWindow(IntPtr hWnd, int nCmdShow);
    
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
}
"@

function maximize {
  # 3 = Maximiser la fenêtre
  $SW_MAXIMIZE = 3
  $hWnd = [WinAPI]::GetForegroundWindow()
  [WinAPI]::ShowWindow($hWnd, $SW_MAXIMIZE)
}

function restore {
  $SW_RESTORE = 9
  $hWnd = [WinAPI]::GetForegroundWindow()
  [WinAPI]::ShowWindow($hWnd, $SW_RESTORE)
}

<#
  get-version
  read the 4 values of the dproj version
  return a PSCustomObject
    @{"MajorVer" = "x"; "MinorVer" = "x"; "Realease" = "x"; "Build" = "x" }
#>
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
    [xml]$proj = Get-Content -Path $path
    $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[2]."#text" = $version.MajorVer
    $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[3]."#text" = $version.MinorVer
    $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[4]."#text" = $version.Realease
    $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo.VersionInfo[5]."#text" = $version.Build
    $proj.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfoKeys.VersionInfoKeys[2]."#text" = "$($version.MajorVer).$($version.MinorVer).$($version.Realease).$($version.Build)"
    $proj.OuterXml | Out-File $path
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
  set-version -path $path -version $version
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

function display-dproj {
  maximize
  Clear-Host  
  if (get-module pwshspectreconsole  -ListAvailable) {
    Get-Dproj -loc . | Format-SpectreTable
  } else {
    Get-Dproj -loc .
  }
  Read-Host
  restore
}