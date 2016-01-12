#Requires -Version 3.0

Param(
  [string] [Parameter(Mandatory=$true)] $ResourceGroupLocation,
  [string] $ResourceGroupName,   
  [switch] $UploadArtifacts,
  [string] $StorageAccountName,
  [string] $StorageAccountResourceGroupName, 
  [string] $StorageContainerName = $ResourceGroupName.ToLowerInvariant() + '-stageartifacts',
  [string] $TemplateFile, 
  [string] $TemplateParametersFile,
  [string] $ArtifactStagingDirectory = '..\bin\Debug\staging',
  [string] $AzCopyPath = '..\Tools\AzCopy.exe',
  [string] [Parameter(Mandatory=$true)] $SubscriptionID,
  [string] [Parameter(Mandatory=$true)] $SubscriptionName,
  [string] [Parameter(Mandatory=$true)] $TenantID
)


Import-Module Azure -ErrorAction SilentlyContinue

try {
  [Microsoft.Azure.Common.Authentication.AzureSession]::ClientFactory.AddUserAgent("VSAzureTools-$UI$($host.name)".replace(" ","_"), "2.7")
} catch { }

Set-StrictMode -Version 3

$OptionalParameters = New-Object -TypeName Hashtable
$TemplateFile = [System.IO.Path]::Combine($PSScriptRoot, $TemplateFile)
$TemplateParametersFile = [System.IO.Path]::Combine($PSScriptRoot, $TemplateParametersFile)

# Create or update the resource group using the specified template file and template parameters file

Set-AzureRmContext -SubscriptionId $SubscriptionID -TenantId $TenantID # -SubscriptionName $SubscriptionName

New-AzureRmResourceGroup -Name $ResourceGroupName `
                       -Location $ResourceGroupLocation `

$OutputValues = New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
                       -Location $ResourceGroupLocation `
                       -TemplateFile $TemplateFile `
                       -TemplateParameterFile $TemplateParametersFile `
                        @OptionalParameters `
                        -Force -Verbose

# create a context for account and key
$ctx = New-AzureStorageContext -StorageAccountName $OutputValues.Outputs.storageAccountName.value -StorageAccountKey $OutputValues.Outputs.storageAccountKey.value

# create a new share
$fileshare = New-AzureStorageShare $OutputValues.Outputs.ftpFileShareName.value -Context $ctx 
Set-AzureStorageShareQuota -Share $fileshare -Quota $OutputValues.Outputs.ftpFileShareQuota.value

# create a directory in the share
New-AzureStorageDirectory -ShareName $OutputValues.Outputs.ftpFileShareName.value -Context $ctx -Path "/apps"
New-AzureStorageDirectory -Share $fileshare -Path "/apps/LoyaltyJ4U"
New-AzureStorageDirectory -Share $fileshare -Path "/apps/LoyaltyJ4U/integration"
New-AzureStorageDirectory -Share $fileshare -Path "/apps/LoyaltyJ4U/integration/hadoop_script"
New-AzureStorageDirectory -Share $fileshare -Path "/apps/LoyaltyJ4U/integration/hadoop_script/emju"
New-AzureStorageDirectory -Share $fileshare -Path "/apps/LoyaltyJ4U/integration/hadoop_script/emju/data_input"
New-AzureStorageDirectory -Share $fileshare -Path "/apps/LoyaltyJ4U/integration/hadoop_script/emju/data_input/transfer"

# create a new container
$containershare = New-AzureStorageContainer $OutputValues.Outputs.installStorageShareName.value -Context $ctx -Permission Off

Get-ChildItem –Path ..\Extension_Scripts\* | Set-AzureStorageBlobContent -Container $OutputValues.Outputs.installStorageShareName.value -Context $ctx
