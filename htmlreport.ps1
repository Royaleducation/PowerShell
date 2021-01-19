function Get-CSInfo {

  param($computername)

  $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computername

 

  $cs = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computername

 

  $bios = Get-WmiObject -Class Win32_BIOS -ComputerName $computername

 

  $props = @{‘ComputerName’=$computername

             ‘OS Version’=$os.version

                     ‘OS Build’=$os.buildnumber

                     ‘Service Pack’=$os.sevicepackmajorversion

                     ‘RAM’=$cs.totalphysicalmemory

                     ‘Processors’=$cs.numberofprocessors

                     ‘BIOS Serial’=$bios.serialnumber}

 

  $obj = New-Object -TypeName PSObject -Property $props

  Write-Output $obj

}

$frag1 = Get-CSInfo -computername localhost |

ConvertTo-Html -As LIST -Fragment -PreContent ‘<h2>Computer Info</h2>’ |

Out-String

$frag2 = Get-WmiObject -Class Win32_LogicalDisk -Filter ‘DriveType=3’ -ComputerName localhost |

         Select-Object @{name=’Drive’;expression={$_.DeviceID}},

              @{name=’Size(GB)’;expression={$_.Size / 1GB -as [int]}},

              @{name=’FreeSpace(GB)’;expression={

              $_.freespace / 1GB -as [int]}} |

ConvertTo-Html -Fragment -PreContent ‘<h2>Disk Info</h2>’ |

Out-String

$head = @’

<style>

body { background-color:#dddddd;

       font-family:Tahoma;

       font-size:12pt; }

td, th { border:1px solid black;

         border-collapse:collapse; }

th { color:white;

     background-color:black; }

table, tr, td, th { padding: 2px; margin: 0px }

table { margin-left:50px; }

</style>

‘@

 

ConvertTo-HTML -head $head -PostContent $frag1,$frag2 -PreContent “<h1>Hardware Inventory for localhost</h1>” | Out-File C:\temp\report.htm