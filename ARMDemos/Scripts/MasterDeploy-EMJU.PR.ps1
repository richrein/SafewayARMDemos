#
# Master.ps1
#

#Login-AzureRmAccount

$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "dc2a4b35-5221-412c-bca8-cb90aef6fbfb"
$subscriptionName = "EMJU"
$ResourceGroupLocation = "westus"

$NetworkTemplate = "..\Templates\EMJU.Network.json"
$SSHBastionTemplate ="..\Templates\EMJU.SSH-VMs.json"
$SFTPTemplate ="..\Templates\EMJU.SFTP-VMs.json"
$RdpJumpTemplate ="..\Templates\EMJU.RdpJump-VMs.json"
$FileSharingTemplate = "..\Templates\EMJU.FileShare-Storage.json"
$RedisCacheTemplate = "..\Templates\EMJU.Redis-Cache.json"
$ServiceBusTemplate = "..\Templates\EMJU.ServiceBus-PAAS.json"
$HDInsightTemplate = "..\Templates\EMJU.HDInsight-VMs.json"
$PublicServiceTemplate = "..\Templates\EMJU.PublicService-VMs.json"
$PrivateServiceTemplate = "..\Templates\EMJU.PrivateService-VMs.json"
$DSETemplate = "..\Templates\EMJU.DSE-Stack.json"

$subscriptionArgs = @()
$subscriptionArgs += ("-ResourceGroupLocation", $ResourceGroupLocation)
$subscriptionArgs += ("-SubscriptionID",$subscriptionID)
$subscriptionArgs += ("-SubscriptionName",$subscriptionName)
$subscriptionArgs += ("-TenantID",$tenantID)


Set-AzureRmContext -SubscriptionId $subscriptionID -TenantId $tenantID #-SubscriptionName $subscriptionName

#Network
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-Network")
$invokeArgs += ("-TemplateFile", $NetworkTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.Network.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Network.ps1 $invokeArgs"

###############################
#Admin VMs
###############################

#Rdp Jump
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-RdpJump-VMs")
$invokeArgs += ("-TemplateFile", $RdpJumpTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.RdpJump-VMs.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.RdpJump-VMs.ps1 $invokeArgs"

#SFTP
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-SFTP-VMs")
$invokeArgs += ("-TemplateFile", $SFTPTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.SFTP-VMs.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SFTP-VMs.ps1 $invokeArgs"

#SSH Bastion
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-SSH-VMs")
$invokeArgs += ("-TemplateFile", $SSHBastionTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.SSH-VMs.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SSH-VMs.ps1 $invokeArgs"

###############################
##FileSharing
###############################

##FILESHARE
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-FILESHARE")
$invokeArgs += ("-TemplateFile", $FileSharingTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.FileShare-Storage.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.FileShare-Storage.ps1 $invokeArgs"

###############################
##PaaS Services
###############################
#Redis
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-REDIS")
$invokeArgs += ("-TemplateFile", $RedisCacheTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.RedisCache-PAAS.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Redis-Cache.ps1 $invokeArgs"

#ServiceBus
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-SERVICEBUS")
$invokeArgs += ("-TemplateFile", $ServiceBusTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.ServiceBus-PAAS.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ServiceBus-PAAS.ps1 $invokeArgs"

#Storage account for SFTP
#API-M when it is available on ARM

##############################
#Public Services
##############################
#ClipEventProcessing
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-ClipEventProcessing-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-ClipEventProcessing.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ClipEventProcessing-VMs.ps1 $invokeArgs"

#Clipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-Clipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-Clipping.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Clipping-VMs.ps1 $invokeArgs"

#CoreServices
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-CoreServices-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-CoreServices.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServices-VMs.ps1 $invokeArgs"

#CoreServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-CoreServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-CoreServicesMobile.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServicesMobile-VMs.ps1 $invokeArgs"

#Gallery
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-Gallery-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-Gallery.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Gallery-VMs.ps1 $invokeArgs"

#GalleryMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-GalleryMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-GalleryMobile.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.GalleryMobile-VMs.ps1 $invokeArgs"

#MiscServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-MiscServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-MiscServicesMobile.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MiscServicesMobile-VMs.ps1 $invokeArgs"

#MyCard
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-MyCard-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-MyCard.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyCard-VMs.ps1 $invokeArgs"

#MyList
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-MyList-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-MyList.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyList-VMs.ps1 $invokeArgs"

#MyListMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-MyListMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-MyListMobile.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyListMobile-VMs.ps1 $invokeArgs"

#Lite
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-Lite-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-Lite.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Lite-VMs.ps1 $invokeArgs"

#OfferSetup
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-OfferSetup-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-OfferSetup.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.OfferSetup-VMs.ps1 $invokeArgs"

#PartnerClipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-PartnerClipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-PartnerClipping.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.PartnerClipping-VMs.ps1 $invokeArgs"

#ScanMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-ScanMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-ScanMobile.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ScanMobile-VMs.ps1 $invokeArgs"

#SortByAisleMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-SortByAisleMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-SortByAisleMobile.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SortByAisleMobile-VMs.ps1 $invokeArgs"

#WeeklyAdMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-WeeklyAdMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PublicService-VMs-WeeklyAdMobile.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.WeeklyAdMobile-VMs.ps1 $invokeArgs"

###############################
##Private Services
###############################
#Management
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-Management-VMs")
$invokeArgs += ("-TemplateFile", $PrivateServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.PrivateService-VMs-Management.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Management-VMs.ps1 $invokeArgs"



###############################
##Datastax
###############################

##Datastax
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-DSE")
$invokeArgs += ("-TemplateFile", $DSETemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.DSE-Stack.param.pr.json")
$invokeArgs += $subscriptionArgs
Invoke-Expression ".\Deploy-EMJU.DSE-VMs.ps1 $invokeArgs"

###############################
##HDInsight
###############################
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPR-HDI")
$invokeArgs += ("-TemplateFile", $HDInsightTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pr\EMJU.HDInsight-VMs.param.pr.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.HDInsight-VMs.ps1 $invokeArgs"