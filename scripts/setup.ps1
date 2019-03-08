function setup
{
	param([string]$version)

    # Remove tmp directory
	$dirpath = $version + '/tmp/shared'
	If (Test-Path $dirpath)
	{
		remove-item -recurse -force $dirpath
	}

    # Copy the shared files to the target directory
    copy-item -recurse shared $dirpath
    copy-item -recurse shared\tomcat\common\* $version

    $dockerFileTemplatePath = '.\shared\tomcat\common\Dockerfile'
    $dockerFileOutPath = "$version\Dockerfile"

    # Generate the Dockerfile from the template and place it in the target directory
    # Also, copy Tomcat version specific files to the target directory
    switch ($version)
    {
        '8.5-jre8'
        {
        	copy-item -recurse shared\tomcat\8.5\* $version
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:8u202-zulu-alpine') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','8.5.35' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','8'
            break
        }

        '8.5-java11'
        {
        	copy-item -recurse shared\tomcat\8.5\* $version
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:11u2-zulu-alpine') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','8.5.35' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','8' 
            break
        }

        '9.0-jre8'
        {
        	copy-item -recurse shared\tomcat\9.0\* $version
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:8u202-zulu-alpine') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','9.0.13' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','9'
            break
        }

        '9.0-java11'
        {
        	copy-item -recurse shared\tomcat\9.0\* $version
            $content = ((Get-Content -path $dockerFileTemplatePath -Raw) `
                -replace '__PLACEHOLDER_BASEIMAGE__','mcr.microsoft.com/java/jre-headless:11u2-zulu-alpine') `
                -replace '__PLACEHOLDER_AI_VERSION__','2.1.2' `
                -replace '__PLACEHOLDER_TOMCAT_VERSION__','9.0.13' `
                -replace '__PLACEHOLDER_TOMCAT_MAJOR__','9'
            break
        }
    }
    $headerFooter = "################################################`n***DO NOT EDIT*** This is an auto-generated file`n################################################`n"
    $content = $headerFooter + $content + $headerFooter
    Set-Content -Value $content -Path $dockerFileOutPath
}

setup -version '8.5-jre8'
setup -version '9.0-jre8'
setup -version '8.5-java11'
setup -version '9.0-java11'
