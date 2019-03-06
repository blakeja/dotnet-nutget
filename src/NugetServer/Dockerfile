FROM mcr.microsoft.com/dotnet/framework/aspnet
ARG source
ENV PACKAGES_FOLDER=c:\\packages
WORKDIR /inetpub/wwwroot

COPY ${source:-obj/Docker/publish} .

RUN if (!(Test-Path (Get-Item env:PACKAGES_FOLDER).Value)) { md (Get-Item env:PACKAGES_FOLDER).Value }

RUN icacls (Get-Item env:PACKAGES_FOLDER).Value /grant (\"users:(OI)(CI)F\")