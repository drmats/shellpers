# PostgreSQL

## sizes

* database
    ```sql
    SELECT pg_size_pretty(pg_database_size('database_name'));
    ```
* table
    ```sql
    SELECT pg_size_pretty(pg_table_size('schema_name.table_name'));
    ```


## connections

* total number
    ```sql
    SELECT sum(numbackends) AS conn FROM pg_stat_database;
    ```

* details
    ```sql
    SELECT * FROM pg_stat_activity;
    ```

* drop connection by `pid` (current pids are present
    in `pg_stat_activity` table)
    ```sql
    SELECT pg_terminate_backend(pid);
    ```

* current connection `pid`
    ```sql
    SELECT pg_backend_pid();
    ```
