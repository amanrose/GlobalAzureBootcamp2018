## Delete Your Resource Group

In this lab we will start by deleting our Resource Group and all the resources contained within.

1. Navigate to your Resource Group in the Azure portal
2. Click "Delete resource group" at the top of your Resource Group blade
3. A window will open warning you of the resources you are about to remove
4. Type the name of your Resource Group to confirm deletion and then click "Delete" at the bottom of the window

## Recreate your Resource Group and Resources

Deploy this ARM Template to your Azure environment:

[https://github.com/rwakefie/AzureInnovationDay/blob/master/Lab5-Automation/Recreate-Environment/azuredeploy.json](https://github.com/rwakefie/AzureInnovationDay/blob/master/Lab5-Automation/Recreate-Environment/azuredeploy.json)

This step is challanging, below are some tips

1. Install AzureRM module locally on your PC
2. Creage a directory with the deployment script and JSON from the link above
3. Execute the script. The ArtifactStagingDirecty must match the foldername that contains the scripts and this will also serve as the RG name in Azure
4. For ResourceGroupLocation enter "East US"