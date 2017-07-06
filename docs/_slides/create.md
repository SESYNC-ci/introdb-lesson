---
---

## Table definition

Table definition uses PostgreSQL  "CREATE TABLE" statements, as shown in the "Scripts" tab of PGStudio.

Simplified a bit, the [documentation](https://www.postgresql.org/docs/current/static/sql-createtable.html) for "CREATE TABLE" follows the pattern:

```
CREATE TABLE [%schema%.]%table% (
  %column_name% %data_type% [%option% ...],
    ...
);
```
{:.text-document title="SQL Worksheet"}

===

## Exercise 2

Write the `CREATE TABLE` statement for a new "observers" table with fields for "id" and "name".

===

## Insert

The "INSERT" statement provides one way to populate a table with records:

~~~
INSERT INTO observers
VALUES (1, 'Alice'), (2, 'Bob');
~~~
{:.text-document title="SQL Worksheet"}

From the database server's perspective, tables are populated with some form of "INSERT" statement.
There are many mechanisms that database clients devise to facilitate importing large data files.
PGStudio, for example, provides a CSV file upload link on the "Data" tab.
A reproducible pipeline that moves data from flat files into a database, however, should include imporation in a script -- and this depends on the data files.
{:.notes}
