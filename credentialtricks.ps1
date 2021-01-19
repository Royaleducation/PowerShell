## plain text password
$credential = Get-Credential
$plainPass = $credential.GetNetworkCredential().Password
$plainPass

##T he helper method (.GetNetworkCredential()) only exists on [PSCredential] objects.
## To directly deal with a [SecureString], use .NET methods:
$secstr=$credential.Password
$bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secstr)
$plainPass2 = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
$plainPass2

## Pre-filled user name:
$credential = Get-Credential -UserName 'myUser'
## Add a custom prompt message:
$credential = Get-Credential -Message 'Please enter your company email password.'


## ------------------------------------------------------------------------------------------------------------------------------------
$username = "user1@domain.com"
$pwdTxt = Get-Content "C:\temp\Stored_Password.txt"
$securePwd = ConvertTo-SecureString -String $pwdTxt -AsPlainText -Force
$securePwd
$credObject = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $securePwd
# Now, $credObject is having the credentials stored and you can pass it wherever you want.


## Export credentials
$credential = Get-Credential
$credential | Export-CliXml -Path 'C:\temp\cred.xml'
##import credentials
$credential = Import-CliXml -Path 'C:\temp\cred.xml'