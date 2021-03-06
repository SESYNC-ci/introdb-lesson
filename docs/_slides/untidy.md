---
---

## Normalized Data is Tidy

Proper use of table relationships is a challenging part of database design. The
objective is **normalization**, or taking steps to define logical "observational
units" and minimize data redundency.

For example, the genus and species names are not attributes of an animal: they
are attributes of the species attributed to an animal. Data about a species
belongs in a different observational unit from data about the animal captured in
a survey. With an ideal database design, any value discovered to be erroneous
should only have to be corrected in one record in one table.
{:.notes}

===

Question
: Currently, `plots` is pretty sparse. What other kind of data might go into plots?

Answer
: {:.fragment} Additional properties, such as location, that do not change between surveys.

===

## Un-tidy data with JOINs

A good data management principle is to record and store data in the most
normalized form possible, and un-tidy your tables as needed for particular
analyses. The SQL "JOIN" clause lets you create records with fields from
multiple tables.

Consider for example what you must do to carry out a regression of animal weight
against plot treatment using the R command:



~~~r
lm(weight ~ treatment,
   data = portal)
~~~
{:.text-document .no-eval title="{{ site.data.lesson.handouts[0] }}"}


You need a "data.frame" called `portal` with rows for each animal that also
includes a "treatment" inferred from "plot_id".

===

Additionally suppose you want to account for genus in this regression, expanding
the previous R command to:



~~~r
lm(weight ~ genus + treatment,
   data = portal)
~~~
{:.text-document .no-eval title="{{ site.data.lesson.handouts[0] }}"}


You need another column for genus in the `portal` data.frame, inferred from
"species_id" for each animal and the species table.

===

## Relations

There are two kinds of relations--schemas that use primary and foreign key
references--that permit table joins:

- One-To-Many
- Many-To-Many

===

### One-To-Many Relationship

The primary key in the first table is referred to multiple times in the foreign
key of the second table.

![]({% include asset.html path="images/many-to-one-1.svg" %}){: width="80%" style="border:0px;"}
{:.captioned}

===

The SQL keyword "JOIN" matches up two tables in the way dictated by the
constraint following "ON", duplicating records as necessary.



~~~sql
SELECT weight, treatment
FROM animals
JOIN plots
  ON animals.plot_id = plots.id;
~~~



The resulting table could be the basis for the `portal` data.frame needed in the
R command `lm(weight ~ treatment, data = portal)`.

===

### Many-To-Many Relationship

Each primary key from the first table may relate to any number of primary keys
from the second table **and** *vice versa*. A many-to-many relationship is
induced by the existance of an "association table" involved in **two**
one-to-many relations.

![]({% include asset.html path="images/many-to-many-3.svg" %}){: width="80%" style="border:0px;box-shadow:none;"}
{:.captioned}

Animals is an "association table" because it includes two foreign keys.

===



~~~sql
SELECT weight, genus, treatment
FROM animals
JOIN plots
  ON animals.plot_id = plots.id
JOIN species
  ON animals.species_id = species.id;
~~~



The resulting table could be the basis for the `portal` data.frame needed in the
R command `lm(weight ~ genus + treatment, data = portal)`.


