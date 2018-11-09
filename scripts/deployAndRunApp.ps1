[CmdletBinding()]
Param(
	[Parameter(Mandatory=$False, HelpMessage="Example: perftest1. This will create a web app http://perftest1.azurewebsites.net")]
	[string]$webAppName,

	[Parameter(Mandatory=$True, HelpMessage="Example: myrepo/tomcat:8.5-jre8")]
	[string]$imageName,

	[Parameter(Mandatory=$False, HelpMessage="Example: A Valid GUID key OR Empty")]
	[string]$appInsightsInstrumentationKey
)

function loadPage()
{
    param([string]$url)

    Write-Host "Connecting to '$url'"

    $startTime = Get-Date

    $success = $false
    $statusCode = 0
    $durationInSeconds = 0
    $maxDurationInSeconds = 210 # arbitrarily chosen maximum time we want to wait for the web app to load

    while ($success -eq $false -and $durationInSeconds -le $maxDurationInSeconds)
    {
        $exception = $null

        try
        {
            $result = Invoke-WebRequest -Uri $url

            $statusCode = $result.statusCode
            $success = ($statusCode -eq 200)
        }
        catch
        {
            $exception = $_.Exception
            $statusCode = $_.Exception.Response.StatusCode.value__
            $succes = $false
        }

        Write-Host "    >> Status code : '$statusCode' | Success : '$success'"

        # If we don't have status code for some reason, log the exception.
        # This can happen if the site hostname is incorrect or if the site doesn't exist for some reason.
        if ([string]::IsNullOrWhiteSpace($statusCode))
        {
            Write-Host "    >> Exception: $exception"
        }

        $currentTime = Get-Date
        $durationInSeconds = ($currentTime - $startTime).TotalSeconds

        # Wait for a while before retrying
        if ($success -eq $false)
        {
            $t = 5
            Write-Host Sleeping for $t seconds
            sleep $t
        }
    }

    $color = 'Red'
    if ($success)
    {
        $color = 'Green'
    }

    Write-Host -ForegroundColor $color "Page load summary | Success : $success | StatusCode : $statusCode | Exception : $exception"
}

Write-Host -ForegroundColor Green "======================= TEST BEGIN ======================="

# If webAppName is not specified, generate one.
if ([string]::IsNullOrWhiteSpace($webAppName))
{
    $webAppName = [guid]::NewGuid()
}
else
{
    Write-Host -ForegroundColor Yellow "****Warning**** Be sure that app identified by webAppName = '$webAppName' does not exist to measure new app creation time"
    $t = 10
    Write-Host -ForegroundColor Yellow "****Warning**** Script will proceed in $t seconds"
    sleep $t
}

$preDeploymentTimestamp = Get-Date
.\deployApp.ps1 -webAppName $webAppName -imageName $imageName -appInsightsInstrumentationKey $appInsightsInstrumentationKey
$postDeploymentTimestamp = Get-Date

$url = "https://$webAppName.azurewebsites.net"

Write-Host -ForegroundColor Green "Load web app. Attempt #1"
loadPage -url $url
$startupTimestamp1 = Get-Date

Write-Host -ForegroundColor Green "Load web app. Attempt #2"
loadPage -url $url
$startupTimestamp2 = Get-Date

Write-Host -ForegroundColor Green "Load web app. Attempt #3"
loadPage -url $url
$startupTimestamp3 = Get-Date

Write-Host "Pre deployment timestamp : $preDeploymentTimestamp"
Write-Host "Post deployment timestamp : $postDeploymentTimestamp"
Write-Host "Startup timestamp1: $startupTimestamp1"
Write-Host "Startup timestamp2: $startupTimestamp2"
Write-Host "Startup timestamp3: $startupTimestamp3"

$deploymentDuration = [math]::Round( ($postDeploymentTimestamp - $preDeploymentTimestamp).TotalSeconds )
$startupDuration1 = [math]::Round( ($startupTimestamp1 - $postDeploymentTimestamp).TotalSeconds )
$startupDuration2 = [math]::Round( ($startupTimestamp2 - $startupTimestamp1).TotalSeconds )
$startupDuration3 = [math]::Round( ($startupTimestamp3 - $startupTimestamp2).TotalSeconds )

Write-Host -ForegroundColor Green "======================== RESULTS ========================"
Write-Host -ForegroundColor Green "webAppName: $webAppName | webAppUrl: http://$webAppName.azurewebsites.net | imageName: $imageName | appInsightsInstrumentationKey: $appInsightsInstrumentationKey"
Write-Host -ForegroundColor Green "Build and deployment duration: $deploymentDuration seconds"
Write-Host -ForegroundColor Green "First page load duration: $startupDuration1 seconds"
Write-Host -ForegroundColor Green "Second page load duration: $startupDuration2 seconds"
Write-Host -ForegroundColor Green "Third page load duration: $startupDuration3 seconds"
Write-Host -ForegroundColor Green "====================== TEST COMPLETE======================"

