$dprojs = Get-ChildItem -Filter '*.dproj' -Recurse | Where-Object { $_.FullName.Contains("Composants") -eq $false }

$dprojs | ForEach-Object {
  $xml = [xml] (Get-Content $_.FullName)
  $nsmgr = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
  $nsmgr.AddNamespace('ns', 'http://schemas.microsoft.com/developer/msbuild/2003') 
  $Major = $xml.SelectNodes("//ns:Delphi.Personality/ns:VersionInfo/ns:VersionInfo[@Name='MajorVer']", $nsmgr).InnerText
  $Minor = $xml.SelectNodes("//ns:Delphi.Personality/ns:VersionInfo/ns:VersionInfo[@Name='MinorVer']", $nsmgr).InnerText
  
  Write-Host "$($_.BaseName) => $Major.$Minor"
}
