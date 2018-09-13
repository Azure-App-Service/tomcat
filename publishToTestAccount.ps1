[CmdletBinding()]
Param(
    [Parameter(Mandatory=$False, HelpMessage="Example: appsvctest")]
    [string]$repoName='appsvctest'
)

$ErrorActionPreference = "Stop"

function GetImage
{
    param([string]$version, [string]$tag)

    $image = $RepoName + '/tomcat:' + $version + '_' + $tag

    return $image
}

function Build
{
    param([string]$version, [string]$tag)

    .\setup.ps1 -version $version

    $image = GetImage -version $version -tag $tag

    Write-Host -ForegroundColor Green Building $image
    Write-Host -ForegroundColor Green docker build --no-cache -t $image $version
    docker build --no-cache -t $image $version
}

function Publish
{
    param([string]$version, [string]$tag)

    $tag1=$tag
    $tag2='0000000000'

    $image1 = GetImage -version $version -tag $tag1
    $image2 = GetImage -version $version -tag $tag2

    Write-Host -ForegroundColor Green **Pushing** $image1
    docker push $image1

    Write-Host -ForegroundColor Green Tagging $image2
    docker tag $image1 $image2

    Write-Host -ForegroundColor Green **Pushing** $image2
    docker push $image2
}

$localTime=get-date
$utcTime=$localTime.ToUniversalTime()

$tag = $utcTime.ToString('yyMMddHHmm')

Build -version '8.5-jre8' -tag $tag
Build -version '9.0-jre8' -tag $tag

Publish -version '8.5-jre8' -tag $tag
Publish -version '9.0-jre8' -tag $tag

