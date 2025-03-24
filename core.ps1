# Chargement des fonctions de buildres.ps1


$Script:report = @()
$path = (Get-Location).Path
. "$path\buildres.ps1"

function Build-Env {
  param(
    [string]$SVN
  )
  if ($SVN) {
    $env:SVN = $SVN
  }
  else {
    $env:SVN = (Get-Location).Path
  }

  Write-Host "[core.ps1] Build-Env"
  Write-Host "[core.ps1] env:SVN >> $($env:SVN)"
  
  
  $env:BDS = "C:\Program Files (x86)\Embarcadero\RAD Studio\7.0"
  $env:BDSCOMMONDIR = "$($env:USERPROFILE)\Documents\RAD Studio\7.0"
  
  $env:COMMIT = "$($env:SVN)"
  $env:COMP = "$($env:SVN)\composants"

  $searchPath = @()
  $searchPath += "C:\Program Files (x86)\Devart\ODAC for RAD Studio 2010\Bin"
  $searchPath += "C:\Program Files (x86)\Devart\ODAC for RAD Studio 2010\Lib"
  $searchPath += "$($env:BDS)\Imports"
  $searchPath += "$($env:BDS)\include"
  $searchPath += "$($env:BDS)\lib"
  $searchPath += "$($env:BDS)\Lib\Indy10"
  $searchPath += "$($env:COMMIT)\bin"
  $searchPath += "$($env:COMP)\Autres\PerlRegex"
  $searchPath += "$($env:COMP)\zlib"
  $searchPath += "$($env:COMMIT)\Lib"
  $searchPath += "$($env:COMP)\AccesBD\DISQLite\D2010"
  $searchPath += "$($env:COMP)\Bin"
  $searchPath += "$($env:COMP)\Lib"
  $searchPath += "$($env:COMP)\Librairies\jcl\lib\d14"
  $searchPath += "$($env:COMP)\Librairies\jcl\source\include"
  $searchPath += "$($env:COMP)\Librairies\jvcl\common"
  $searchPath += "$($env:COMP)\Librairies\jvcl\lib\D14"
  $searchPath += "$($env:COMP)\Librairies\jvcl\Resources"
  $searchPath += "$($env:COMP)\Librairies\jwa\Common"
  $searchPath += "$($env:COMP)\Librairies\jwa\Includes"
  $searchPath += "$($env:COMP)\Librairies\jwa\Packages\bds10"
  $searchPath += "$($env:COMP)\pi\PIClasses"
  $searchPath += "$($env:COMP)\pi\PIDB"
  $searchPath += "$($env:COMP)\pi\PILGPI"
  $searchPath += "$($env:COMP)\Librairies\jwa\Win32API"
  $searchPath += "$($env:COMP)\Librairies\Imaging"
  $searchPath += "$($env:COMP)\Librairies\Imaging\JpegLib"
  $searchPath += "$($env:COMP)\Librairies\Imaging\Zlib"
  $env:DCC_UnitSearchPath = $searchPath -join ";"
  # Write-Host "[core.ps1] env:DCC_UnitSearchPath >> $($env:DCC_UnitSearchPath)"
  <#
  Indiquer l'emblacement du framework .Net spécifique à notre MSBuild.
#>

  $FrameworkDir = 'C:\Windows\Microsoft.NET\Framework\v2.0.50727'
  $env:FrameworkVersion = 'v2.0.50727'
  #$env:FrameworkSDKDir = ''
  $path = [regex]::Escape($FrameworkDir)
  if (-not ($arrPath -match "v2.0.50727")) {
    $arrPath = $env:Path -split ';'
    $env:Path = ($arrPath + $FrameworkDir) -join ';'
  }
  $env:LANGDIR = 'EN'

  
}

function Get-Health {
  Write-Host "USER : $env:USERNAME"
  if (([string]$env:USERNAME).ToLower().Contains("jenkins")) {
    Write-Host "  => Build on Jenkins Slave"
  }
  else {
    Write-Host "  => Build in Dev Environment"
  }

  Write-Host "------------------Environment Variables------------------------"
  Write-Host "`$env:BDS          = $env:BDS"
  Write-Host "`$env:BDSCOMMONDIR = $env:BDSCOMMONDIR"
  Write-Host "`$env:SVN          = $env:SVN"
  Write-Host "`$env:COMP         = $env:COMP"
  Write-Host "`$env:COMMIT       = $env:COMMIT"
  Write-Host "-------------------Environment Path----------------------------"
  $env:path -split ";" | ForEach-Object {
    Write-Host $_
  }
  Write-Host "-----------------------Search  Path----------------------------"
  $env:DCC_UnitSearchPath -split ";" | ForEach-Object {
    Write-Host $_
  }
  Write-Host "-----------------------Version Powershell----------------------"
  $PSVersionTable
}

<#
  Générer un nom unique pour le fichier de log.
#>
$datelog = Get-Date -UFormat "%Y-%m-%d_%H-%M"
$logfile = "build_$($datelog).log"

<#
  Fonction : Build-Project
  Paramètre : fichier .dproj à compiler

  Appelle MSBuild pour le projet (.dproj) passé en paramètre.
  Affiche éventuellement un retour écran et écrit dans le log si une erreur est rencontrée.
  En cas d'erreur, stoppe l'exécution du script et renvoit un "LASTEXITCODE" = 5
#>
function Build-Project(
  [string]$comp,
  [switch]$res
) {
  $global:LASTEXITCODE = 0
  
  Write-Host ">>> Build Project"
  Write-Host "  >>> `$comp : $($comp)"
  if ($true -eq $res) {
    if ([System.IO.Path]::GetExtension($comp) -eq ".dproj") {
      $resFile = [System.IO.Path]::ChangeExtension($comp, '.res')
      Remove-Item -Path $resFile -Force -ErrorAction SilentlyContinue
      Write-Host "    >>> Build $($resFile)"
      Build-Res -dproj $comp
    }
  }

  if (Test-Path -Path $comp) {
    $project = $(Split-Path $comp -Leaf).PadLeft(25, " ")
    $log = Invoke-Expression "msbuild `"$($comp)`" /p:config=Release"
  
    if ($LASTEXITCODE -eq 0) {
      Write-Host "Build of $($project) Successfull"
    }
    else {
      Write-Host "Build of $($project) Failed"
      $log | Out-File -FilePath $logfile -Append -Encoding utf8
      Write-Host "      >>> Project $project not built"
      Write-Host "      >>> Details in $logfile"
      Get-Content -Path $logfile | Out-Host
      Exit 5
    }
  }
  else {
    Write-Host "      >>> ERROR.  $($comp) not found"
    Write-Host "      >>> Project $project not built"
    EXIT 10
  }
}

function CheckDelphiRunning {
  $bds = Get-Process -Name bds -ErrorAction SilentlyContinue
  if ($null -ne $bds) {
    Write-Host "Delphi is running. Please close it before building."
    Exit 1
  }
}

<#
  Fonction : Build-Components
  Paramètre : Aucun

  Appelle Build-Project pour chaque jeu de composants nécessaire à COMMIT
  La Gestion des erreurs est réalisée dans Build-Project
#>
function Build-Components {
  CheckDelphiRunning
  Build-Project "$($env:COMP)\Librairies\jcl\packages\JclPackagesD140.groupproj"
  Build-Project "$($env:COMP)\Librairies\jcl\packages\JclPackagesD140std.groupproj"
  Build-Project "$($env:COMP)\Librairies\jvcl\packages\D14 Packages.groupproj"   
  Build-Project "$($env:COMP)\Librairies\jvcl\packages\D14 Packages Std.groupproj"   
  Build-Project "$($env:COMP)\pi\PI.groupproj"   
  Build-Project "$($env:COMP)\pi\PIStd.groupproj"   
  Build-Project "$($env:COMP)\Autres\Autres.groupproj"   
  Build-Project "$($env:COMP)\Autres\AutresStd.groupproj"   
  Build-Project "$($env:COMP)\Librairies\Mustangpeak\MP.groupproj"   
  Build-Project "$($env:COMP)\Librairies\Mustangpeak\MPStd.groupproj"   
  Build-Project "$($env:COMP)\AccesBD\zeosdbo\packages\Delphi2010\ZeosDbo.groupproj"   
  # Build-Project "$($env:COMP)\AccesBD\zeosdbo\packages\Delphi2010\ZComponentDesign.groupproj"   
  Build-Project "$($env:COMP)\AccesBD\BD.groupproj" 
  Build-Project "$($env:COMP)\AccesBD\BDStd.groupproj" 
  Build-Project "$($env:COMP)\Autres\Abbrevia 5.0\packages\Delphi 2010\Abbrevia.dproj"   
  Build-Project "$($env:COMP)\Autres\Abbrevia 5.0\packages\Delphi 2010\AbbreviaVCL.dproj"   
  Build-Project "$($env:COMP)\Autres\Abbrevia 5.0\packages\Delphi 2010\AbbreviaVCLDesign.dproj"   
}

<#
  Fonction : Build-Commit
  Paramètre : Aucun

  Se base sur le fichier commit.groupproj avin de réaliser un build COMPLET de l'application.
  REMARQUE : L'ancienne fonction appelait MSBUILD sur le .groupproj. Cependant, afin d'avoir un contrôle plus fin sur les éventuelles erreurs de build, 
  le XML (.groupproj) est parsé et les .dproj sont compilés un par un (dans le bon ordre).
  Mais avec cette méthode, on peut stopper le build dès qu'une erreur est rencontrée => gain de temps.
#>
function Build-Commit {
  $excludedProjects = @(
    "Modules\Transfert\transfertyzy\transfertyzy.dproj",
    "Modules\Commit\ModuleTransfertYzy\ModuleTransfertyzy.dproj",
    "Modules\Import\DynaCaisse\DynaCaisse.dproj",
    "Modules\Import\XLSoft\XLSoft.dproj",
    "Modules\Import\EsculapeV6\esculapev6.dproj"

)
  Remove-Item -Path "$($env:COMMIT)\bin" -Recurse -Force -Confirm:$false -ErrorAction Ignore
  $group = ([XML](Get-Content "$($env:COMMIT)\COMMIT.groupproj"))
  $group.Project.ItemGroup.Projects | ForEach-Object {
    $projectPath = "$($env:COMMIT)\$($_.Include)"
    if ($excludedProjects -notcontains $_.Include) {
      Build-Project $projectPath -res
  } else {
      Write-Output "Projet exclu : $projectPath"
  } 
  }
}

<#
  Fonction : Show-ModuleOrder
  Paramètre : Aucun

  Affiche la liste des .dproj dans l'ordre où ils seront compilés
#>
function Show-ModuleOrder {
  $group = ([XML](Get-Content "$($env:COMMIT)\COMMIT.groupproj"))
  $index = 1
  Write-Host " -- Build Order --"
  $group.Project.ItemGroup.Projects | ForEach-Object {
    Write-Host "   $($index) : $($env:COMMIT)\$($_.Include))"
    $index++
  }
}

<#
  Fonction : Build-Dependencies
  Paramètre : Aucun

  !!!!! A n'exécuter que sur une machine de dev officielle !!!!!

  Génère un .zip contenant les bpl "runtime" de Delphi qui ne sont pas présente sur la machine de build
  du fait qu'on n'a pas utilisé l'ISO pour installer;
#>

function Build-Dependencies {
  $files = @(
    @{
      path  = "$env:BDS\bin"
      files = @("designide140.*")
    }
    @{
      path  = "$env:SystemRoot\sysWOW64"
      files = @("Indy*140.bpl", "adortl140.bpl", "bdertl140.bpl", "dbrtl140.bpl", "rtl140.bpl", "dsnap*140.bpl", "tee*140.bpl", "vcl140.bpl", "vclactnband140.bpl",
        "vcldb140.bpl", "vclimg140.bpl", "vclsmp140.bpl", "vclx140.bpl", "xmlrtl140.bpl")
    }
  )
  Write-Host "Dependecies"
  $files | ForEach-Object {
    $path = $_.path
    $_.files | ForEach-Object {
      Write-Host "$path\$_"
      Compress-Archive -DestinationPath "dependencies.zip" -Path "$path\$_" -Update
    }
  }
}

<#
  Fonction : Copy-Dependencies
  Paramètre : Aucun

  A exécuter à la fin du build, copie tous les bpl supplémentaires issus de la compilation des composants.

#>
function Copy-Dependencies {
  Write-Host "Copy dependencies ....."
  $files = @(
    @{
      path  = "C:\Program Files (x86)\Devart\ODAC for RAD Studio 2010\Bin"
      files = @("?dac*140.bpl")
    }
    @{
      path  = "$($env:COMP)\Bin"
      files = @("*.bpl")
    }
    @{
      path  = "$($env:COMP)"
      files = @(".\postgresql.zip")
    }
  )
  $files | ForEach-Object {
    $path = $_.path
    $_.files | ForEach-Object {
      Copy-Item -Path "$path\$_" -Destination "$($env:COMMIT)\bin\"
      Write-Host "+++ Copy $($_)"
    }
  }
}

<#
  Fonction : Expand-ThirdParties
  Paramètre : Aucun

  Décompresse les dépendances externes à commit (Third Party).
#>
function Expand-ThirdParties {
  $old = $global:ProgressPreference
  $global:ProgressPreference = 'SilentlyContinue';
  $zip = Get-ChildItem -Path "$($env:SVN)\*.zip"
  $zip | ForEach-Object { 
    Write-Host "Expand From $($_.FullName) To $($env:SVN)\bin"
    Expand-Archive -Path $_.FullName -DestinationPath $env:SVN\bin -Force
  }
  $global:ProgressPreference = $old
}

function Get-DprojVersions {
  $group = ([XML](Get-Content "$($env:COMMIT)\COMMIT.groupproj"))
  $group.Project.ItemGroup.Projects | ForEach-Object {
    [XML]$project = ([XML](Get-Content "$($env:COMMIT)\$($_.Include)"))  
    $nodes = ($project.Project.ProjectExtensions.BorlandProject.'Delphi.Personality'.VersionInfoKeys).GetEnumerator()
    while ($nodes.movenext()) {
      $node = $nodes.current
      if ($node.name -eq "FileVersion") {
        Write-Host "$($env:COMMIT)\$($_.Include) => Version : $($node."#text")" 
      }
        
    }
  }
}


function Send-FTP {
  $ftp = "ftp://repf.groupe.pharmagest.com/dev"
  $user = "admin_ftp" 
  $pass = "admin_ftp"
  $webclient = New-Object System.Net.WebClient
  $webclient.Credentials = New-Object System.Net.NetworkCredential($user, $pass)
  $directoryName = [System.IO.Path]::GetFileName($env:COMMIT)
  Write-Host "Sending $ftp/$directoryName.zip to FTP"
  $webclient.UploadFile("$ftp/$directoryName.zip ", "$($env:COMMIT)\$directoryName.zip")
  $webclient.Dispose()
}

function Compress-Bin {

  $directoryName = [System.IO.Path]::GetFileName($env:COMMIT)

  $zip = "$($env:COMMIT)\$directoryName.zip"
  if (Test-Path -Path $zip) {
    Remove-Item -Path $zip -Force
  }
  Write-Host "Compressing $($env:COMMIT)\bin\ to $zip"
  Compress-Archive -Path "$($env:COMMIT)\bin\*" -DestinationPath $zip -Force
}


<#
  Switch principal => décide de ce qui est compilé sur base du paramètre $projet
#>
#Get-Health


