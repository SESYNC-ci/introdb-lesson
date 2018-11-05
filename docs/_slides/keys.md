---
---

## Database Characteristics: II

Returning to the bigger picture and our comparison of storing data in files as
opposed to a database, there are some concepts that only apply to databases. We
have seen that databases include multiple tables--so far, that's not so
different from keeping multiple spreadsheets in one MS Excel workbook or in
multiple CSV files. The collection of tables in a **relational database**,
however, can be structured by built-in relationships between records from
different tables. Data is assembled in the correct arrangement for analysis
"just in time" by scripting database queries that join tables on these
relationships.
{:.notes}

| **Primary key** | One or more fields (but *usually* one) that uniquely identify a record in a table. |
| **Foreign key** | A primary key from one table used in different table to establish a relationship. |
| **Query** | Collect values from tables based on their relationships and other constraints. |

===

### Primary Keys

In the `plots` table, `id` is the primary key. Any new record *cannot* duplicate an existing id.

| id | treatment        |
|----+------------------|
|  1 | Control          |
|  2 | Rodent Exclosure |
|  3 | Control          |

===

Creating the `observers` table with `id` as a primary key will prevent the
duplication observed from multiple identical `dbWriteTable` calls.




~~~r
dbCreateTable(con, 'observers', list(
  id = 'serial primary key',
  name = 'text'
))
~~~
{:.text-document title="{{ site.handouts[0] }}"}


===

When appending a data frame to the table created with "serial primary key",
the `id` is automatically generated and unique.



~~~r
df <- data.frame(
  name = c('Alice', 'Bob')
)
dbWriteTable(con, 'observers', df,
             append = TRUE)
~~~
{:.text-document title="{{ site.handouts[0] }}"}




~~~r
> tbl(con, 'observers')
~~~
{:.input title="Console"}


~~~
# Source:   table<observers> [?? x 2]
# Database: postgres [student@docker01.research.sesync.org:5432/portal]
     id name 
  <int> <chr>
1     1 Alice
2     2 Bob  
~~~
{:.output}


===

Primary keys are checked **before** duplicates end up in the data, throwing an
error if necessary.



~~~r
df <- data.frame(
  id = c(1),
  name = c('J. Doe')
)
dbWriteTable(con, 'observers', df,
             append = TRUE)
~~~
{:.text-document title="{{ site.handouts[0] }}"}


~~~
Error in connection_copy_data(conn@ptr, sql, value): COPY returned error: ERROR:  duplicate key value violates unique constraint "observers_pkey"
DETAIL:  Key (id)=(1) already exists.
CONTEXT:  COPY observers, line 1
~~~
{:.output}


===

### Foreign Keys

A field may also be designated as a foreign key, which establishes a
relationship between tables. A foreign key points to some primary key from a
different table.

===

In the `animals` table, `id` is the primary key and both `plot_id` and
`species_id` are foreign keys.

| id | month | day | year | plot_id | species_id | sex | hindfoot_length | weight |
|----+-------+-----+------+---------+------------+-----+-----------------+--------|
|  1 |     7 |  16 | 1977 |       2 | ST         | M   |              32 |   0.45 |
|  2 |     7 |  16 | 1977 |       2 | PX         | M   |              33 |   0.23 |
|  3 |     7 |  16 | 1978 |       1 | RO         | F   |              14 |   1.23 |

===

Foreign keys are checked **before** nonsensical references end up in the data:



~~~r
df <- data.frame(
  month = 7,
  day = 16,
  year = 1977,
  plot_id = -1
)
dbWriteTable(con, 'animals', df,
             append = TRUE)
~~~
{:.text-document title="{{ site.handouts[0] }}"}


~~~
Error in connection_copy_data(conn@ptr, sql, value): COPY returned error: ERROR:  insert or update on table "animals" violates foreign key constraint "animals_plot_id_fkey"
DETAIL:  Key (plot_id)=(-1) is not present in table "plots".
~~~
{:.output}


===

### Query

Structured Query Language (SQL) is a high-level language for interacting with
relational databases. Commands use intuitive English words but can be strung
together and nested in powerful ways. SQL is not the *only* way to query a
database from R (cf. [dbplyr](){:.rlib}), but sometimes it is the only way to
perform a complicated query.
{:.notes}

To write SQL statements in RStudio, use the `sql` engine for code chunks in a 
RMarkdown file:

```
```{sql, connection = con}
...
```
```

===

### Basic queries

Let’s write a SQL query that selects only the year column from the animals
table.



~~~sql
SELECT year FROM animals;
~~~




| year|
|----:|
| 1977|
| 1977|
| 1977|
| 1977|
| 1977|
| 1977|
| 1977|
| 1977|
| 1977|
| 1977|


A note on style: we have capitalized the words SELECT and FROM because they are
SQL keywords. Unlike R, SQL is case insensitive, so capitalization only helps
for readability and is a good style to adopt.
{:.notes}

===

To select data from multiple fields, include multiple fields as a
comma-separated list right after SELECT:



~~~sql
SELECT year, month, day
FROM animals;
~~~




| year| month| day|
|----:|-----:|---:|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|
| 1977|     7|  16|


The line break before `FROM` is also good form, particularly as the length of the query grows.

===

Or select all of the columns in a table using a wildcard:



~~~sql
SELECT *
FROM animals;
~~~




|id | month| day| year| plot_id|species_id |sex | hindfoot_length| weight|
|:--|-----:|---:|----:|-------:|:----------|:---|---------------:|------:|
|2  |     7|  16| 1977|       3|NL         |M   |              33|     NA|
|3  |     7|  16| 1977|       2|DM         |F   |              37|     NA|
|4  |     7|  16| 1977|       7|DM         |M   |              36|     NA|
|5  |     7|  16| 1977|       3|DM         |M   |              35|     NA|
|6  |     7|  16| 1977|       1|PF         |M   |              14|     NA|
|7  |     7|  16| 1977|       2|PE         |F   |              NA|     NA|
|8  |     7|  16| 1977|       1|DM         |M   |              37|     NA|
|9  |     7|  16| 1977|       1|DM         |F   |              34|     NA|
|10 |     7|  16| 1977|       6|PF         |F   |              20|     NA|
|11 |     7|  16| 1977|       5|DS         |F   |              53|     NA|


===

### Limit

We can use the LIMIT statement to select only the first few rows. This is
particularly helpful when getting a feel for very large tables.



~~~sql
SELECT year, species_id
FROM animals
LIMIT 4;
~~~




| year|species_id |
|----:|:----------|
| 1977|NL         |
| 1977|DM         |
| 1977|DM         |
| 1977|DM         |


===

### Unique values

If we want only the unique values so that we can quickly see what species have
been sampled we use ``DISTINCT``



~~~sql
SELECT DISTINCT species_id
FROM animals;
~~~




|species_id |
|:----------|
|NA         |
|CB         |
|RM         |
|PB         |
|PE         |
|AB         |
|AH         |
|SS         |
|US         |
|RX         |


===

If we select more than one column, then the distinct pairs of values are
returned



~~~sql
SELECT DISTINCT year, species_id
FROM animals;
~~~




| year|species_id |
|----:|:----------|
| 1997|RM         |
| 2002|NL         |
| 1995|RX         |
| 1999|SS         |
| 1985|DM         |
| 1982|PP         |
| 1989|CB         |
| 1994|OT         |
| 1978|NL         |
| 1997|NL         |


===

### Calculations

We can also do calculations with the values in a query. For example, if we
wanted to look at the mass of each individual, by plot, species, and sex, but we
needed it in kg instead of g we would use



~~~sql
SELECT plot_id, species_id,
  sex, weight / 1000.0
FROM animals;
~~~




| plot_id|species_id |sex | ?column?|
|-------:|:----------|:---|--------:|
|       3|NL         |M   |       NA|
|       2|DM         |F   |       NA|
|       7|DM         |M   |       NA|
|       3|DM         |M   |       NA|
|       1|PF         |M   |       NA|
|       2|PE         |F   |       NA|
|       1|DM         |M   |       NA|
|       1|DM         |F   |       NA|
|       6|PF         |F   |       NA|
|       5|DS         |F   |       NA|


The expression `weight / 1000.0` is evaluated for each row
and appended to that row, in a new column.

===

You can assign the new column a name by typing "AS weight_kg" after the
expression.



~~~sql
SELECT plot_id, species_id, sex,
  weight / 1000 AS weight_kg
FROM animals;
~~~




| plot_id|species_id |sex | weight_kg|
|-------:|:----------|:---|---------:|
|       3|NL         |M   |        NA|
|       2|DM         |F   |        NA|
|       7|DM         |M   |        NA|
|       3|DM         |M   |        NA|
|       1|PF         |M   |        NA|
|       2|PE         |F   |        NA|
|       1|DM         |M   |        NA|
|       1|DM         |F   |        NA|
|       6|PF         |F   |        NA|
|       5|DS         |F   |        NA|


===

Expressions can use any fields, any arithmetic operators (+ - * /) and a variety
of built-in functions. For example, we could round the values to make them
easier to read.



~~~sql
SELECT plot_id, species_id, sex,
  ROUND(weight / 1000.0, 2) AS weight_kg
FROM animals;
~~~




| plot_id|species_id |sex | weight_kg|
|-------:|:----------|:---|---------:|
|       3|NL         |M   |        NA|
|       2|DM         |F   |        NA|
|       7|DM         |M   |        NA|
|       3|DM         |M   |        NA|
|       1|PF         |M   |        NA|
|       2|PE         |F   |        NA|
|       1|DM         |M   |        NA|
|       1|DM         |F   |        NA|
|       6|PF         |F   |        NA|
|       5|DS         |F   |        NA|


The underlying data in the wgt column of the table does not change. The query,
which exists separately from the data, simply displays the calculation we
requested in the query result window pane.
{:.notes}

===

## Filtering

Databases can also filter data – selecting only those records meeting certain
criteria.  For example, let’s say we only want data for the species "Dipodomys
merriami", which has a species code of "DM".  We need to add a `WHERE` clause to
our query.



~~~sql
SELECT *
FROM animals
WHERE species_id = 'DM';
~~~




| id| month| day| year| plot_id|species_id |sex | hindfoot_length| weight|
|--:|-----:|---:|----:|-------:|:----------|:---|---------------:|------:|
|  3|     7|  16| 1977|       2|DM         |F   |              37|     NA|
|  4|     7|  16| 1977|       7|DM         |M   |              36|     NA|
|  5|     7|  16| 1977|       3|DM         |M   |              35|     NA|
|  8|     7|  16| 1977|       1|DM         |M   |              37|     NA|
|  9|     7|  16| 1977|       1|DM         |F   |              34|     NA|
| 12|     7|  16| 1977|       7|DM         |M   |              38|     NA|
| 13|     7|  16| 1977|       3|DM         |M   |              35|     NA|
| 14|     7|  16| 1977|       8|DM         |NA  |              NA|     NA|
| 15|     7|  16| 1977|       6|DM         |F   |              36|     NA|
| 16|     7|  16| 1977|       4|DM         |F   |              36|     NA|


===

Of course, we can do the same thing with numbers.



~~~sql
SELECT *
FROM animals
WHERE year >= 2000;
~~~




|id    | month| day| year| plot_id|species_id |sex | hindfoot_length| weight|
|:-----|-----:|---:|----:|-------:|:----------|:---|---------------:|------:|
|30159 |     1|   8| 2000|       1|PP         |F   |              22|     17|
|30160 |     1|   8| 2000|       1|DO         |M   |              35|     53|
|30161 |     1|   8| 2000|       1|PP         |F   |              21|     17|
|30162 |     1|   8| 2000|       1|DM         |M   |              36|     50|
|30163 |     1|   8| 2000|       1|PP         |M   |              20|     16|
|30164 |     1|   8| 2000|       1|PB         |M   |              26|     27|
|30165 |     1|   8| 2000|       1|PP         |F   |              22|     15|
|30166 |     1|   8| 2000|       1|PP         |M   |              23|     19|
|30167 |     1|   8| 2000|       1|DO         |M   |              35|     41|
|30168 |     1|   8| 2000|       1|PB         |M   |              25|     24|


===

More sophisticated conditions arise from combining tests with AND and OR. For
example, suppose we want the data on *Dipodomys merriami* starting in the year
2000.



~~~sql
SELECT *
FROM animals
WHERE year >= 2000 AND species_id = 'DM';
~~~




|    id| month| day| year| plot_id|species_id |sex | hindfoot_length| weight|
|-----:|-----:|---:|----:|-------:|:----------|:---|---------------:|------:|
| 30162|     1|   8| 2000|       1|DM         |M   |              36|     50|
| 30179|     1|   8| 2000|      12|DM         |M   |              36|     60|
| 30196|     1|   8| 2000|      17|DM         |M   |              37|     52|
| 30197|     1|   8| 2000|      17|DM         |F   |              34|     43|
| 30210|     1|   8| 2000|      22|DM         |M   |              38|     56|
| 30215|     1|   8| 2000|      22|DM         |F   |              34|     28|
| 30227|     1|  10| 2000|       4|DM         |M   |              34|     45|
| 30241|     1|  10| 2000|      11|DM         |M   |              35|     43|
| 30242|     1|  10| 2000|      11|DM         |M   |              35|     44|
| 30244|     1|  10| 2000|      11|DM         |M   |              35|     44|


===

Parentheses can be used to help with readability and to ensure that AND and OR
are combined in the way that we intend. If we wanted to get all the animals for
"DM" since 2000 or up to 1990 we could combine the tests using OR:



~~~sql
SELECT *
FROM animals
WHERE (year >= 2000 OR year <= 1990)
  AND species_id = 'DM';
~~~




| id| month| day| year| plot_id|species_id |sex | hindfoot_length| weight|
|--:|-----:|---:|----:|-------:|:----------|:---|---------------:|------:|
|  3|     7|  16| 1977|       2|DM         |F   |              37|     NA|
|  4|     7|  16| 1977|       7|DM         |M   |              36|     NA|
|  5|     7|  16| 1977|       3|DM         |M   |              35|     NA|
|  8|     7|  16| 1977|       1|DM         |M   |              37|     NA|
|  9|     7|  16| 1977|       1|DM         |F   |              34|     NA|
| 12|     7|  16| 1977|       7|DM         |M   |              38|     NA|
| 13|     7|  16| 1977|       3|DM         |M   |              35|     NA|
| 14|     7|  16| 1977|       8|DM         |NA  |              NA|     NA|
| 15|     7|  16| 1977|       6|DM         |F   |              36|     NA|
| 16|     7|  16| 1977|       4|DM         |F   |              36|     NA|

