ConvertTo-Html -InputObject (Get-Date)

#####################

Get-PSDrive | ConvertTo-Html
Get-PSDrive | ConvertTo-Html | Out-File -FilePath c:\temp\PSDrives.html
Invoke-Expression C:\temp\PSDrives.html
#############

Get-PSDrive | ConvertTo-Html -Property Name,Used,Provider,Root,CurrentLocation | Out-File -FilePath c:\temp\PSDrives.html
##############
$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@
Get-PSDrive | ConvertTo-Html -Property Name,Used,Provider,Root,CurrentLocation -Head $Header | Out-File -FilePath c:\temp\PSDrives.html