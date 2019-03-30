[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True, HelpMessage="Example: appsvctest")]
    [string]$repoName
)

$ErrorActionPreference = "Stop"

function GetImage
{
    param([string]$version, [string]$timestamp)

    $image = $RepoName + '/tomcat:' + $version + '_' + $timestamp

    return $image
}

function Build
{
    param([string]$directory, [string]$version, [string]$timestamp)

    .\scripts\setup.ps1 -version $version

    $image = GetImage -version $version -timestamp $timestamp
    $gitcommit=(git log -1 --pretty=%H)

    Write-Host -ForegroundColor Green Building $image

    $buildcmd = "docker build --no-cache --build-arg GIT_COMMIT=$gitcommit -t $image $directory"
    Write-Host -ForegroundColor Green $buildcmd

    # Run the build command
    Invoke-Expression -Command $buildcmd
}

function Publish
{
    param([string]$version, [string]$timestamp)

    $timestamp1=$timestamp
    $timestamp2='0000000000'

    $image1 = GetImage -version $version -timestamp $timestamp1
    $image2 = GetImage -version $version -timestamp $timestamp2

    Write-Host -ForegroundColor Green **Pushing** $image1
    docker push $image1

    docker tag $image1 $image2

    Write-Host -ForegroundColor Green **Pushing** $image2
    docker push $image2
}


### Main

if ($repoName -eq 'appsvc')
{
    $msg='ERROR: Parameter $repoName=' + $repoName + ' not allowed. Use some other repoName value as parameter!'
    Write-Host -ForegroundColor Red $msg
    return;
}

$localTime=get-date
$utcTime=$localTime.ToUniversalTime()

$timestamp = $utcTime.ToString('yyMMddHHmm')

Build -directory '8.5-jre8' -version '8.5-jre8' -timestamp $timestamp
Build -directory '9.0-jre8' -version '9.0-jre8' -timestamp $timestamp
Build -directory '8.5-java11' -version '8.5-java11' -timestamp $timestamp
Build -directory '9.0-java11' -version '9.0-java11' -timestamp $timestamp

Publish -version '8.5-jre8' -timestamp $timestamp
Publish -version '9.0-jre8' -timestamp $timestamp
Publish -version '8.5-java11' -timestamp $timestamp
Publish -version '9.0-java11' -timestamp $timestamp
