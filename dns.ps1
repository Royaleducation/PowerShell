Add-AzureRmAccount

$rg1=Get-AzureRmResourceGroup -Name '1000401b-RG'
$rg2=New-AzureRmResourceGroup -Name '1000402b-RG' -Location $rg1.Location

$subnet1=New-AzureRmVirtualNetworkSubnetConfig -Name subnet1 -AddressPrefix '10.100.0.0/24'
$vnet=New-AzureRmVirtualNetwork -ResourceGroupName $rg2.ResourceGroupName -Location $rg2.Location -Name 'az1000402b1-vnet1' -AddressPrefix '10.100.0.0/16' -Subnet $subnet1

$subnet2=New-AzureRmVirtualNetworkSubnetConfig -Name subnet1 -AddressPrefix '10.200.0.0/24'
$vnet2=New-AzureRmVirtualNetwork -ResourceGroupName $rg2.ResourceGroupName -Location $rg2.Location -Name 'az1000402b1-vnet2' -AddressPrefix '10.200.0.0/16' -Subnet $subnet2

$vnet1 = Get-AzureRmVirtualNetwork -Name 'az1000402b1-vnet1' -ResourceGroupName $rg2.ResourceGroupName
$vnet2 = Get-AzureRmVirtualNetwork -Name 'az1000402b1-vnet2' -ResourceGroupName $rg2.ResourceGroupName

New-AzureRmDnsZone -Name adatum.local -ResourceGroupName $rg2.ResourceGroupName -ZoneType Private -RegistrationVirtualNetworkId @($vnet1.Id) -ResolutionVirtualNetworkId @($vnet2.Id)

New-AzureRmResourceGroupDeployment -ResourceGroupName $rg2.ResourceGroupName -TemplateFile 'C:\Allfiles\Labfiles\Module_04\Configure_Azure_DNS\az-100-04b_01_azuredeploy.json' -TemplateParameterFile 'C:\Allfiles\Labfiles\Module_04\Configure_Azure_DNS\az-100-04_azuredeploy.parameters.json' -AsJob
New-AzureRmResourceGroupDeployment -ResourceGroupName $rg2.ResourceGroupName -TemplateFile 'C:\Allfiles\Labfiles\Module_04\Configure_Azure_DNS\az-100-04b_02_azuredeploy.json' -TemplateParameterFile 'C:\Allfiles\Labfiles\Module_04\Configure_Azure_DNS\az-100-04_azuredeploy.parameters.json' -AsJob

New-AzureRmDnsRecordSet -ResourceGroupName $rg2.ResourceGroupName -Name gep1 -RecordType A -ZoneName adatum.local -Ttl 3600 -DnsRecords (New-AzureRmDnsRecordConfig -Ipv4Address "10.100.0.4")
