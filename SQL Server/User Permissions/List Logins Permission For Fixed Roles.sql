WITH CTE_Role (name, role, type_desc)
AS (SELECT PRN.name,
           srvrole.name AS [role],
           PRN.type_desc
    FROM sys.server_role_members membership
        INNER JOIN
        (
            SELECT *
            FROM sys.server_principals
            WHERE type_desc = 'SERVER_ROLE'
        ) srvrole
            ON srvrole.principal_id = membership.role_principal_id
        RIGHT JOIN sys.server_principals PRN
            ON PRN.principal_id = membership.member_principal_id
    WHERE PRN.type_desc NOT IN ( 'SERVER_ROLE' )
          AND PRN.is_disabled = 0
    UNION ALL
    SELECT p.[name],
           'ControlServer',
           p.type_desc AS loginType
    FROM sys.server_principals p
        JOIN sys.server_permissions Sp
            ON p.principal_id = Sp.grantee_principal_id
    WHERE Sp.class = 100
          AND Sp.[type] = 'CL'
          AND state = 'G')
SELECT name,
       type_desc,
       CASE
           WHEN [public] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'Public',
       CASE
           WHEN [sysadmin] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'SysAdmin',
       CASE
           WHEN [securityadmin] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'SecurityAdmin',
       CASE
           WHEN [serveradmin] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'ServerAdmin',
       CASE
           WHEN [setupadmin] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'SetupAdmin',
       CASE
           WHEN [processadmin] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'ProcessAdmin',
       CASE
           WHEN [diskadmin] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'DiskAdmin',
       CASE
           WHEN [dbcreator] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'DBCreator',
       CASE
           WHEN [bulkadmin] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'BulkAdmin',
       CASE
           WHEN [ControlServer] = 1 THEN
               'Y'
           ELSE
               'N'
       END AS 'ControlServer'
FROM CTE_Role
    PIVOT
    (
        COUNT(role)
        FOR role IN ([public], [sysadmin], [securityadmin], [serveradmin], [setupadmin], [processadmin], [diskadmin],
                     [dbcreator], [bulkadmin], [ControlServer]
                    )
    ) AS pvt
WHERE type_desc NOT IN ( 'SERVER_ROLE' )
ORDER BY name,
         type_desc;