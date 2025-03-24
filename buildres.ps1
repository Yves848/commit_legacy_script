<#
  Generate .RC file from .dproj and build .res
#>
function Build-Res {
  param(
    [parameter(Mandatory = $true)]
    [string]$dproj
  )

$template = @"
#define VER_MAJOR %MajorVer%  // Major version number
#define VER_MINOR %MinorVer%  // Minor version number
#define VER_RELEASE %Release%  // Release number
#define VER_BUILD %Build%  // Build number

MAINICON ICON "%icon%"

VS_VERSION_INFO VERSIONINFO
FILEVERSION VER_MAJOR, VER_MINOR, VER_RELEASE, VER_BUILD
PRODUCTVERSION VER_MAJOR, VER_MINOR, VER_RELEASE, VER_BUILD
FILEFLAGSMASK 0x3fL
//#ifdef _DEBUG
//FILEFLAGS 0x1L // VS_FF_DEBUG
//#else
FILEFLAGS 0x0L // VS_FF_PRERELEASE
//#endif
FILEOS 0x4L // VOS_NT_WINDOWS32
FILETYPE %FileType%
// FILETYPE 0x2L // VFT_DLL
// FILETYPE 0x1L // VFT_APP
FILESUBTYPE 0x0L // VFT2_UNKNOWN

BEGIN

    BLOCK "StringFileInfo"
    BEGIN
        BLOCK "040C04E4" // FR-FR
        BEGIN
            VALUE "CompanyName", "%CompanyName%\000"
            VALUE "FileDescription", "%FileDescription%\000"
            VALUE "FileVersion", "%MajorVer%.%MinorVer%.%Release%.%Build%\000"
            VALUE "InternalName", "%InternalName%\000"
            VALUE "LegalCopyright", "Copyright 2024 Equasens\000"
            VALUE "OriginalFilename", "Commit\000"
            VALUE "ProductName", "Commit %MajorVer%.%MinorVer%\000"
            VALUE "ProductVersion", "%MajorVer%.%MinorVer%.%Release%.%Build%\000"
            VALUE "Pays", "%Pays%\000"
        END
    END

    BLOCK "VarFileInfo"
    BEGIN
        VALUE "Translation", 0x40C, 1252 // FR-FR
    END
END
"@

  $rcFile = [system.IO.Path]::ChangeExtension($dproj, '.rc')

  Write-Host "[buildres.ps1] rfcile : $rcFile"
  [xml]$xml = Get-Content -Path $dproj
  $versionInfoKeys = [ordered]@{}
  $versionInfo = [ordered]@{}
  $nodes = ($xml.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfoKeys).GetEnumerator()
  while ($nodes.movenext()) {
    $node = $nodes.current
    $versionInfoKeys.Add($node.Name, $node."#text")
  }
  $nodes = ($xml.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfo).GetEnumerator()
  while ($nodes.movenext()) {
    $node = $nodes.current
    $versionInfo.Add($node.Name, $node."#text")
  }
  if ($true -eq $app) {
    $FileType = 0x1L
  } else {
    $FileType = 0x2L
  }

  $rep_dest = [System.IO.Path]::GetDirectoryName($dproj)
  $index = ($env:SVN -split '\\').Length - 1
  $dest = ($rep_dest -split '\\')[0..$index] -join '\'
  $images = "$($dest)\images\" 
  $iconfile = $images + ([system.IO.Path]::GetFileNameWithoutExtension($dproj) + '.ico')
  if (Test-Path -Path $iconfile) {
    $icon = $iconfile
  } else {
    $icon = "$($images)commit.ico"
  }

  $rc = $template -replace '%MajorVer%', $versionInfo.MajorVer `
    -replace '%MinorVer%', $versionInfo.MinorVer `
    -replace '%Release%', $versionInfo.Release `
    -replace '%Build%', $versionInfo.Build `
    -replace '%CompanyName%', $versionInfoKeys.CompanyName `
    -replace '%FileDescription%', $versionInfoKeys.FileDescription `
    -replace '%InternalName%', $versionInfoKeys.InternalName `
    -replace '%Pays%', $versionInfoKeys.Pays `
    -replace '%FileType%', $FileType `
    -replace '%icon%', $icon 
    

  $rc | Out-File -FilePath $rcFile -Encoding ascii

  
  $command = "brcc32 -32 $($rcFile)"
  
  Invoke-Expression -Command $command | Out-Null
  # Remove-Item -Path $rcFile
}

Write-Host "[buildres.ps1] Loaded"