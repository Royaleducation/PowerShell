Get-Process | Export-Clixml c:\temp\proc.xml
Import-Clixml c:\temp\proc.xml | sort -property pm -Descending |select -first 10

#####################
$xml=Get-WmiObject Win32_Volume | ConvertTo-Xml
$xml
$xml.GetType().Name


$xml.objects
$xml.objects.object[0]

$xml.Save(“c:\temp\test\volume.xml”)

###########

$xml = [xml](get-content C:\temp\file.xml)
$xml
$xml.employees
$xml.employees.employee

$xml.SelectNodes("/employees/employee")
$xml.employees.employee | where { [int]$_.age -gt 50 }
$xml.employees.employee | where { $_.id.startsWith("1") }

$xml.employees.employee | foreach { $_.id + ":" + $_.name + ":" + $_.age }

#################
$url = "http://www.tmz.com/rss.xml"
$feed=[xml](new-object system.net.webclient).downloadstring($url)
$feed.rss.channel.item | format-table title,link
$feed.rss.channel.item | where { $_.title -imatch "Antonio" } | ft title,link

