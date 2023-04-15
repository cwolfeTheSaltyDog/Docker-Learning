docker build -t sqlserver2019-dacpac .
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrong!Passw0rd' -e 'MSSQL_PID=Developer' -p 1433:1433 --name sqlserver2019-dacpac -d sqlserver2019-dac
