function setup
{
	param([string]$version)

    $tmpDirRootPath = $version + '/tmp'

    # Copy the shared files to the target directory
    copy-item -Force -recurse shared "$tmpDirRootPath/shared"
    
    $dockerFileTemplatePath = '.\shared\misc\Dockerfile'
    $dockerFileOutPath = "$version\Dockerfile"

    # Generate the Dockerfile from the template and place it in the target directory
    # Also, copy Tomcat version specific files to the target directory
    switch ($version)
    {
        '8.5-jre8'
        {
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:8u212-zulu-alpine-with-tools') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_APPINSIGHTS_ENABLED__','1' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','8.5.39' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','8' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR_MINOR__', '8.5'
            break
        }

        '8.5-java11'
        {
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:11u3-zulu-alpine-with-tools') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_APPINSIGHTS_ENABLED__','0' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','8.5.39' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','8' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR_MINOR__', '8.5' 
            break
        }

        '9.0-jre8'
        {
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:8u212-zulu-alpine-with-tools') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_APPINSIGHTS_ENABLED__','1' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','9.0.17' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','9' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR_MINOR__', '9.0'
            break
        }

        '9.0-java11'
        {
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:11u3-zulu-alpine-with-tools') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_APPINSIGHTS_ENABLED__','0' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','9.0.17' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','9' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR_MINOR__', '9.0'
            break
        }
    }
    $headerFooter = "########################################################`n### ***DO NOT EDIT*** This is an auto-generated file ###`n########################################################`n"
    $content = $headerFooter + $content + $headerFooter
    Set-Content -Value $content -Path $dockerFileOutPath
}

setup -version '8.5-jre8'
setup -version '9.0-jre8'
setup -version '8.5-java11'
setup -version '9.0-java11'
