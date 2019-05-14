#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see http://aka.ms/containercompat 

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.7.2-windowsservercore-ltsc2019
ARG source
ENV PACKAGES_FOLDER=c:\\packages
WORKDIR /inetpub/wwwroot
COPY ${source:-obj/Docker/publish} .
RUN if (!(Test-Path (Get-Item env:PACKAGES_FOLDER).Value)) { md (Get-Item env:PACKAGES_FOLDER).Value }
RUN icacls (Get-Item env:PACKAGES_FOLDER).Value /grant (\"users:(OI)(CI)F\")