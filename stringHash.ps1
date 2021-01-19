$example="Nobody expects the Spanish Inquisition."

#calculate
$hash=[System.Security.Cryptography.HashAlgorithm]::Create("sha512").ComputeHash(
[System.Text.Encoding]::UTF8.GetBytes($example))

#convert to hex
[System.BitConverter]::ToString($hash) 

#convert to lower case hex without '-' 
[System.BitConverter]::ToString($hash).Replace("-","").ToLower()

#convert to base64
[Convert]::ToBase64String($hash)