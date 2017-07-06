---
---

## Characteristics of a Database: Part II

Returning to the big picture, some database terminology doesn't apply to data files at all.
Databases include multiple tables, just as MS Excel includes a multiple spreadsheets in a workbook.
The collection of tables in a **relational database**, however, can be structured by built-in relationships between records from different tables.
Data is assembled in the correct arrangement and "just in time" for analysis using scripted **queries**.

Primary key
: {:.fragment} One or more fields (but *usually* one) that uniquely identify a record in a table.

Foreign key
: {:.fragment} A primary key from one table used in different table to establish a relationship.

Query
: {:.fragment} A temporary table that subsets and/or merges tables according to query parameters.

===

## Primary key

In the `plots` table, `id` is the primary key. Any new record *cannot* duplicate an existing id.

| id | treatment        |
|----+------------------|
|  1 | Control          |
|  2 | Rodent Exclosure |
|  3 | Control          |

===

Question
: What would be the primary key in the animals table. How do you know?

Answer
: {:.fragment} The primary key is `id`, as shown in the table definition script.

===

Primary keys are checked before duplicates end up in the data:

~~~
INSERT INTO plots (id, treatment)
VALUES (1, 'Control');
~~~
{:.text-document title="SQL Worksheet"}

===

## Foreign key

A field may also be designated as a foreign key, which establishes a relationship between tables. A foreign key points to some primary key from a different table.


The "Constraints" tab shows two foreign keys associated with the "animals" table.

- The field `animals(plot_id)` points to the field `plots(id)`
- The field `animals(species_id)` points to the field `species(id)`

===

In the `animals` table, `id` is the primary key and both `plot_id` and `species_id` are foreign keys.

| id | month | day | year | plot_id | species_id | sex | hindfoot_length | weight |
|----+-------+-----+------+---------+------------+-----+-----------------+--------|
|  1 |     7 |  16 | 1977 |       2 | ST         | M   |              32 |   0.45 |
|  2 |     7 |  16 | 1977 |       2 | PX         | M   |              33 |   0.23 |
|  3 |     7 |  16 | 1978 |       1 | RO         | F   |              14 |   1.23 |

===

Foreign keys are checked before nonsensical references end up in the data:

~~~
INSERT INTO animals (id, plot_id)
VALUES (35550, 789);
~~~
{:.text-document title="SQL Worksheet"}

===

## Query

The "Data" tab is an example of a query. It is a temporary table generated on-demand by the RDBMS that takes a subset of the first 25 records from a particular table and displays all columns.
