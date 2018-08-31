[CmdletBinding()]
param( 
	[string]
    $Configuration = "Release", 

	[string]
    $Hostname = "nugetserver",

	[string]
    $PackagesDir = "C:\packages",

	[string]
    $ProjectDir = "$PSScriptRoot\..\src"
)

$ErrorActionPreference = "Stop"

function Set-EnvironmentVariables()
{
	$env:PACKAGES_FOLDER = $PackagesDir
	$env:NUGET_HOSTNAME = $Hostname
	
	Update-NugetPackages
}

function Update-NugetPackages()
{ 
	Write-Host "--> Restoring packages for $ProjectDir\NugetServer\NugetServer.cspro" -foregroundcolor "Green"
	Write-Host "--> $PSScriptRoot\nuget.exe restore $ProjectDir\NugetServer\NugetServer.csproj -PackagesDirectory $ProjectDir\packages"
	
	& $PSScriptRoot\nuget.exe restore $ProjectDir\NugetServer\NugetServer.csproj -PackagesDirectory $ProjectDir\packages
		
	Build-Solution
}

function Build-Solution()
{
	Write-Host "--> Building NugetServer.sln" -foregroundcolor "Green"
	
	$argumentList = @(
		"$ProjectDir\NugetServer.sln", 
		"/p:Configuration=$Configuration",
		"/t:rebuild"
	)
	
	Write-Host "--> & msbuild $argumentList"
	
	& msbuild $argumentList
	
	Deploy-Container
}

function Deploy-Container()
{	
	Write-Host "--> Bringing up container" -foregroundcolor "Green"
	Write-Host "--> docker-compose -f $ProjectDir\docker-compose.yml -p $Hostname up -d"
	& docker-compose -f "$ProjectDir\docker-compose.yml" -p $Hostname up -d
}

Set-EnvironmentVariables