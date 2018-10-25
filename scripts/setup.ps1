function setup
{
	param([string]$version)
   
	$dirpath = $version + '/tmp/shared'
	
	If (Test-Path $dirpath)
	{
		remove-item -recurse -force $dirpath
	}
	
	copy-item -recurse shared $dirpath
}

setup -version '8.5-jre8'
setup -version '9.0-jre8'
