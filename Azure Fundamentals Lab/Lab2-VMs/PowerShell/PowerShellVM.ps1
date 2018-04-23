New-AzureRmVM `
-ResourceGroupName "YOURRESOURCEGROUP" `
-Name "web-vm-2" `
-Location "EAST US" `
-VirtualNetworkName "YOURVNET" `
-SubnetName "web" `
-AvailabilitySetName "YOURAVAILABILITYSETNAME"
