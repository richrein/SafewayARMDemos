#
# Master.ps1
#

#Login-AzureRmAccount

$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "9f9d3632-1f42-4407-acb7-8c00b5afb5e9"
$subscriptionName = "EMJU-dv"
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

Set-AzureRmContext -SubscriptionId $subscriptionID -SubscriptionName $subscriptionName -TenantId $tenantID

##Network
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-Network")
#$invokeArgs += ("-TemplateFile", $NetworkTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.Network.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Network.ps1 $invokeArgs"

###############################
#Admin VMs
###############################

##Rdp Jump
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-RdpJump-VMs")
#$invokeArgs += ("-TemplateFile", $RdpJumpTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.RdpJump-VMs.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.RdpJump-VMs.ps1 $invokeArgs"

##SFTP
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-SFTP-VMs")
#$invokeArgs += ("-TemplateFile", $SFTPTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.SFTP-VMs.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SFTP-VMs.ps1 $invokeArgs"

##SSH Bastion
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-SSH-VMs")
#$invokeArgs += ("-TemplateFile", $SSHBastionTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.SSH-VMs.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SSH-VMs.ps1 $invokeArgs"

###############################
##Public Services
###############################
#ClipEventProcessing
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-ClipEventProcessing-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-ClipEventProcessing.param.dv.json")
$invokeArgs += $subscriptionArgs
Invoke-Expression ".\Deploy-EMJU.ClipEventProcessing-VMs.ps1 $invokeArgs"

##Clipping
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-Clipping-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-Clipping.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Clipping-VMs.ps1 $invokeArgs"

##CoreServices
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-CoreServices-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-CoreServices.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServices-VMs.ps1 $invokeArgs"

##CoreServicesMobile
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-CoreServicesMobile-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-CoreServicesMobile.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServicesMobile-VMs.ps1 $invokeArgs"

##Gallery
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-Gallery-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-Gallery.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Gallery-VMs.ps1 $invokeArgs"

##GalleryMobile
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-GalleryMobile-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-GalleryMobile.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.GalleryMobile-VMs.ps1 $invokeArgs"

##MiscServicesMobile
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-MiscServicesMobile-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-MiscServicesMobile.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MiscServicesMobile-VMs.ps1 $invokeArgs"

##MyCard
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-MyCard-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-MyCard.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyCard-VMs.ps1 $invokeArgs"

##MyList
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-MyList-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-MyList.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyList-VMs.ps1 $invokeArgs"

##MyListMobile
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-MyListMobile-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-MyListMobile.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyListMobile-VMs.ps1 $invokeArgs"

##OfferSetup
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-OfferSetup-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-OfferSetup.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.OfferSetup-VMs.ps1 $invokeArgs"

##PartnerClipping
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-PartnerClipping-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-PartnerClipping.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.PartnerClipping-VMs.ps1 $invokeArgs"

##ScanMobile
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-ScanMobile-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-ScanMobile.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ScanMobile-VMs.ps1 $invokeArgs"

##SortByAisleMobile
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-SortByAisleMobile-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-SortByAisleMobile.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SortByAisleMobile-VMs.ps1 $invokeArgs"

##WeeklyAdMobile
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-WeeklyAdMobile-VMs")
#$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PublicService-VMs-WeeklyAdMobile.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.WeeklyAdMobile-VMs.ps1 $invokeArgs"

################################
###Private Services
################################
##Management
#$invokeArgs = @()
#$invokeArgs += ("-ResourceGroupName","EMJU-AZDV2-Management-VMs")
#$invokeArgs += ("-TemplateFile", $PrivateServiceTemplate)
#$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-dv\EMJU.PrivateService-VMs-Management.param.dv.json")
#$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Management-VMs.ps1 $invokeArgs"

################################
###PaaS Services
################################
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