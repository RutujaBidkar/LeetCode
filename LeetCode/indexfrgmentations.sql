What Is Index Fragementation ?
Index fragmentation occurs when the pages of index is out of orders or contains too much empty space 
making SQL Server read more pages than necessary.

How to Check Fragmentation

SQL Server provides a Dynamic Management View (DMV):
SELECT
    OBJECT_NAME(object_id) AS TableName,
    index_id,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats
(
    DB_ID(),
    OBJECT_ID('Consumers'),
    NULL,
    NULL,
    'DETAILED'
);

How to Fix Fragmentation
Reorganize Index
Rebuild Index
