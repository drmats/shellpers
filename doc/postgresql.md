# PostgreSQL

## administrative tasks

* `SElinux` configuration if database location is changed
    ```bash
    semanage fcontext -a -t postgresql_db_t "/absolute/path/to/datadir(/.*)?"
    restorecon -R -v /absolute/path/to/datadir
    ls -ldZ /absolute/path/to/datadir
    ```

* `psql` administrative connection
    - local
        ```bash
        sudo -i
        sudo -u postgres psql
        ```
    - remote
        ```bash
        psql -d template1 -h [DATABASE_HOST] -p 5432 -U postgres
        ```

* create password for superuser
    ```sql
    ALTER ROLE postgres
    WITH ENCRYPTED PASSWORD 'XXXXXXXX';
    ```

* create unprivileged user
    ```sql
    CREATE ROLE averagejoe
    WITH
        NOSUPERUSER NOCREATEDB NOCREATEROLE
        NOINHERIT LOGIN NOREPLICATION NOBYPASSRLS
        ENCRYPTED PASSWORD 'XXXXXXXX';
    ```

* (re-)create database
    ```sql
    DROP DATABASE IF EXISTS awesome;
    CREATE DATABASE awesome
    WITH OWNER = 'postgres' TEMPLATE = 'template0' ENCODING = 'utf8';
    ```


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

* number of active TCP
    ```bash
    watch -n 0.5 \
        "netstat -np | grep tcp | grep ESTABLISHED | grep postgres | wc -l"
    ```

* total number
    ```sql
    SELECT sum(numbackends) AS conn FROM pg_stat_database;
    ```

* maximum allowed
    ```sql
    SHOW max_connections;
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


## configuration reload

```sql
SELECT pg_reload_conf();
```


## version checking

```sql
SELECT version();
SELECT postgis_full_version();
SELECT current_database();  -- `\c` in psql
```


## psql

* show SQL queries for all backslash commands
    ```
    psql -E
    ```

* basic backslash commands
    - `\l` - list databases
    - `\c` - current connection information
    - `\c dbname` - connect to database
    - `\dt` - list tables
