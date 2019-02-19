[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True, HelpMessage="Example: 1809132007")]
    [string]$timestamp,

    [Parameter(Mandatory=$True, HelpMessage="Example: appsvctest")]
    [string]$sourceRepoName,

    [Parameter(Mandatory=$True, HelpMessage="Example: appsvc")]
    [string]$targetRepoName,

    [Parameter(Mandatory=$True, HelpMessage="If this is true, it will push not only the _0000000000 tag, but also the original (sourceRepoName) tag")]
    [bool]$pushOriginalTag
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
    param([string]$version, [string]$timestamp, [bool]$pushOriginalTag)

    $sourceImage = GetImage -repoName $sourceRepoName -version $version -timestamp $timestamp
    $destinationImageOriginalTagName = GetImage -repoName $targetRepoName -version $version -timestamp $timestamp
    $destinationImageZeroTagName = GetImage -repoName $targetRepoName -version $version -timestamp '0000000000'

    if ($pushOriginalTag)
    {
        # Just an extra precaution
        docker rmi -f $destinationImageOriginalTagName
    
        Write-Host -ForegroundColor Green Tagging $destinationImageOriginalTagName
        docker tag $sourceImage $destinationImageOriginalTagName
   
        Write-Host -ForegroundColor Green **Pushing** $destinationImageOriginalTagName
        docker push $destinationImageOriginalTagName
    }

    Write-Host -ForegroundColor Green Pulling $sourceImage
    docker pull $sourceImage

    # Just an extra precaution
    docker rmi -f $destinationImageZeroTagName
    
    Write-Host -ForegroundColor Green Tagging $destinationImageZeroTagName
    docker tag $sourceImage $destinationImageZeroTagName
   
    Write-Host -ForegroundColor Green **Pushing** $destinationImageZeroTagName
    docker push $destinationImageZeroTagName
}

### Main

if ($timestamp -eq '0000000000')
{
    $msg='ERROR: Parameter $timestamp=' + $timestamp + ' not allowed. Use some other timestamp value as parameter!'
    Write-Host -ForegroundColor Red $msg
    return;
}

Publish -version '8.5-jre8' -timestamp $timestamp -pushOriginalTag $pushOriginalTag
Publish -version '9.0-jre8' -timestamp $timestamp -pushOriginalTag $pushOriginalTag
Publish -version '8.5-java11' -timestamp $timestamp -pushOriginalTag $pushOriginalTag
Publish -version '9.0-java11' -timestamp $timestamp -pushOriginalTag $pushOriginalTag
