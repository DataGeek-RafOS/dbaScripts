
```
--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:Connect DRACO-OP01
/*
CREATE AVAILABILITY GROUP [DRACO-AG]
WITH (AUTOMATED_BACKUP_PREFERENCE = PRIMARY,
DB_FAILOVER = ON,
DTC_SUPPORT = NONE,
REQUIRED_SYNCHRONIZED_SECONDARIES_TO_COMMIT = 0)
FOR DATABASE [Geral]
REPLICA ON N'DRACO-AZ01' WITH (ENDPOINT_URL = N'TCP://draco-az01.oab.org.br:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = NO)),
	N'DRACO-OP01' WITH (ENDPOINT_URL = N'TCP://draco-op01.oab.org.br:5023', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));
GO
USE [master]
GO
ALTER AVAILABILITY GROUP [DRACO-AG]
ADD LISTENER N'DRACO' (
WITH IP
((N'10.0.2.9', N'255.255.255.0'),
(N'192.168.0.9', N'255.255.255.0')
)
, PORT=1433);
GO
*/
use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [CFOAB\OabSQLServer]
GO
:Connect DRACO-AZ01
USE [master]
GO
CREATE ENDPOINT [Hadr_endpoint] 
	AS TCP (LISTENER_PORT = 5022)
	FOR DATA_MIRRORING (ROLE = ALL, ENCRYPTION = REQUIRED ALGORITHM AES)
GO
IF (SELECT state FROM sys.endpoints WHERE name = N'Hadr_endpoint') <> 0
BEGIN
	ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED
END
GO
use [master]
GO
GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [CFOAB\OabSQLServer]
GO
:Connect DRACO-AZ01
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END
GO
:Connect DRACO-OP01
USE [master]
GO
ALTER AVAILABILITY GROUP [DRACO-AG]
ADD REPLICA ON N'DRACO-AZ01' WITH (ENDPOINT_URL = N'TCP://draco-az01.oab.org.br:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));
GO
:Connect DRACO-AZ01
ALTER AVAILABILITY GROUP [DRACO-AG] JOIN;
GO
ALTER AVAILABILITY GROUP [DRACO-AG] GRANT CREATE ANY DATABASE;
GO
GO
```
