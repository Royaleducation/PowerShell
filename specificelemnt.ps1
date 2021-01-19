$Xml.Machines.Machine |
Where-Object { $_.Name -eq 'Server0009' } |
Select-Object -Property IP, {$_.Information.info1}

#### vagy ###

$item = Select-XML -Xml $xml -XPath '//Machine[Name="Server0009"]'
$item.Node | Select-Object -Property IP, {$_.Information.Info1}

#### es valtoztatas a tartalmon ####
$item = Select-XML -Xml $xml -XPath '//Machine[Name="Server0006"]'
$item.node.Name = "NewServer0006"
$item.node.IP = "10.10.10.12"
$item.node.Information.Info1 = 'new attribute info'
 
$NewPath = "c:\temp\test\inventory2.xml"
$xml.Save($NewPath)
notepad $NewPath