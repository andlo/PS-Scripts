# format a string number as a formatted string

$pnum='+47 44 20 771020'
$pnum = $pnum.trim()

$pnum = $pnum.replace("+45", "")

$pnum = $pnum.replace(" ", "")
$pnum = $pnum.trim()

IF ($pnum.Length -eq 8) {  
  $pnum = '+45 ' + [String]::Format('{0:## ## ## ##}',[int]$pnum)
}
$pnum 

