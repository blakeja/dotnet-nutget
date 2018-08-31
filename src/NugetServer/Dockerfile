FROM microsoft/aspnet
ARG source
WORKDIR /inetpub/wwwroot

COPY ${source:-obj/Docker/publish} .

# Ensure the package folder exists and is writeable
RUN if (!(Test-Path c:\\packages)) { md c:\\packages }

# Ensure we can write to the packages directory
RUN ["icacls c:\\packages /grant users:(OI)(CI)F"]