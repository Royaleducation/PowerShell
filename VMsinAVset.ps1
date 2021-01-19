# $cred=Get-Credential
Add-AzureRmAccount # -Credential $cred

Get-AzurermSubscription
Set-AzureRmContext -Subscriptionid 134602f5-2b4b-4335-9291-570c9cc4ae17

$rg=Get-AzureRmResourceGroup -Name 'rg-1'
$location=$rg.Location

$vmnev='vm-1'
$vmszie='Standard_B2ms'

$avset=Get-AzureRmAvailabilitySet -ResourceGroupName $rg.ResourceGroupName -Name 'geriavset'

$vnet=Get-AzureRmVirtualNetwork -Name 'geri-vnet' -ResourceGroupName $rg.ResourceGroupName 

$sunetid=(Get-AzureRmVirtualNetworkSubnetConfig -Name 'geri-sn' -VirtualNetwork $vnet).id
$nsg=New-AzureRmNetworkSecurityGroup -ResourceGroupName $rg.ResourceGroupName -Location $rg.Location -Name 'geri-nsg'
$pip=New-AzureRmPublicIpAddress -Name "$vmnev-ip" -ResourceGroupName $rg.ResourceGroupName -Location $location -AllocationMethod Dynamic

$nic=New-AzureRmNetworkInterface -Name "$vmnev-nic" -ResourceGroupName $rg.ResourceGroupName -Location $location -SubnetId $sunetid -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id
$adminuser='student'
$adminpwd='Pa55w.rd1234'
$admincreds=New-Object pscredential $adminuser, ($adminpwd | ConvertTo-SecureString -AsPlainText -Force)

$pn='MicrosoftWindowsServer'
$on='WindowsServer'
$skuname='2016-Datacenter'

$osdisk=(Get-AzureRmDisk -ResourceGroupName $rg.ResourceGroupName )[0].Sku.Name

$vmconfig=New-AzureRmVMConfig -VMName $vmnev -VMSize $vmszie -AvailabilitySetId $avset.Id
Add-AzureRmVMNetworkInterface -VM $vmconfig -Id $nic.Id
Set-AzureRmVMOperatingSystem -VM $vmconfig -Windows -ComputerName $vmnev -Credential $admincreds
Set-AzureRmVMSourceImage -VM $vmconfig -PublisherName $pn -Offer $on -Skus $skuname -Version 'latest'
Set-AzureRmVMOSDisk -VM $vmconfig -Name "$($vmnev)_OsDisk_1_1234" -StorageAccountType $osdisk -CreateOption fromImage
Set-AzureRmVMBootDiagnostics -vm $vmconfig -Disable

New-AzureRmVM -VM $vmconfig -ResourceGroupName $rg.ResourceGroupName -Location $location


Test-AzureRmDnsAvailability -DomainNameLabel geriavset1 -Location $rg.Location

Invoke-RestMethod http://ipinfo.io/json | Select -ExpandProperty IP

New-AzureRmDnsZone -Name adatum.local -ResourceGroupName $rg.ResourceGroupName -ZoneType Private 

New-AzureRmResourceGroupDeployment -ResourceGroupName 'rg-1' -TemplateFile C:\Allfiles\Labfiles\Module_04\Configure_Azure_DNS\az-100-04b_01_azuredeploy.json -TemplateParameterFile C:\Allfiles\Labfiles\Module_04\Configure_Azure_DNS\az-100-04_azuredeploy.parameters.json -AsJob 

