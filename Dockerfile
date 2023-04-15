# Use the official Microsoft SQL Server 2019 image
FROM mcr.microsoft.com/mssql/server:2019-latest

# Set environment variables for the SQL Server instance
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrong!Passw0rd
ENV MSSQL_PID=Developer

# Install required tools
USER root
RUN apt-get update \
    && apt-get install -y curl apt-transport-https gnupg lsb-release \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-buster-prod buster main" > /etc/apt/sources.list.d/microsoft.list' \
    && apt-get update \
    && apt-get install -y mssql-tools unixodbc-dev powershell

# Add mssql-tools to the PATH
ENV PATH="${PATH}:/opt/mssql-tools/bin"

# Switch back to the mssql user
USER mssql

# Create a directory to store the PowerShell script and .dacpac file
RUN mkdir /var/opt/sqlserver

# Copy the PowerShell script and .dacpac file to the container
COPY install-database.ps1 /var/opt/sqlserver/install-database.ps1
COPY your-database.dacpac /var/opt/sqlserver/your-database.dacpac

# Run the PowerShell script to install the database
CMD [ "pwsh", "/var/opt/sqlserver/install-database.ps1" ]
