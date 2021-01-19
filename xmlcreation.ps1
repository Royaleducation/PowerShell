$Path = "c:\temp\inventory.xml"
 
$XmlWriter = New-Object System.XMl.XmlTextWriter($Path,$Null)
 
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 1
$XmlWriter.IndentChar = "`t"
 
$xmlWriter.WriteStartDocument()
 

$xmlWriter.WriteProcessingInstruction("xml-stylesheet", "type='text/xsl' href='style.xsl'")
 
# gyoker elemek + attributumok
$XmlWriter.WriteComment('List of machines')
$xmlWriter.WriteStartElement('Machines')
$XmlWriter.WriteAttributeString('current', $true)
$XmlWriter.WriteAttributeString('manager', 'Tobias')
 
# random beiras
for($x=1; $x -le 10; $x++)
{
    $server = 'Server{0:0000}' -f $x
    $ip = '{0}.{1}.{2}.{3}' -f  (0..256 | Get-Random -Count 4)
 
    $guid = [System.GUID]::NewGuid().ToString()

    $XmlWriter.WriteComment("$x. machine details")
    $xmlWriter.WriteStartElement('Machine')
    $XmlWriter.WriteAttributeString('test', (Get-Random))
 
    $xmlWriter.WriteElementString('Name',$server)
    $xmlWriter.WriteElementString('IP',$ip)
    $xmlWriter.WriteElementString('GUID',$guid)
 
    $XmlWriter.WriteStartElement('Information')
    $XmlWriter.WriteAttributeString('info1', 'some info')
    $XmlWriter.WriteAttributeString('info2', 'more info')
    $XmlWriter.WriteRaw('RawContent')
    $xmlWriter.WriteEndElement()
 
    $XmlWriter.WriteStartElement('CodeSegment')
    $XmlWriter.WriteAttributeString('info3', 'another attribute')
    $XmlWriter.WriteCData('this is untouched code and can contain special characters /\@<>')
    $xmlWriter.WriteEndElement()
     
    $xmlWriter.WriteEndElement()
}
 

$xmlWriter.WriteEndElement()
 
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
 
notepad $path