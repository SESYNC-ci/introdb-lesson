---
---

## Characteristics of a Database II

Returning to terminology, some database concepts don't apply to data files at all.
Databases include a *collection* of tables.
You might call a mere collection of tables a data wharehouse -- or an IKEA.
The collection of tables in a **relational database** is structured by relationships between records from different tables.
These relations are specified through primary and foreign keys, but which is which depends on context.

Primary Key
: One or more fields (but *usually* one) that uniquely identify a record in a table.
: e.g. `plot_id` in the `plots` table, or more succinctly `plots(plot_id)`
  
Foreign Key
: A primary key from table A used in table B to express their relationship.
: e.g. `plot_id` in the surveys table, or `surveys(plot_id)`
{:.fragment}
  
<!--split-->

In the `plots` table, `plot_id` is the primary key.

| plot_id | plot_type        |
|---------+------------------|
|       1 | Control          |
|       2 | Rodent Exclosure |
|       3 | Control          |
  
In the `surveys` table, `record_id` is the primary key and `plot_id` is a foreign key.

| record_id | year | month | day | plot_id | species_id | sex | weight | ... |
|-----------+------+-------+-----+---------+------------+-----+--------+-----|
|         1 | 1977 |    11 |   5 |       2 | ST         | M   |   0.45 |     |
|         2 | 1977 |    11 |   5 |       2 | PX         | M   |   0.23 |     |
|         3 | 1978 |     1 |  23 |       1 | RO         | F   |   1.23 |     |

<!--split-->

### One-To-Many Relationship

![]({{ site.baseurl }}/images/many-to-one.svg){: width="80%"}

<!--split-->

### Many-To-Many Relationship

![]({{ site.baseurl }}/images/many-to-many.svg){: width="80%"}

<!--split-->

Proper use of table relationships is a great challenge in database design.
The guiding principle is **normalization**, or taking steps to minimize data redundency.

With an ideal database design, any value discovered to be erroneous should only have to be corrected in one record in one table.

Question
: Based on your first look at the `plots` and `surveys` tables, does it look possible to further normalize this database?
{:.fragment}
