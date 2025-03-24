If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    Try {
        Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
        Exit
    } Catch {
        Write-Host "Failed to run as Administrator. Please rerun with elevated privileges." -ForegroundColor Red
        Exit
    }
}

$DBPath = "C:\WPHARMA\DB\"
$path = Read-Host "Chemin de l'archive WPHARMA.zip ou du répertoire WPHARMA original"
$isDirectory = $false

if (Test-Path $path -PathType Leaf) {
    Write-Host "Le chemin indiqué est un fichier."
} elseif (Test-Path $path -PathType Container) {
    Write-Host "Le chemin indiqué est un répertoire."
    $isDirectory = $true
} else {
    Write-Host "Le chemin indiqué n'existe pas."
    $path = Read-Host "Chemin de WPHARMA.zip "
}

# Récupérer le chemin courant et le décomposer en tableau
$LocalPath = $PSScriptRoot -split "\\"
# Construire le chemin du commit en retirant les 5 derniers éléments du tableau => Suppression des ..\..\..\.. illisibles 😊
$commitPath = $LocalPath[0..($LocalPath.Length - 5)] -join "\"
$destination = "C:\"
if (Test-Path "C:\WPHARMA") {
    Write-Host "Le dossier WPHARMA existe déjà, il va être renommé en WPHARMA_old."
    Rename-Item -Path "C:\WPHARMA" -NewName "WPHARMA_old"
}

if (!$isDirectory) {
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $zip = [System.IO.Compression.ZipFile]::OpenRead($path)
        $hasWPHARMA = $zip.Entries | Where-Object { $_.FullName -match "^WPHARMA/" } | Measure-Object | Select-Object -ExpandProperty Count
        $zip.Dispose()
    }
    catch {
        Write-Host "Erreur lors de l'inspection de l'archive: $_"
        exit
    }
    if ($hasWPHARMA -gt 0) {
        Expand-Archive -Path $path -DestinationPath $destination
        Write-Host "WPHARMA a été décompressé dans C:\."
    }
    else {
        $WPHARMADestination = "C:\WPHARMA"
        New-Item -Path $WPHARMADestination -ItemType Directory -Force | Out-Null
        Expand-Archive -Path $path -DestinationPath $WPHARMADestination -Force
        Write-Host "WPHARMA a été décompressé dans C:\WPHARMA."
    }
}
else {
    Write-Host "Copie de WPHARMA dans C:\."
    Copy-Item -Path $path -Destination "C:\WPHARMA" -Recurse
    Write-Host "WPHARMA a été copié dans C:\."
}

Write-Host "Copie des dll en cours"
if (Test-Path "C:\WPHARMA\wpodbc3.dll") {
    Copy-Item -Path "C:\WPHARMA\wpodbc3.dll" -Destination "$commitpath\wpodbc3.dll" -Force
}
else {
    Copy-Item -Path "$PSScriptRoot\wpodbc3.dll" -Destination "$commitpath\wpodbc3.dll" -Force
}

if (Test-Path "C:\WPHARMA\wpodbc3r.dll") {
    Copy-Item -Path "C:\WPHARMA\wpodbc3r.dll" -Destination "$commitpath\wpodbc3r.dll" -Force
}
else {
    Copy-Item -Path "$PSScriptRoot\wpodbc3r.dll" -Destination "$commitpath\wpodbc3r.dll" -Force
}

Copy-Item -Path "C:\WPHARMA\evncall.dll" -Destination "$commitpath\evncall.dll" -Force

$DBPath = "C:\WPHARMA\DB"

if (-Not (Test-Path -Path $DBPath)) {
    Write-Host "Reprise à chaud, C:\WPHARMA\DB absent"

    $zipPath = Read-Host "Indiquez le chemin du fichier  wps*.zip"

    if (Test-Path -Path $zipPath) {
        New-Item -Path $DBPath -ItemType Directory
        Expand-Archive -Path $zipPath -DestinationPath $DBPath
    } else {
        Write-Host "zip introuvable"
    }
} else {
    Write-Host "Reprise à froid."
}



Write-Host "Remplacement du system.myd"
if (Test-Path "C:\WPHARMA\DB\SYSTEM.MYD") {
    Rename-Item -Path  "C:\WPHARMA\DB\SYSTEM.MYD" -NewName "SYSTEM.MYD_old"
}
Copy-Item -Path "$PSScriptRoot\SYSTEM.MYD" -Destination "C:\WPHARMA\DB\SYSTEM.MYD"

$databaseFiles = @(
    "clients",
    "orders",
    "benefic",
    "fourep",
    "medecin"
)

foreach ($file in $databaseFiles) {
    if (-Not (Test-Path "$DBPath\$file.myi")) {
        $missingMyiFiles = $true
    }
}
$allFilesExist= $false
if ($missingMyiFiles) {
    Write-Host "Démarrage de wpserver.exe pour finaliser les opérations."
    while($true) {
    $process = Start-Process -FilePath "C:\WPHARMA\wpserver.exe" -PassThru
    $allFilesExist = $true
    foreach ($fileToCheck in $databaseFiles) {
        if (-Not (Test-Path "$DBPath\$fileToCheck.myi")) {
            $allFilesExist = $false 
            break
        }
    }

    if ($allFilesExist) {
        Write-Host "Tous les fichiers .myi sont présents. Arrêt de wpserver.exe."
        Stop-Process -Id $process.Id -Force
        break
    }

    Write-Host "En attente de la création des fichiers .myi, nouvelle vérification dans 5 secondes..."
    Start-Sleep -Seconds 5
}
}

Start-Sleep -Seconds 2

Write-Host "Renommage des fichiers de la base de données"

$databaseFiles | ForEach-Object {
    Write-Host "Renommage des fichiers $_"
    Copy-Item -Path (@($DBPath,"$_.myd") -join "\") -Destination (@($DBPath,"$($_)0.myd") -join "\") -Force
    Copy-Item -Path (@($DBPath,"$_.myi") -join "\") -Destination (@($DBPath,"$($_)0.myi") -join "\") -Force
    Copy-Item -Path (@($DBPath,"$_.frm") -join "\") -Destination (@($DBPath,"$($_)0.frm") -join "\") -Force
}


Write-Host "Démarrage de wpserver.exe"
Start-Process -FilePath "C:\WPHARMA\wpserver.exe"
Write-Host "wpserver.exe démarré"
Read-Host -Prompt "Appuyez sur la touche entrée pour continuer..." 