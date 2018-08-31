[CmdletBinding()]
param( 
	[string]
    $buildToolsDir = "$PSScriptRoot\..\build-tools",

	[string]
    $configuration = "Release", 

	[string]
    $hostname = "nugetserver",

	[string]
    $packagesDirectory = "d:\packages",

	[string]
    $projectDir = "$PSScriptRoot\..\src"
)

$ErrorActionPreference = "Stop"

function Set-EnvironmentVariables()
{
	$env:PACKAGES_FOLDER = $packagesDirectory
	$env:NUGET_HOSTNAME = $hostname
	
	Update-NugetPackages
}

function Update-NugetPackages()
{ 
	Write-Host "--> Restoring packages for $projectDir\NugetServer\NugetServer.cspro" -foregroundcolor "Green"
	Write-Host "--> $PSScriptRoot\nuget.exe restore $projectDir\NugetServer\NugetServer.csproj -PackagesDirectory $projectDir\packages"
	
	& $PSScriptRoot\nuget.exe restore $projectDir\NugetServer\NugetServer.csproj -PackagesDirectory $projectDir\packages
		
	Build-Solution
}

function Build-Solution()
{
	Write-Host "--> Building NugetServer.sln" -foregroundcolor "Green"
	
	$argumentList = @(
		"$projectDir\NugetServer.sln", 
		"/p:Configuration=$configuration",
		"/t:rebuild"
	)
	
	Write-Host "--> & msbuild $argumentList"
	
	& msbuild $argumentList
	
	Deploy-Container
}

function Deploy-Container()
{	
	#Write-Host "--> $imageId = docker images $($hostname):latest --quiet"
	#$imageId = docker images "$($hostname):latest" --quiet
	#Write-Host "--> Image id: $imageId" -foregroundcolor "Green"

	#Write-Host "--> Tagging image $imageid as $($hostname)" -foregroundcolor "Green"
	#Write-Host "--> docker tag $imageId $($hostname)"
	#& docker tag $imageId "$($hostname)"
	
	Write-Host "--> Bringing up container" -foregroundcolor "Green"
	Write-Host "--> docker-compose -f $projectDir\docker-compose.yml -p $hostname up -d"
	& docker-compose -f "$projectDir\docker-compose.yml" -p $hostname up -d
}

Set-EnvironmentVariables