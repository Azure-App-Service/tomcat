[CmdletBinding()]
Param(
	[Parameter(Mandatory=$True, HelpMessage="Example: perftest1. This will create a web app http://perftest1.azurewebsites.net")]
	[string]$webAppName,

	[Parameter(Mandatory=$True, HelpMessage="Example: myrepo/tomcat:8.5-jre8")]
	[string]$imageName,

	[Parameter(Mandatory=$False, HelpMessage="Example: A Valid GUID key OR Empty")]
	[string]$appInsightsInstrumentationKey
)

$env:RESOURCEGROUP_NAME='tomcat-perftest'
$env:WEBAPP_NAME=$webAppName
$env:WEBAPP_PLAN_NAME=$webAppName # use the same name for the web app and app service plan
$env:IMAGE_NAME=$imageName
$env:APPINSIGHTS_INSTRUMENTATIONKEY=$appInsightsInstrumentationKey
$env:REGION='westus'

Write-Host -ForegroundColor Green "Deploying to '$env:WEBAPP_NAME'"
Write-Host -ForegroundColor Green "Container Name: '$env:IMAGE_NAME'"
Write-Host -ForegroundColor Green "Resource group: '$env:RESOURCEGROUP_NAME'"
Write-Host -ForegroundColor Green "APPINSIGHTS_INSTRUMENTATIONKEY: '$env:APPINSIGHTS_INSTRUMENTATIONKEY'"

mvn package
mvn azure-webapp:deploy
