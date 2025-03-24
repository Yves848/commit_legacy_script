$af31 = Get-Content -Path .\af31.csv_old -Raw -Encoding utf8
$test = $af31 -split "`n"
$test2 = @()
$test2 += $test[0]
$i = 1
$count = ([regex]::Matches($test[0], ";")).count
$temp = ""
while ($i -lt $test.Length - 1) {
  $test[$i] = $test[$i] -replace '[\x00-\x1F]', ''
  $test[$i] = $test[$i] -replace '`a', ''
  $c = ([regex]::Matches($test[$i], ";")).count
  if ($c -eq $count) {
    $test2 += $test[$i]
    $temp = ""
  }
  else {
    $temp = $temp + $test[$i]
    if (([regex]::Matches($temp, ";")).count -eq $count) {
      $test2 += $temp
      $temp = ""
    }
  }
  $i++
}

$test2 | Out-File -FilePath af31.csv -Force -Encoding utf8
