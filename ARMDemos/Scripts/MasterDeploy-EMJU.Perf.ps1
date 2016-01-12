#
# Master.ps1
#

#Login-AzureRmAccount

$tenantID = "b7f604a0-00a9-4188-9248-42f3a5aac2e9"
$subscriptionID = "ec4b8e6e-6a27-4430-a1ac-3ded010cb563"
$subscriptionName = "EMJU-pf"
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

$subscriptionArgs = @()
$subscriptionArgs += ("-ResourceGroupLocation", $ResourceGroupLocation)
$subscriptionArgs += ("-SubscriptionID",$subscriptionID)
$subscriptionArgs += ("-SubscriptionName",$subscriptionName)
$subscriptionArgs += ("-TenantID",$tenantID)


Set-AzureRmContext -SubscriptionId $subscriptionID -TenantId $tenantID #-SubscriptionName $subscriptionName

#Network
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-Network")
$invokeArgs += ("-TemplateFile", $NetworkTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.Network.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Network.ps1 $invokeArgs"

###############################
#Admin VMs
###############################

#Rdp Jump
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-RdpJump-VMs")
$invokeArgs += ("-TemplateFile", $RdpJumpTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.RdpJump-VMs.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.RdpJump-VMs.ps1 $invokeArgs"

#SFTP
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-SFTP-VMs")
$invokeArgs += ("-TemplateFile", $SFTPTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.SFTP-VMs.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SFTP-VMs.ps1 $invokeArgs"

#SSH Bastion
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-SSH-VMs")
$invokeArgs += ("-TemplateFile", $SSHBastionTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.SSH-VMs.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SSH-VMs.ps1 $invokeArgs"

###############################
##FileSharing
###############################

##FILESHARE
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-FILESHARE")
$invokeArgs += ("-TemplateFile", $FileSharingTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.FileShare-Storage.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.FileShare-Storage.ps1 $invokeArgs"

###############################
##PaaS Services
###############################
#Redis
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-REDIS")
$invokeArgs += ("-TemplateFile", $RedisCacheTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.RedisCache-PAAS.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Redis-Cache.ps1 $invokeArgs"

#ServiceBus
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-SERVICEBUS")
$invokeArgs += ("-TemplateFile", $ServiceBusTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.ServiceBus-PAAS.param.pf.json")
$invokeArgs += $subscriptionArgs
Invoke-Expression ".\Deploy-EMJU.ServiceBus-PAAS.ps1 $invokeArgs"

#Storage account for SFTP
#API-M when it is available on ARM

##############################
#Public Services
##############################
#ClipEventProcessing
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-ClipEventProcessing-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-ClipEventProcessing.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ClipEventProcessing-VMs.ps1 $invokeArgs"

#Clipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-Clipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-Clipping.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Clipping-VMs.ps1 $invokeArgs"

#CoreServices
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-CoreServices-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-CoreServices.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServices-VMs.ps1 $invokeArgs"

#CoreServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-CoreServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-CoreServicesMobile.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.CoreServicesMobile-VMs.ps1 $invokeArgs"

#Gallery
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-Gallery-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-Gallery.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Gallery-VMs.ps1 $invokeArgs"

#GalleryMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-GalleryMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-GalleryMobile.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.GalleryMobile-VMs.ps1 $invokeArgs"

#MiscServicesMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-MiscServicesMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-MiscServicesMobile.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MiscServicesMobile-VMs.ps1 $invokeArgs"

#MyCard
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-MyCard-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-MyCard.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyCard-VMs.ps1 $invokeArgs"

#MyList
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-MyList-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-MyList.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyList-VMs.ps1 $invokeArgs"

#MyListMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-MyListMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-MyListMobile.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.MyListMobile-VMs.ps1 $invokeArgs"

#Lite
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-Lite-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-Lite.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Lite-VMs.ps1 $invokeArgs"

#OfferSetup
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-OfferSetup-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-OfferSetup.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.OfferSetup-VMs.ps1 $invokeArgs"

#PartnerClipping
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-PartnerClipping-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-PartnerClipping.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.PartnerClipping-VMs.ps1 $invokeArgs"

#ScanMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-ScanMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-ScanMobile.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.ScanMobile-VMs.ps1 $invokeArgs"

#SortByAisleMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-SortByAisleMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-SortByAisleMobile.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.SortByAisleMobile-VMs.ps1 $invokeArgs"

#WeeklyAdMobile
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-WeeklyAdMobile-VMs")
$invokeArgs += ("-TemplateFile", $PublicServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PublicService-VMs-WeeklyAdMobile.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.WeeklyAdMobile-VMs.ps1 $invokeArgs"

###############################
##Private Services
###############################
#Management
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-Management-VMs")
$invokeArgs += ("-TemplateFile", $PrivateServiceTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.PrivateService-VMs-Management.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.Management-VMs.ps1 $invokeArgs"



###############################
##Datastax
###############################

##Datastax
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-DSE")
$invokeArgs += ("-TemplateFile", $DSETemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.DSE-Stack.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.DSE-VMs.ps1 $invokeArgs"

###############################
##HDInsight
###############################
$invokeArgs = @()
$invokeArgs += ("-ResourceGroupName","EMJU-AZPF-HDI")
$invokeArgs += ("-TemplateFile", $HDInsightTemplate)
$invokeArgs += ("-TemplateParametersFile","..\Templates\EMJU-pf\EMJU.HDInsight-VMs.param.pf.json")
$invokeArgs += $subscriptionArgs
#Invoke-Expression ".\Deploy-EMJU.HDInsight-VMs.ps1 $invokeArgs"