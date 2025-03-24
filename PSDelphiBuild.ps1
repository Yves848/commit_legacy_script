using namespace System.Management.Automation
using module psCandy

class ValidFilesGenerator : IValidateSetValuesGenerator {
  [string[]] GetValidValues() {
    $Values = Get-ChildItem -Path * -Filter *.dproj -Recurse | Where-Object { ($_.FullName -cmatch "Composants") -eq $false } | Select-Object { $_.BaseName }
    return $Values
  }
}

class delphiProject {
  [boolean]$Selected
  [string]$Name
  [string]$path
  [string]$FullName
  [Boolean]$group
  [boolean]$checked
}
$include = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition) 

# . "$include\gumEnv.ps1"
. "$include\core.ps1"

Build-Env


$width = $Host.UI.RawUI.WindowSize.Width - 2
function Get-ProjectList(
  [switch]$Groups,
  [string]$path = "*"
) {
  if ($Groups) {
    $filter = "*.*proj"
  }
  else {
    $filter = "*.dproj"
  }

  $Values = Get-ChildItem -Path $path -Filter $filter -Recurse | Where-Object { ($_.FullName -cmatch "Composants") -eq $false }
  return $Values
}

function Build-Selection(
  [PSCustomObject[]]$data
) {
  $datelog = Get-Date -UFormat "%Y-%m-%d_%H-%M"
  $global:logfile = "log_$($datelog)"

  # Get-DelphiEnv -Delphi Delphi2010
  # Build-SearchPath
  $data | ForEach-Object {
    $proj = $_.Text
    Build-Project -comp $proj -res
  }
  Start-Sleep -Seconds 2

}

function Build-SearchPath (
) {
  $path = Get-Location 
  $UnitSearch = Get-Content -Path "$($path.path)\\buildconfig.json" | Out-String | ConvertFrom-Json
  $searchPath = @()
  $UnitSearch.DCC_UnitSearchPath | ForEach-Object {
    $searchPath += $_
  }
  [Environment]::SetEnvironmentVariable("DCC_UnitSearchPath", $searchPath -join ";")
  if ($UnitSearch.SVN -eq '.') {
    $env:SVN = "$(Get-Location)"
  }
  else {
    $env:SVN = $UnitSearch.SVN
  }
  $env:COMMIT = "$($env:SVN)"
  $env:COMP = "$($env:SVN)\composants"
}

function Get-DelphiEnv(
  [ValidateSet('Delphi2010', 'Delphi11', 'Delphi12')]
  [String]$Delphi
) {
  switch ($Delphi) {
    'Delphi2010' {  
      $dpath = "C:\Program Files (x86)\Embarcadero\RAD Studio\7.0"
    }
    'Delphi11' {  
      $dpath = "C:\Program Files (x86)\Embarcadero\Studio\22.0"
      
    }
    'Delphi12' {  
      $dpath = "C:\Program Files (x86)\Embarcadero\Studio\23.0"
    }
    Default {
      Write-Host "This Module ONLY supports Delphi 2010, Delphi 11 and Delphi 12 "
    }
  }
  Build-DelphiEnv -dpath $dpath
}

function Build-DelphiEnv(
  [String]$dpath
) {
  [string[]]$rsvars = Get-Content -Path "$dpath\bin\rsvars.bat" -ErrorAction Stop
  ##Write-Host $rsvars
  $rsvars | ForEach-Object {
    if ($_.trim() -ne "") {
      $path = $_ -creplace "@SET", ""
      $var, $value = $path -split "="
      if ($var.trim() -cne 'PATH') {
        Write-Host "$var => $value"
        [Environment]::SetEnvironmentVariable($var.trim(), $value.trim())
      }
    }
  }
  $path = [regex]::Escape($env:FrameworkDir)
  if (-not ($arrPath -match $env:FrameworkVersion)) {
    $arrPath = $env:Path -split ';'
    $env:Path = ($arrPath + $env:FrameworkDir) -join ';'
  }
}

function Get-Projects {
  $path = (Get-Location).Path
  # Write-Host $path
  if ((Test-Path -Path "$($path)\commit.build") -eq $true) {
    $filter = "*.*proj"
    Get-ChildItem -Path $path -Filter $filter -Recurse | Where-Object { ($_.FullName -cmatch "Composants") -eq $false }
  }
  else {
    $header = New-BTHeader -Id 1 -Title "Build commit"
    New-BurntToastNotification -Text "Erreur", "Ceci n'est pas un répertoire commit_legacy" -AppLogo ~\Pictures\image.jpg -Header $header
    return $null
  }
}

function Show-ProjectList(
  [System.Array]$list
) {
  [Console]::Clear()
  [Console]::setcursorposition(0,0)
  # [Style]$Titre = [Style]::New("Choisir les projets à compiler")
  # $Titre.SetColor([colors]::Teal())
  # $Titre.SetBorder($true)
  # $Titre.setAlign([Align]::Center)
  # [Console]::WriteLine($Titre.Render())
  Write-Candy -Text "<Teal>Choisir les projets à compiler</Teal>" -Border "Rounded" -Align Center -Width ($Host.UI.RawUI.WindowSize.Width -2)
  # [System.Console]::setcursorposition(0,5)
  $items = [System.Collections.Generic.List[ListItem]]::new()
  $list | ForEach-Object {
    $group = $_.FullName -cmatch "groupproj"
    $item = ""
    if ($group -eq $true) {
      $item = "📦"
    }
    else {
      $item = "📄"
    }
    $items.Add([ListItem]::new($_.FullName, $_, $item, [Colors]::Green()))
      
  }
  $ItemsList = [List]::new($items)
  $Itemslist.SetHeight(15)
  $choice = $ItemsList.Display()
  return $choice
}


function Get-GitBranch {
  $branch = Invoke-Expression "git branch --show-current"
  $branch = "$([char]::ConvertFromUtf32(0xe0a0)) $($branch)"
  return $branch
}

# function Get-Title
# ([string]$titre) {
#   $path = (Get-Location).Path
#   $filler = "".PadLeft($width - $titre.Length - $path.Length, " ")
#   $line = "$titre$filler$path"
#   gum style --border "rounded" --width $width $line --border-foreground $($Theme["green"]) 
# }

function Show-Branches {
  # $branches = Invoke-Expression "git branch -a"
  # $branches = $branches -split "`n"
  # $width = $Host.UI.RawUI.WindowSize.Width - 2
  # gum style --border "rounded" --width $width "Choisir une branche" --border-foreground $($Theme["purple"]) 
  # $branch = $branches -join "`n" | gum filter  --no-limit --height 20 --placeholder "Search in the list"  --prompt "🔎 "
  # if ($branch) {
  #   $command = "git switch $($branch)"
  #   $status = Invoke-Expression "git status --short"
  #   if ($status -ne "") {
  #     $header = New-BTHeader -Id 1 -Title "Build commit"
  #     New-BurntToastNotification -Text "Attention", "Il y a des fichiers non commités", "Mise en stash" -AppLogo ~\Pictures\image.jpg -Header $header
  #     Invoke-Expression "git stash"
  #   }
  #   Invoke-Expression $command
  # }
  return
}

function Get-UnicodeCodePoint {
  param (
      [Parameter(Mandatory=$true)]
      [int]$HighSurrogate,
      
      [Parameter(Mandatory=$true)]
      [int]$LowSurrogate
  )

  # Calculate the code point using the formula
  $codePoint = 0x10000 + (($HighSurrogate - 0xD800) * 0x400) + ($LowSurrogate - 0xDC00)
  
  return $codePoint
}

function Show-UnicodeCharacter {
  param (
      [Parameter(Mandatory=$true)]
      [int]$HighSurrogate,
      
      [Parameter(Mandatory=$true)]
      [int]$LowSurrogate
  )
  
  # Get the Unicode code point
  $codePoint = Get-UnicodeCodePoint -HighSurrogate $HighSurrogate -LowSurrogate $LowSurrogate

  # Convert the code point to a character
  $character = [char]::ConvertFromUtf32($codePoint)

  # Display the character
  $character
}

function Show-CommitUtils {
  $continue = $true
  while ($continue) {
    Clear-Host
    # Get-Title "Commit Utils"
    [System.Console]::setcursorposition(0,0)
    $branch = Get-GitBranch
    $path = (Get-Location).Path
    [Style]$Title = [Style]::New("Commit Utils`n$($branch)")
    $Title.SetColor([colors]::Yellow())
    $Title.SetBorder($true)
    $Title.Render()
    [System.Console]::setcursorposition(0, 5)
    $exitColor = [Color]::new([Colors]::OrangeRed())
    $menu = [System.Collections.Generic.List[ListItem]]::new()
    $menu.Add([ListItem]::new("Choisir une branche", 1,[char]::ConvertFromUtf32(0xe0a0)))
    $menu.Add([ListItem]::new("Compiler des .dproj", 2,(Show-UnicodeCharacter -HighSurrogate 0xdb85 -LowSurrogate 0xdc0b))) # \udb85\udc0b
    $menu.Add([ListItem]::new("Choisir un .groupproj", 3,[char]::ConvertFromUtf32(0xe315))) #\ue315
    $menu.Add([ListItem]::new("Quitter", 4,(Show-UnicodeCharacter -HighSurrogate 0xdb83 -LowSurrogate 0xdfC5),[Colors]::Red())) #\udb83\udfc5
    
    $menuList = [List]::new($menu)
    $menuList.SetHeight(10)
    $menuList.SetLimit($True)
    $c = $menuList.Display() 
    if (-not $c) {
      $continue = $false
    }
    switch ($c.Value) {
      1 {
        Show-Branches
      }
      2 {  
        $list = Get-Projects
        if ($null -eq $list) {
          return
        }
        $tobuild = Show-ProjectList -list $list
        if ($tobuild) {
          Build-Selection -data $tobuild
        }
      }
      Default { 
        $continue = $false
      }
    }
  }
  Clear-Host
}

[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Show-CommitUtils