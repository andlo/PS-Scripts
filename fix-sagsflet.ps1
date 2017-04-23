$content = Get-Content -Path .\sagsflet.txt 
$headerline = $content[0].Split(';')
$headers = (($headerline |
  Select-String -Pattern "`"[^`"\r\n]*`"|'[^'\r\n]*'|[^,\r\n]*" -AllMatches).Matches |
  Where-Object -FilterScript {
    $_.Value
}).Value.trim('"') |
ForEach-Object -Process {
  $i++
  "$($_) [$i]"
}
$content[0] = "`"$($headers -join '";"')`""
$content | Set-Content -Path .\sagsflet1.txt

Remove-Variable -Name 'i'