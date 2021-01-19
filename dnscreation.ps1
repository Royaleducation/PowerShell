Invoke-RestMethod http://ipinfo.io/json

Add-AzureRmAccount

$rg=Get-AzureRmResourceGroup -Name '1000401b-RG'
New-AzureRmPublicIpAddress -ResourceGroupName $rg.ResourceGroupName -Sku Basic -AllocationMethod Static -Name 1000401b-pip -Location $rg.Location

nslookup geritest123.geritestdnszone.com ns1-07.azure-dns.com


