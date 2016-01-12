#
# Master.ps1
#

#Login-AzureRmAccount

$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "8f982005-15fc-4d91-894a-c436a01505c5"
$subscriptionName = "J4U Development"
$ResourceGroupLocation = "westus"

$NetworkTemplate = "..\Templates\EMJU.Network.json"
$SSHBastionTemplate ="..\Templates\EMJU.SSH-VMs.json"
$SFTPTemplate ="..\Templates\EMJU.SFTP-VMs.json"
$RdpJumpTemplate ="..\Templates\EMJU.RdpJump-VMs.json"
$PublicServiceTemplate = "..\Templates\EMJU.PublicService-VMs.json"
$PrivateServiceTemplate = "..\Templates\EMJU.PrivateService-VMs.json"

$subscriptionArgs = @()
$subscriptionArgs += ("-ResourceGroupLocation", $ResourceGroupLocation)
$subscriptionArgs += ("-SubscriptionID",$subscriptionID)
$subscriptionArgs += ("-SubscriptionName",$subscriptionName)
$subscriptionArgs += ("-TenantID",$tenantID)

Set-AzureRmContext -SubscriptionId $subscriptionID -TenantId $tenantID #-SubscriptionName $subscriptionName

#Network
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-Network")
$invokeArgs += ("-TemplateFile", $NetworkTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.Network.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Network.ps1 $invokeArgs"

###############################
#Admin VMs
###############################

#Rdp Jump
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-RdpJump-VMs")
$invokeArgs += ("-TemplateFile", $RdpJumpTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.RdpJump-VMs.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.RdpJump-VMs.ps1 $invokeArgs"

#SFTP
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-SFTP-VMs")
$invokeArgs += ("-TemplateFile", $SFTPTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.SFTP-VMs.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SFTP-VMs.ps1 $invokeArgs"

#SSH Bastion
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-SSH-VMs")
$invokeArgs += ("-TemplateFile", $SSHBastionTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.SSH-VMs.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SSH-VMs.ps1 $invokeArgs"

##############################
#Public Services
##############################
#ClipEventProcessing
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-ClipEventProcessing-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-ClipEventProcessing.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ClipEventProcessing-VMs.ps1 $invokeArgs"

#Clipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-Clipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-Clipping.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Clipping-VMs.ps1 $invokeArgs"

#CoreServices
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-CoreServices-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-CoreServices.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServices-VMs.ps1 $invokeArgs"

#CoreServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-CoreServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-CoreServicesMobile.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServicesMobile-VMs.ps1 $invokeArgs"

#Gallery
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-Gallery-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-Gallery.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Gallery-VMs.ps1 $invokeArgs"

#GalleryMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-GalleryMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-GalleryMobile.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.GalleryMobile-VMs.ps1 $invokeArgs"

#MiscServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-MiscServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-MiscServicesMobile.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MiscServicesMobile-VMs.ps1 $invokeArgs"

#MyCard
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-MyCard-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-MyCard.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyCard-VMs.ps1 $invokeArgs"

#MyList
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-MyList-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-MyList.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyList-VMs.ps1 $invokeArgs"

#MyListMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-MyListMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-MyListMobile.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyListMobile-VMs.ps1 $invokeArgs"

#Lite
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-Lite-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-Lite.param.dev.json")
$invokeArgs += $subscriptionArgs
Invoke-Expression ".\Deploy-EMJU.Lite-VMs.ps1 $invokeArgs"

#OfferSetup
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-OfferSetup-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-OfferSetup.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.OfferSetup-VMs.ps1 $invokeArgs"

#PartnerClipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-PartnerClipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-PartnerClipping.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.PartnerClipping-VMs.ps1 $invokeArgs"

#ScanMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-ScanMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-ScanMobile.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ScanMobile-VMs.ps1 $invokeArgs"

#SortByAisleMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-SortByAisleMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-SortByAisleMobile.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SortByAisleMobile-VMs.ps1 $invokeArgs"

#WeeklyAdMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-WeeklyAdMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PublicService-VMs-WeeklyAdMobile.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.WeeklyAdMobile-VMs.ps1 $invokeArgs"

###############################
##Private Services
###############################
#Management
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV-Management-VMs")
$invokeArgs += ("-TemplateFile", $PrivateServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\J4UDevelopment\EMJU.PrivateService-VMs-Management.param.dev.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Management-VMs.ps1 $invokeArgs"

###############################
##PaaS Services
###############################
#Redis
#Service
#Storage account for SFTP
#API-M when it is available on ARM


###############################
##Datastax
###############################


###############################
##HDInsight
###############################