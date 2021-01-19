configuration EnableIISFeature
{
    node localhost
    {
        WindowsFeature IIS
        {
            Ensure = “Present”
            Name = “Web-Server”                      
        }
    }
}

## To test the DSC configuration on your localhost, you can simply invoke the following:
Start-DscConfiguration -ComputerName localhost -Wait 


## To list available DSC resources on your authoring node:
Get-DscResource 

## To list all available DSC resources that can be found in the online sources (PSGallery ++) on WMF 5 :
Find-DSCResource

## Before you can use a resource in a configuration, you must explicitly import it. Just having it installed on your computer, will not let you use the resource implicitly.
## Import a resource by using Import-DscResource .
## Example showing how to import the PSDesiredStateConfiguration resource and the File resource.
Configuration InstallPreReqs
{
   param(); # params to DSC goes here.

   Import-DscResource PSDesiredStateConfiguration 

   File CheckForTmpFolder {
        Type = 'Directory'
        DestinationPath = 'C:\Tmp'
        Ensure = "Present"
    }
 }

 ## Running DSC remotely
$remoteComputer = "myserver.somedomain.com"
$cred = (Get-Credential)
Start-DSCConfiguration -ServerName $remoteComputer -Credential $cred -Verbose