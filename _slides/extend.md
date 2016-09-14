---
---

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

Log out of the `portal` database, and log in to the database `postgis_in_action` then select `ch01` from the Schema drop-down menu.

Question
: Look at the different tables and find the fields with spatial data types. What type does `restaurants` have, and what type does `highways` have?

<!--split-->

The following query will list the restaurant franchises in Maryland that are within 500 meters of a highway.

~~~
SELECT franchise, name
FROM ch01.restaurants
JOIN ch01.highways on ST_DWithin(restaurants.geom, highways.geom, 500)
WHERE state = 'MD';
~~~
{:.input}

Exercise
: PostGIS includes spatially aware function, such as `ST_DWithin` which tests distance relationships. The function `ST_AsText()` will convert a geometry into human readable text, and the command `ST_Transform(geom, 4326)` will transform `geom` to geographical coordinates (i.e. latitude and longitude). Modify the SQL so that it prints an additional field that gives you coordinates (rather than the name of the highway) of the franchises in Maryland.

[//]: # " ST_AsText(ST_Transform(restaurants.geom, 4326)) "

Learn more about PostGIS and this database from ["PostGIS in Action" by Regina O. Obe and Leo S. Hsu](https://www.manning.com/books/postgis-in-action-second-edition).
