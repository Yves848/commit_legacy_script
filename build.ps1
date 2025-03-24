param(
  # [ValidateSet("commit", 
  #   "groupementmenu", 
  #   "cession", 
  #   "moduleimport", 
  #   "projet", 
  #   "dist", 
  #   "lgo2",
  #   "importlgpi",
  #   "transfertlgpi",
  #   "infosoft", 
  #   "composants", 
  #   "all", 
  #   "Dependencies",
  #   "Expand",
  #   "check-versions")]
  [string]$Projet,
  [switch]$Verbose,
  [switch]$nozip,
  [switch]$noftp,
  [switch]$noComp,
  [string]$SVN,
  [string]$BDSCOMMONDIR
) 

<#
  Déclarations des variables globales et "visuelles"
#>
if ($SVN) {
  $sourcedir = $SVN
}
else {
  # $sourcedir = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)   
  $sourcedir = (Get-Location).Path
}


# Chargement des fonctions de buildres.ps1
# . "$sourcedir\buildres.ps1"
. "$sourcedir\core.ps1"

Build-Env

switch ($projet) {
  # 'commit' { Build-Project "$($env:SVN)\commit_legacy\Modules\Commit\commit.dproj" }
  # 'lgo2' { Build-Project "$($env:SVN)\commit_legacy\Modules\Import\lgo2\lgo2.dproj" }
  # 'infosoft' { Build-Project "$($env:SVN)\commit_legacy\Modules\Import\infosoft\infosoft.dproj" }
  # 'groupementmenu' { Build-Project "$($env:SVN)\groupementmenu\groupementmenu.dproj" }
  # 'cession' { Build-Project "$($env:SVN)\projetcession\projetcession.dproj" }
  'moduletransfert' { Build-Project "$($env:SVN)\Modules\Commit\ModuleTransfert\ModuleTransfert.dproj" }
  # 'projet' { Build-Project "$($env:SVN)\commit_legacy\Modules\Commit\Projet.dproj" }
  'importlgpi' { Build-Project "$($env:SVN)\Modules\Import\importlgpi\importlgpi.dproj" }
  'transfertlgpi' { Build-Project "$($env:SVN)\Modules\Transfert\transfertlgpi\transfertlgpi.dproj" }
  'transferultimate' { Build-Project "$($env:SVN)\Modules\Transfert\transfertultimate\transfertUltimate.dproj" }
  'nev' { Build-Project "$($env:SVN)\Modules\Import\NEV\NEV.dproj" }
  'wpharma' { Build-Project "$($env:SVN)\Modules\Import\Winpharma\winpharma.dproj" }
  'pharmalandv7' { Build-Project "$($env:SVN)\Modules\Import\PharmalandV7\PharmalandV7.dproj" }
  'visiopharm' { Build-Project "$($env:SVN)\Modules\Import\Visiopharm\Visiopharm.dproj" }
  'Dependencies' {
    Build-Dependencies
    Copy-Dependencies
  }
  'composants' {
    Build-Components
  }
  'dist' {
    CheckDelphiRunning
    if ($noComp -ne $true) { Build-Components }
    Show-ModuleOrder
    Build-Commit
    Copy-Dependencies
    Expand-ThirdParties
    if ($nozip -ne $true) { Compress-Bin }
    if ($noftp -ne $true) { Send-FTP }
  }
  'Expand' {
    Expand-ThirdParties
  }
  'all' {
    Build-Components
    Build-Commit
  }
  'check-versions' {
    Get-DprojVersions
  }
  Default {}
}
