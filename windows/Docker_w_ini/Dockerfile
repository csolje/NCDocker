#############################################################################################
##
## Description:
##
## Revision history:
## v1.0, 2018-10-23 Initial version        Christian Soelje (chso@netcompany.com) Netcompany
##
#############################################################################################
# Install MSSQL
# Specifying the Container Image
FROM microsoft/windowsservercore:latest

# Copy MSSQL SETUP FILES INTO THE CONTAINER
ADD ./SqlServer2016 c:/source

# Install DOTNET AND MSSQL 2016
RUN powershell.exe -command \
Install-WindowsFeature -Name NET-Framework-Features -IncludeAllSubFeature -Source c:/source/sxs; \
c:/source/setup.exe /configurationfile=c:/source/configurationfile.ini /Q; \
sc.exe config MSSQLSERVER obj=LocalSystem; \
Remove-Item c:/source -Recurse