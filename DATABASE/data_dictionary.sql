-- Data Dictionary for DealershipDB Project
-- Use this script to view the table structure, column types, keys, and nullability
-- NOTE: Replace 'dealership_db' with your actual database/schema name

SELECT 
    table_name AS 'Table',
    column_name AS 'Column',
    column_type AS 'Type',
    is_nullable AS 'Nullable',
    column_key AS 'Key',
    column_default AS 'Default',
    extra AS 'Extra'
FROM 
    information_schema.COLUMNS
WHERE 
    table_schema = '' 
ORDER BY 
    table_name, ordinal_position;

