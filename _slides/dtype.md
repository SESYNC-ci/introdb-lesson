---
---

## Data Types

A key tactic in data quality control is precise (and enforceable!) definitions of the values allowed for each field.
We just saw `integer`, `text` and the slightly more complicated `serial`.

Some of the essential data types, specifically for a PostgreSQL database.
{:.fragment data-fragment-index="1"}

| Type      | Description                                                                                             |
|-----------+---------------------------------------------------------------------------------------------------------|
| integer   | whole numbers between -2,147,483,648 and 2,147,483,647                                                  |
| double    | Inexact, variable-precision numeric value that can represent almost any number, and several non-numbers |
| decimal   | Exact numeric value with user-specified precision (decimal places)                                      |
| char      | Fixed-length character string                                                                           |
| varchar   | Variable-length (up to a limit) character string                                                        |
| boolean   | True or False                                                                                           |
| date      | day with no time specification                                                                          |
{:.fragment data-fragment-index="1"}

<!--split-->

### Data Granularity

The degree to which information is broken up into diferent fields is called **granularity**, and it's an important consideration in database design.
On one hand, because it is easier to aggregate fields than disaggregate them down the road, initially erring on the side of too granular is best.
On the other hand, some consideration of how each field will get used can lead to less granularity.

Question
: In the surveys table, the date is broken into three integer fields. What are some advantages and disadvantages of such fine granularity over using a single field of type date?
{:.fragment}

<!--split-->

### Extensions

The most complicated data types encountered so far are `serial` and `date`, but these come built-in to the standard PostgreSQL database management system (and many others).
A database feature noted earlier is the ability to extend the available data types, wither by installing plugins or writing your own.

A popular extension for PostgreSQL is PostGIS, which adds spatially aware data types and functions.

| Data type | Description                                                                  |
|-----------+------------------------------------------------------------------------------|
| Geometry  | Planar/Cartesian coordinates and calculations                                |
| Geography | Spheroidal geodetic objects, drawn on the earth’s curved surface.            |
| Raster    | Space as a grid of rectangular cells, associated with a numeric array/bands. |
| Topology  | Models spatial objects as a network of connected nodes, edges, and faces.    |

<!--split-->

PostGIS functions allow you to query your database on spatial relations, which act sort of like foreign key relationships.
Jumping way ahead of ourselves, let's see an example of what PostGIS can do.

Log out of the `portal` database, and log in to the database `postgis_in_action`.
Table `restaurants` has a point geometry field, and table `highways` has a linestring geometry.
Which franchises in Maryland are within 500 meters of a highway?

[//]: # " SET search_path TO myschema,public; "

~~~
SELECT franchise, name
FROM restaurants
JOIN highways on ST_DWithin(restaurants.geom, highways.geom, 500)
WHERE state = 'MD';
~~~
{:.input}

Learn more about PostGIS and this database from ["PostGIS in Action" by Regina O. Obe and Leo S. Hsu](https://www.manning.com/books/postgis-in-action-second-edition).
