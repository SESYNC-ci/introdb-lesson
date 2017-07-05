---
---

## Structured Query Language (SQL)

SQL is a high-level language for interacting with relational databases.
Commands use intuitive English words but can be strung together and nested in powerful ways.

We have used the "CREATE TABLE" and "INSERT" statements, but most SQL is written to perform "SELECT" statements.

===

## Basic queries

Let’s write a SQL query that selects only the year column from the surveys
table. Select the ![]({{ site.baseurl }}/images/sql-button.png) button, paste in and run the following script.

```
SELECT year FROM surveys;
```
{:.text-document title="SQL Worksheet"}
	
A note on style: we have capitalized the words SELECT and FROM because they are SQL keywords.
Unlike R, SQL is case insensitive, but it helps for readability – good style. 

===

To select data from multiple fields, include multiple fields as a comma-separated list right after SELECT:

```
SELECT year, month, day
FROM surveys;
```
{:.text-document title="SQL Worksheet"}

The line break before `FROM` is also good form, particularly as the length of the query grows.

===

Or select all of the columns in a table using a wildcard:

```
SELECT *
FROM surveys;
```
{:.text-document title="SQL Worksheet"}

### Limit

We can use the LIMIT statement to select only the first few rows. This is particularly helpful when getting
a feel for very large tables.

```
SELECT year, species_id
FROM surveys
LIMIT 10;
```
{:.text-document title="SQL Worksheet"}

### Unique values

If we want only the unique values so that we can quickly see what species have
been sampled we use ``DISTINCT``

```
SELECT DISTINCT species_id
FROM surveys;
```
{:.text-document title="SQL Worksheet"}

If we select more than one column, then the distinct pairs of values are
returned

```
SELECT DISTINCT year, species
FROM surveys;
```
{:.text-document title="SQL Worksheet"}
	
### Calculated values

We can also do calculations with the values in a query.
For example, if we wanted to look at the mass of each individual
on different dates, but we needed it in kg instead of g we would use

```
SELECT year, month, day, weight / 1000.0
FROM surveys;
```
{:.text-document title="SQL Worksheet"}

The expression ``weight / 1000.0`` is evaluated for each row
and appended to that row, in a new column.

===

Expressions can use any fields, any arithmetic operators (+ - * /) and a variety of built-in functions. For
example, we could round the values to make them easier to read.

```
SELECT plot_id, species_id, sex, weight, ROUND(weight / 1000.0, 2)
FROM surveys;
```
{:.text-document title="SQL Worksheet"}

The underlying data in the wgt column of the table does not change. The query, which exists separately from the data,
simply displays the calculation we requested in the query result window pane.
{:.notes}

===

You can assign the new column a name by typing "AS weight_kg" after the expression

```
SELECT plot_id, species_id, sex, weight, ROUND(weight / 1000.0, 2) AS weight_kg
FROM surveys;
```
{:.text-document title="SQL Worksheet"}

## Exercise

Write a query that returns the year, month, day, species ID, and weight in mg.

## Filtering

Databases can also filter data – selecting only those records meeting certain
criteria.  For example, let’s say we only want data for the species "Dipodomys
merriami", which has a species code of "DM".  We need to add a WHERE clause to our
query:

```
SELECT *
FROM surveys
WHERE species_id = 'DM';
```
{:.text-document title="SQL Worksheet"}

===

We can do the same thing with numbers.
Here, we only want the data since 2000:

```
SELECT *
FROM surveys
WHERE year >= 2000;
```
{:.text-document title="SQL Worksheet"}

===

More sophisticated conditions arise from combining tests with AND and OR.
For example, suppose we want the data on Dipodomys merriami starting in the year
2000:

```
SELECT *
FROM surveys
WHERE year >= 2000 AND species_id = 'DM';
```
{:.text-document title="SQL Worksheet"}

===

Parentheses can be used to help with readability and to ensure that AND and OR are combined in the way that we
intend. If we wanted to get all the surveys for "DM" since 2000 or up to 1990 we could combine the tests using OR:

```
SELECT *
FROM surveys
WHERE (year >= 2000 OR year <= 1990) AND species_id = 'DM';
```
{:.text-document title="SQL Worksheet"}















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
