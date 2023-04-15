# Wait for SQL Server to start
Write-Host "Waiting for SQL Server to start..."
Start-Sleep -s 60

# Import SQL Server module
Import-Module SqlServer

# Set the parameters for the script
$ServerInstance = "localhost"
$DatabaseName = "YourDatabaseName"
$DacpacPath = "/var/opt/sqlserver/your-database.dacpac"

# Install the database using the .dacpac file
Write-Host "Installing the database..."
Publish-DacPac -DacPacPath $DacpacPath -DatabaseName $DatabaseName -ServerInstance $ServerInstance -SqlCredential (Get-Credential -UserName 'sa' -Message 'Enter the SA password') -UpgradeExisting

# Keep the container running
Write-Host "Database installed successfully. Keeping container running..."
while($true) {
    Start-Sleep -s 60
}
