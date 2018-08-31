# Dotnet NuGet Server

[NuGet.Server](https://github.com/NuGet/NuGet.Server) in a windows docker container

## Requirements

- [.NET Framework 4.6 SDK](https://www.microsoft.com/net/download/visual-studio-sdks)
- [Docker for Windows](https://docs.docker.com/docker-for-windows/install/)

## Docker Image

[blakeja/dotnet-nuget](https://hub.docker.com/r/blakeja/dotnet-nuget/)

## Install

Run Deploy-Container.ps1 from the scripts directory to build the solution and deploy the container to your local docker instance with the following defaults:

  - The NuGet server address will be mapped to http://nugetserver
  - The default package directory will be mapped to c:\packages.
  
#### Configuration

The server address and package directory can be configuring by passing the following parameters to deploy-container.ps1.

- -PackagesDir, docker will map a volume to this directory for persistent package storage, defaults to c:\packages.
- -Hostname, used to map a hostname to the docker container, defaults to "nugetserver"

Specific NuGet.Server settings can be made in the [Web.config](https://github.com/blakeja/dotnet-nutget/blob/master/src/NugetServer/Web.config)

## Licenses

Original files contained with this distribution are licensed under the [MIT License](https://en.wikipedia.org/wiki/MIT_License).

You must agree to the terms of this [license](LICENSE.txt) and abide by them before using, modifying, or distributing source code contained within this distribution.

Some dependencies are under other licenses.
