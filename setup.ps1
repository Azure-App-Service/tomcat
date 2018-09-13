[CmdletBinding()]
Param(
	[Parameter(Mandatory=$True, HelpMessage="Example: 8.5-jre8")]
	[string]$version
)

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

setup -version $version
