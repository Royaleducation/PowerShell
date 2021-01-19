Add-AzureRmAccount

$containerName = 'az1000201-container'
$storageAccount1Name = (Get-AzureRmStorageAccount -ResourceGroupName 'az1000201-RG')[0].StorageAccountName
$storageAccount2Name = (Get-AzureRmStorageAccount -ResourceGroupName 'az1000202-RG')[0].StorageAccountName
$storageAccount1Key1 = 'Akr5lNEsPcjUm3JSbAENSedvxj+x+o4rI5R2LNVYLRKLgIJDRpjoswEH7+BwZYj+UtxUD4qYu/p80IYaL6HJQA=='
$storageAccount2Key1 = 'hi27tvF0+KuOXE5J/hJGfqiaKPyY29b2MLfrqF1Ru9Z/hjTGoQEawusvVxa6XZ060aYulj2pkDeIs0FD8R/05w=='
$context1 = New-AzureStorageContext -StorageAccountName $storageAccount1Name -StorageAccountKey $storageAccount1Key1
$context2 = New-AzureStorageContext -StorageAccountName $storageAccount2Name -StorageAccountKey $storageAccount2Key1

New-AzureStorageContainer -Name $containerName -Context $context2 -Permission Off

$containerToken1 = New-AzureStorageContainerSASToken -Context $context1 -ExpiryTime(get-date).AddHours(24) -FullUri -Name $containerName -Permission rwdl
$containerToken2 = New-AzureStorageContainerSASToken -Context $context2 -ExpiryTime(get-date).AddHours(24) -FullUri -Name $containerName -Permission rwdl

C:\azcopy\azcopy.exe cp $containerToken1 $containerToken2 --recursive=true
