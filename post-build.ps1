param(
  [ValidateSet("cp_rss_commun", 
    "cp_rss_modules")]
  [string]$target,
  [parameter (Mandatory)]
  [string]$rep_dest,
  [string]$module,
  [string]$type_mod
)
<# 
 TODO: Pour garder une continuité avec l'ancien "ANT", j'ai gardé les même paramètres d'entrée pour le script. 
 Il faudrait les revoir pour les rendre plus explicites et surtout éliminer un maximum de chemins relatifs pour les rendre plus robustes.

 TODO: Supprimer TOUS les chemins relatifs et utiliser la même méthode que dans "Copy-ModuleResources"
#> 
<#
  Fixer les variables d'environnement.
#>
function Copy-CommonResources {
  Write-Host $target
  mkdir -Path "$($rep_dest)Aide" -ErrorAction Ignore | Out-Null
  mkdir -Path "$($rep_dest)Aide\Images" -ErrorAction Ignore | Out-Null
  mkdir -Path "$($rep_dest)Scripts" -ErrorAction Ignore | Out-Null
  mkdir -Path "$($rep_dest)Scripts\Commun" -ErrorAction Ignore | Out-Null
  mkdir -Path "$($rep_dest)Scripts\Modules" -ErrorAction Ignore | Out-Null

  Copy-Item -Path "$($rep_dest)..\Scripts\Commun\" -Destination "$($rep_dest)Scripts\" -Recurse -Filter "*" -ErrorAction Ignore
  Copy-Item -Path "$($rep_dest)..\Scripts\Modules\" -Destination "$($rep_dest)Scripts\" -Recurse -Filter "*.sql" -ErrorAction Ignore
  Copy-Item -Path "$($rep_dest)..\Aide" -Destination "$($rep_dest)" -Recurse -Filter "documentation*" -ErrorAction Ignore
}

function Copy-ModuleResources {
  mkdir -Path "$($rep_dest)\Ressources\$($module)" -ErrorAction Ignore | Out-Null
  mkdir -Path "$($rep_dest)..\..\Scripts" -ErrorAction Ignore | Out-Null
  mkdir -Path "$($rep_dest)..\..\Scripts\Modules\$($type_mod)" -ErrorAction Ignore | Out-Null
  
  Copy-Item -Path "$($rep_dest)..\..\..\Aide" -Destination "$($rep_dest)..\..\Aide" -Recurse -Filter "*$($module).*" -ErrorAction Ignore
  Copy-Item -Path "$($rep_dest)..\..\..\Scripts\Modules\$($type_mod)\$($module)*.sql" -Destination "$($rep_dest)..\..\Scripts\Modules\$($type_mod)"  -ErrorAction Ignore

  if (Test-Path -Path "$($rep_dest)..\..\..\Modules\$($type_mod)\$($module)\Ressources") {
    $index = ($env:SVN -split '\\').Length - 1
    $dest = ($rep_dest -split '\\')[0..$index] -join '\'

    Write-Host "Post-build: rep_dest : $($rep_dest)"
    Write-Host "Post-build: dest : $($dest)"
    Get-ChildItem -Path "$($dest)\Modules\$($type_mod)\$($module)\Ressources\*.*" -Recurse | ForEach-Object {
      $basename = "$($dest)\Modules\$($type_mod)\$($module)\Ressources\"
      $extra = $_.FullName.Substring($basename.Length, $_.FullName.Length - $basename.Length)
      $destination = [System.IO.Path]::GetDirectoryName("$($rep_dest)..\$($type_mod)\Ressources\$($module)\$($extra)")
      if (-not (Test-Path -Path $destination)) {
        mkdir -Path $destination -ErrorAction Ignore | Out-Null
      }
      Copy-Item $_.FullName -Destination "$($rep_dest)..\$($type_mod)\Ressources\$($module)\$($extra)" -Force
    }
  
  }

}

switch ($target) {
  'cp_rss_commun' { 
    Copy-CommonResources
  }
  'cp_rss_modules' { 
    Copy-ModuleResources
  }
}