Drop table #IndexContig
/* Controle de Fragmenta��o de �ndices */
Select db_name(dmIndPhys.database_id) As 'Banco de Dados',
OBJECT_SCHEMA_NAME(sObj.id) AS 'Schema',
sObj.Name As 'Nome da Tabela',
sObj.xtype As 'Tipo do Objeto',
sInd.name As 'Nome do �ndice',
dmIndPhys.page_count As 'Page Count',
dmIndPhys.index_id,
dmIndPhys.avg_fragmentation_in_percent As 'Fragmenta��o L�gica (Scan)',
dmIndPhys.avg_fragment_size_in_pages As 'Fragmenta��o (Extent Scan)' ,
dmIndPhys.avg_page_space_used_in_percent As 'M�dia de Densidade (Data Pages)',
dmIndPhys.record_count As 'Qtd de Registros',
dmIndPhys.index_type_desc as 'Tipo de �ndice'
Into #IndexContig
From sys.dm_db_index_physical_stats (db_id(), NULL,NULL, NULL,'SAMPLED') dmIndPhys
Inner Join sys.sysobjects sObj
On dmIndPhys.object_id = sObj.Id
Left Outer Join sys.sysindexes sInd
On dmIndPhys.index_id = sInd.indid
And dmIndPhys.object_id = sInd.id
Where ( dmIndPhys.avg_fragmentation_in_percent > 10
Or dmIndPhys.avg_page_space_used_in_percent < 90
);
Select *
From #IndexContig
Where [Fragmenta��o L�gica (Scan)] >= 10
Order By [Nome da Tabela] Asc,
Case When [Tipo de �ndice] = 'CLUSTERED INDEX'
Then 1
Else 0
End Desc,
[Fragmenta��o L�gica (Scan)] Desc
 
 
 
--Select * From sys.dm_db_index_physical_stats (db_id(), NULL,NULL, NULL,'SAMPLED') dmIndPhys
--Select * from sys.sysindexes
--Select * from sys.indexes
 
