Get-Content "C:\temp\ServerList.txt" -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "Automatic Services Stopped :" $_ 
    Get-WmiObject Win32_Service -ComputerName $_ -Filter  "startmode = 'auto' AND state != 'running'"
} |
    Select-Object DisplayName, Name, State, StartMode |
    ConvertTo-Html |
    Out-File C:\temp\notrunningReport.html
