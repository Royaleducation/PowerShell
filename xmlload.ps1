$Path = "c:\temp\test\inventory.xml"
 
$xml = New-Object -TypeName XML
$xml.Load($Path)
 
$Xml.Machines.Machine | Select-Object -Property Name, IP

### vagy ###

$Path = "c:\temp\test\inventory.xml"
[XML]$xml = Get-Content $Path
$xml