use dbName
go
SELECT '[' + s.name + '].[' + o. name + '].[' + i .name + ']' AS keyname
, 'ALTER TABLE ' + '[' + s. name + '].[' + o .name + '] WITH CHECK CHECK CONSTRAINT [' + i.name + ']' AS command
from sys.foreign_keys i
INNER JOIN sys. objects o ON i.parent_object_id = o.object_id
INNER JOIN sys. schemas s ON o.schema_id = s.schema_id
WHERE i .is_not_trusted = 1 AND i. is_not_for_replication = 0
 
SELECT '[' + s.name + '].[' + o. name + '].[' + i .name + ']' AS keyname
from sys.check_constraints i
INNER JOIN sys. objects o ON i.parent_object_id = o.object_id
INNER JOIN sys. schemas s ON o.schema_id = s.schema_id
WHERE i .is_not_trusted = 1 AND i. is_not_for_replication = 0 AND i.is_disabled = 0

  