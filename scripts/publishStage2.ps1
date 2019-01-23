[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True, HelpMessage="Example: 1809132007")]
    [string]$timestamp,

    [Parameter(Mandatory=$True, HelpMessage="Example: appsvctest")]
    [string]$sourceRepoName,

    [Parameter(Mandatory=$True, HelpMessage="Example: appsvc")]
    [string]$targetRepoName
)

$ErrorActionPreference = "Stop"

function GetImage
{
   param([string]$repoName, [string]$version, [string]$timestamp)
   
   $image = $repoName + '/tomcat:' + $version + '_' + $timestamp
   
   return $image
}

function Publish
{
    param([string]$version, [string]$timestamp)

    $sourceImage = GetImage -repoName $sourceRepoName -version $version -timestamp $timestamp
    $destinationImage = GetImage -repoName $targetRepoName -version $version -timestamp '0000000000'

    # Just an extra precaution
    docker rmi -f $destinationImage
    
    Write-Host -ForegroundColor Green Pulling $sourceImage
    docker pull $sourceImage

    Write-Host -ForegroundColor Green Tagging $destinationImage
    docker tag $sourceImage $destinationImage
   
    Write-Host -ForegroundColor Green **Pushing** $destinationImage
    docker push $destinationImage
}

### Main

if ($timestamp -eq '0000000000')
{
    $msg='ERROR: Parameter $timestamp=' + $timestamp + ' not allowed. Use some other timestamp value as parameter!'
    Write-Host -ForegroundColor Red $msg
    return;
}

Publish -version '8.5-jre8' -timestamp $timestamp
Publish -version '9.0-jre8' -timestamp $timestamp
