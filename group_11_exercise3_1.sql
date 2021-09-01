/* 1 */
/*first we need to connect to the database we created, e.g. prakt database.
For that we use the command:
/connect prakt
*/

/* now we can use the '/d+' command to list all schemas and their corresponding tables.
Or we can use sql:*/

/* \x on (we activate extended display in psql terminal for better readability)*/

SELECT table_schema, table_name, column_name
FROM information_schema.columns
WHERE table_schema = 'public' 
ORDER BY table_name ASC;

/* 2 */

SELECT indexname
FROM pg_indexes;

/* 3 */

/* first we run vacuumdb command as postgres user */
/* $sudo su postgres
   $vacuumdb --analyze --verbose prakt
*/
/* now we can look at the last analyze */

SELECT *
FROM pg_stat_all_tables;

SELECT *
FROM pg_stat_database;

/* 4 */

SELECT * FROM pg_stats 
WHERE tablename = 'orders'
AND attname = 'orderkey'
OR attname = 'totalprice';

/* To answer the second part, we need to realize that n_distinct is the ratio of distinct values and total number of rows in a table. Negative value means the distinct values increase as the table grows. So, we multiply it by -1. */

select n_distinct * (
select count(*) from orders) * (-1) as unique_values_count
from pg_stats
where tablename = 'orders'
AND attname = 'orderkey'
OR attname = 'totalprice'
group by unique_values_count;

/* 5 */

SELECT COUNT(indexrelname)
FROM pg_stat_all_indexes;

/* 6 */

SELECT * FROM pg_stats WHERE tablename = 'orders'
AND attname = 'orderkey'
OR attname = 'totalprice'
AND constraint_type = 'FOREIGN KEY';

/* 7 */
/* just a mildly interesting thing I found about psql string concat*/

SELECT 2||' times'||' 3 equals: '|| 2*3 AS multiple;
