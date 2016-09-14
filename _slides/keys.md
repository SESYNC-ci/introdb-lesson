---
---

## Characteristics of a Database: Part II

Returning to terminology, some database tools don't apply to data files at all.
Databases include a *collection* of tables, just as MS Excel includes a collection of spreadsheets in a workbook.
The collection of tables in a **relational database**, however, is structured by relationships between records from different tables.

Relationships are specified through primary and foreign keys, but which is which depends on context.

## Primary key

One or more fields (but *usually* one) that uniquely identify a record in a table.

Question
: What would be the primary key in the surveys table. How do you know?

<!--split-->

## Primary key

In the `plots` table, `plot_id` is the primary key.

| plot_id | plot_type        |
|---------+------------------|
|       1 | Control          |
|       2 | Rodent Exclosure |
|       3 | Control          |

As a result, a new record *cannot* duplicate any plot_id.

~~~r
dbGetQuery(con, "insert into plots
                 (plot_id, plot_type)
                 values (1, 'Control')")
~~~
{:.text-document title="lesson-3.R"}

~~~
Error in sqliteSendQuery(con, statement, bind.data) : 
  rsqlite_query_send: could not execute1: UNIQUE constraint failed: plots.plot_id
~~~
{:.output}

## Foreign key

A primary key from table A used in table B to express their relationship.

Question
: Identify a primary / foreign key pair in the portal workbook.

<!--split-->

## Foreign key

In the `surveys` table, `record_id` is the primary key and `plot_id` is a foreign key.

| record_id | month | day | year | plot_id | species_id | sex | hindfoot_length | weight |
|-----------+-------+-----+------+---------+------------+-----+-----------------+--------|
|         1 |     7 |  16 | 1977 |       2 | ST         | M   |              32 |   0.45 |
|         2 |     7 |  16 | 1977 |       2 | PX         | M   |              33 |   0.23 |
|         3 |     7 |  16 | 1978 |       1 | RO         | F   |              14 |   1.23 |

<!--split-->

With a properly designed database, references to invalid foreign keys *cannot* be entered.

~~~r
dbGetQuery(con, "insert into surveys
                 (record_id, plot_id, species_id, sex)
                 values (35549, 1, '00', 'M')")
~~~
{:.text-document title="lesson-3.R"}

~~~
Error in sqliteSendQuery(con, statement, bind.data) : 
  rsqlite_query_send: could not execute1: FOREIGN KEY constraint failed
~~~
{:.output}

<!--split-->

## Normalized data is Tidy data

Proper use of table relationships is a challenging part of database design.
The objective is **normalization**, or taking steps to minimize data redundency.

For example, the genus and species names are not associated with every survey record -- only with the species_id.
Data about the species is a different "observational unit" than data about the individual caught in a survey.
{:.fragment}

With an ideal database design, any value discovered to be erroneous should only have to be corrected in one record in one table.
{:.fragment}

<!--split-->

Question
: Currently, `plots` is pretty sparse. What other kind of data might go into plots?

Answer
: {:.framgnet} Additional properties, such as location, that do not change over time.
