#Requires -Version 3.0

Param(
  [string] [Parameter(Mandatory=$true)] $ResourceGroupLocation,
  [string] $ResourceGroupName = 'ARMDemos-Dev',  
  [switch] $UploadArtifacts,
  [string] $StorageAccountName,
  [string] $StorageAccountResourceGroupName, 
  [string] $StorageContainerName = $ResourceGroupName.ToLowerInvariant() + '-stageartifacts',
  [string] $TemplateFile = 'VMs.json',
  [string] $TemplateParametersFile = 'VMs.param.dev.json',
  [string] $ArtifactStagingDirectory = '..\bin\Debug\staging',
  [string] $AzCopyPath = '..\Tools\AzCopy.exe'
)


Import-Module Azure -ErrorAction SilentlyContinue

try {
  [Microsoft.Azure.Common.Authentication.AzureSession]::ClientFactory.AddUserAgent("VSAzureTools-$UI$($host.name)".replace(" ","_"), "2.7")
} catch { }

Set-StrictMode -Version 3

$OptionalParameters = New-Object -TypeName Hashtable
$TemplateFile = [System.IO.Path]::Combine($PSScriptRoot, $TemplateFile)
$TemplateParametersFile = [System.IO.Path]::Combine($PSScriptRoot, $TemplateParametersFile)

#if ($UploadArtifacts)
#{
#    # Convert relative paths to absolute paths if needed
#    $AzCopyPath = [System.IO.Path]::Combine($PSScriptRoot, $AzCopyPath)
#    $ArtifactStagingDirectory = [System.IO.Path]::Combine($PSScriptRoot, $ArtifactStagingDirectory)

#    Set-Variable ArtifactsLocationName '_artifactsLocation' -Option ReadOnly
#    Set-Variable ArtifactsLocationSasTokenName '_artifactsLocationSasToken' -Option ReadOnly

#    $OptionalParameters.Add($ArtifactsLocationName, $null)
#    $OptionalParameters.Add($ArtifactsLocationSasTokenName, $null)

#    # Parse the parameter file and update the values of artifacts location and artifacts location SAS token if they are present
#    $JsonContent = Get-Content $TemplateParametersFile -Raw | ConvertFrom-Json
#    $JsonParameters = $JsonContent | Get-Member -Type NoteProperty | Where-Object {$_.Name -eq "parameters"}

#    if ($JsonParameters -eq $null)
#    {
#        $JsonParameters = $JsonContent
#    }
#    else
#    {
#        $JsonParameters = $JsonContent.parameters
#    }

#    $JsonParameters | Get-Member -Type NoteProperty | ForEach-Object {
#        $ParameterValue = $JsonParameters | Select-Object -ExpandProperty $_.Name

#        if ($_.Name -eq $ArtifactsLocationName -or $_.Name -eq $ArtifactsLocationSasTokenName)
#        {
#            $OptionalParameters[$_.Name] = $ParameterValue.value
#        }
#    }

#    if ($StorageAccountResourceGroupName)
#	{
#		Switch-AzureMode AzureResourceManager
#	    $StorageAccountKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $StorageAccountResourceGroupName -Name $StorageAccountName).Key1
#    }
#    else
#	{
#		Switch-AzureMode AzureServiceManagement
#	    $StorageAccountKey = (Get-AzureStorageKey -StorageAccountName $StorageAccountName).Primary 
#    }
    
#    $StorageAccountContext = New-AzureRmStorageContext -StorageAccountName $StorageAccountName -StorageAccountKey $StorageAccountKey

#    # Generate the value for artifacts location if it is not provided in the parameter file
#    $ArtifactsLocation = $OptionalParameters[$ArtifactsLocationName]
#    if ($ArtifactsLocation -eq $null)
#    {
#        $ArtifactsLocation = $StorageAccountContext.BlobEndPoint + $StorageContainerName
#        $OptionalParameters[$ArtifactsLocationName] = $ArtifactsLocation
#    }

#    # Use AzCopy to copy files from the local storage drop path to the storage account container
#    & "$AzCopyPath" """$ArtifactStagingDirectory"" $ArtifactsLocation /DestKey:$StorageAccountKey /S /Y /Z:""$env:LocalAppData\Microsoft\Azure\AzCopy\$ResourceGroupName"""

#    # Generate the value for artifacts location SAS token if it is not provided in the parameter file
#    $ArtifactsLocationSasToken = $OptionalParameters[$ArtifactsLocationSasTokenName]
#    if ($ArtifactsLocationSasToken -eq $null)
#    {
#       # Create a SAS token for the storage container - this gives temporary read-only access to the container (defaults to 1 hour).
#       $ArtifactsLocationSasToken = New-AzureRmStorageContainerSASToken -Container $StorageContainerName -Context $StorageAccountContext -Permission r
#       $ArtifactsLocationSasToken = ConvertTo-SecureString $ArtifactsLocationSasToken -AsPlainText -Force
#       $OptionalParameters[$ArtifactsLocationSasTokenName] = $ArtifactsLocationSasToken
#    }
#}

# Create or update the resource group using the specified template file and template parameters file
#Login-AzureRmAccount

Set-AzureRmContext -SubscriptionId 8f982005-15fc-4d91-894a-c436a01505c5 -SubscriptionName "EMJU Development" -TenantId b7f604a0-00a9-4188-9248-42f3a5aac2e9

New-AzureRmResourceGroup -Name $ResourceGroupName `
                       -Location $ResourceGroupLocation `

New-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName `
                       -Location $ResourceGroupLocation `
                       -TemplateFile $TemplateFile `
                       -TemplateParameterFile $TemplateParametersFile `
                        @OptionalParameters `
                        -Force -Verbose
