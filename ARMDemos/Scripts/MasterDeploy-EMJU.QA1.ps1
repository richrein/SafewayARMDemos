#
# Master.ps1
#

#Login-AzureRmAccount

$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "67d09f1b-6137-4556-bd69-c4aaef477c44"
$subscriptionName = "EMJU-qa"
$ResourceGroupLocation = "westus"

$NetworkTemplate = "..\Templates\EMJU.Network.json"
$SSHBastionTemplate ="..\Templates\EMJU.SSH-VMs.json"
$SFTPTemplate ="..\Templates\EMJU.SFTP-VMs.json"
$RdpJumpTemplate ="..\Templates\EMJU.RdpJump-VMs.json"
$FileSharingTemplate = "..\Templates\EMJU.FileShare-Storage.json"
$RedisCacheTemplate = "..\Templates\EMJU.Redis-Cache.json"
$ServiceBusTemplate = "..\Templates\EMJU.ServiceBus-PAAS.json"
$DSETemplate = "..\Templates\EMJU.DSE-Stack.json"
$HDInsightBaseTemplate = "..\Templates\EMJU.HDInsight-Base.json"
$HDInsightTemplate = "..\Templates\EMJU.HDInsight-VMs.json"
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
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-Network")
$invokeArgs += ("-TemplateFile", $NetworkTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.Network.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Network.ps1 $invokeArgs"

###############################
#Admin VMs
###############################

##Rdp Jump
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-RdpJump-VMs")
$invokeArgs += ("-TemplateFile", $RdpJumpTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.RdpJump-VMs.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.RdpJump-VMs.ps1 $invokeArgs"

##SFTP
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-SFTP-VMs")
$invokeArgs += ("-TemplateFile", $SFTPTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.SFTP-VMs.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SFTP-VMs.ps1 $invokeArgs"

##SSH Bastion
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-SSH-VMs")
$invokeArgs += ("-TemplateFile", $SSHBastionTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.SSH-VMs.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SSH-VMs.ps1 $invokeArgs"

###############################
##FileSharing
###############################

##FILESHARE
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-FILESHARE")
$invokeArgs += ("-TemplateFile", $FileSharingTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.FileShare-Storage.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.FileShare-Storage.ps1 $invokeArgs"

################################
###PaaS Services
################################

#Redis
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-REDIS")
$invokeArgs += ("-TemplateFile", $RedisCacheTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.RedisCache-PAAS.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Redis-Cache.ps1 $invokeArgs"

#ServiceBus
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-SERVICEBUS")
$invokeArgs += ("-TemplateFile", $ServiceBusTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.ServiceBus-PAAS.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ServiceBus-PAAS.ps1 $invokeArgs"

#Service
#Storage account for SFTP


#API-M when it is available on ARM
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-APIM")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.APIM-PAAS.ps1 $invokeArgs"


###############################
##Public Services
###############################
#ClipEventProcessing
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-ClipEventProcessing-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-ClipEventProcessing.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ClipEventProcessing-VMs.ps1 $invokeArgs"

##Clipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-Clipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-Clipping.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Clipping-VMs.ps1 $invokeArgs"

##CoreServices
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-CoreServices-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-CoreServices.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServices-VMs.ps1 $invokeArgs"

##CoreServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-CoreServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-CoreServicesMobile.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServicesMobile-VMs.ps1 $invokeArgs"

##Gallery
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-Gallery-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-Gallery.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Gallery-VMs.ps1 $invokeArgs"

##GalleryMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-GalleryMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-GalleryMobile.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.GalleryMobile-VMs.ps1 $invokeArgs"

##MiscServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-MiscServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-MiscServicesMobile.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MiscServicesMobile-VMs.ps1 $invokeArgs"

##MyCard
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-MyCard-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-MyCard.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyCard-VMs.ps1 $invokeArgs"

##MyList
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-MyList-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-MyList.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyList-VMs.ps1 $invokeArgs"

##MyListMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-MyListMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-MyListMobile.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyListMobile-VMs.ps1 $invokeArgs"

##Lite
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-Lite-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-Lite.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Lite-VMs.ps1 $invokeArgs"

##OfferSetup
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-OfferSetup-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-OfferSetup.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.OfferSetup-VMs.ps1 $invokeArgs"

##PartnerClipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-PartnerClipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-PartnerClipping.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.PartnerClipping-VMs.ps1 $invokeArgs"

##ScanMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-ScanMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-ScanMobile.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ScanMobile-VMs.ps1 $invokeArgs"

##SortByAisleMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-SortByAisleMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-SortByAisleMobile.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SortByAisleMobile-VMs.ps1 $invokeArgs"

##WeeklyAdMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-WeeklyAdMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PublicService-VMs-WeeklyAdMobile.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.WeeklyAdMobile-VMs.ps1 $invokeArgs"

################################
###Private Services
################################
##Management
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-Management-VMs")
$invokeArgs += ("-TemplateFile", $PrivateServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.PrivateService-VMs-Management.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Management-VMs.ps1 $invokeArgs"


###############################
##Datastax
###############################

##Datastax
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-DSE")
$invokeArgs += ("-TemplateFile", $DSETemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.DSE-Stack.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.DSE-VMs.ps1 $invokeArgs"

###############################
##HDInsight
###############################

##HDInsightBase
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-HDIBase")
$invokeArgs += ("-TemplateFile", $HDInsightBaseTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.HDInsight-Base.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.HDInsight-Base.ps1 $invokeArgs"

##HDInsight
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZQA1-HDI")
$invokeArgs += ("-TemplateFile", $HDInsightTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-qa1\EMJU.HDInsight-VMs.param.qa1.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.HDInsight-VMs.ps1 $invokeArgs"
