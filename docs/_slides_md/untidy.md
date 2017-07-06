---
---

## Normalized data is Tidy data

Proper use of table relationships is a challenging part of database design.
The objective is **normalization**, or taking steps to define logical "observational units" and minimize data redundency.

For example, the genus and species names are not attributes of an animal: they are attributes of the species attributed to an animal.
Data about a species belongs in a different observational unit from data about the animal captured in a survey.
{:.fragment}

With an ideal database design, any value discovered to be erroneous should only have to be corrected in one record in one table.
{:.fragment}

===

Question
: Currently, `plots` is pretty sparse. What other kind of data might go into plots?

Answer
: {:.framgnet} Additional properties, such as location, that do not change between surveys.

===

## Un-tidy data with JOINs

Record, store, and read data in the most normalized form possible. Only untidy your tables as needed for particular analyses.
The most common operation for untidying is to "join" tables.

For example, to carry out a regression of animal weight against plot treatment using the R command:

```
lm(weight ~ treatment, data = portal)
```
{:.input}

you'll need a data.frame called `portal` with rows for each animal that also includes a "treatment" inferred from "plot_id".

===

Now suppose you want to statistically control for genus in this regression, using the R command:

```
lm(weight ~ genus + treatment, data = portal)
```
{:.input}

You'll need an additional column for genus in the `portal` data.frame inferred from the "species_id" and species table.

===

## Relations

The creation of an "untidy" table should scripted and it's life temporary: make untidy tables with a query including a "JOIN" clause.

There are two kinds of relations -- schemas that use primary and foreign key references -- that permit table joins:

- One-To-Many
- Many-To-Many

===

### One-To-Many Relationship

The primary key in the first table is referred to multiple times in the foreign key of the second table.

![]({{ site.baseurl }}/images/many-to-one-1.svg){: width="80%" style="border:0px;"}
{:.captioned}

===

## Exercise 4

Examine the primary and foreign keys on the three tables by checking the "Columns" and "Constraints" tabs. Identify all the one-to-many relationships.

===

The SQL keyword "JOIN" matches up two tables in the way dictated by the constraint following "ON", duplicating records as necessary.

```
SELECT weight, treatment
FROM animals
JOIN plots ON animals.plot_id = plots.id;
```
{:.text-document title="SQL Worksheet"}

The resulting table could be the basis for the `portal` data.frame needed in the R command `lm(weight ~ treatment, data = portal)`.

===

### Many-To-Many Relationship

Each primary key from the first table may relate to any number of primary keys from the second table, and *vice versa*.  eachother any number of times. A many-to-many relationship is induced by the existance of an "association table" involved in **two** one-to-many relations.

![]({{ site.baseurl }}/images/many-to-many-3.svg){: width="80%" style="border:0px;"}
{:.captioned}

Animals is an "association table" because it includes two foreign keys.

===

```
SELECT weight, genus, treatment
FROM animals
JOIN plots ON animals.plot_id = plots.id
JOIN species ON animals.species_id = species.id;
```
{:.text-document title="SQL Worksheet"}

The resulting table could be the basis for the `portal` data.frame needed in the R command `lm(weight ~ genus + treatment, data = portal)`.

===

## Exercise 5

In a previous exercise, you created an observers table. Use a `CREATE TABLE` statement to make a new association table establishing a many-to-many relation between animals and observers. The resulting table should allow you to record information on which observer(s) caught and measured each animal. (The result will then also record which animals were handled by each observer.)

Hint: Examine the “Script” tab for the animals table to see the keyword “REFERENCES” in action.
