
[console]::Clear();
$width = $host.UI.RawUI.WindowSize.Width
Write-Host "".PadLeft($Width, "~")
Write-Host " Décompression des archives ....."
$zips = Get-ChildItem *.zip
foreach ($zip in $zips) {
  Expand-Archive -Path $zip.FullName . -Force
}
Write-Host " => 👍"



