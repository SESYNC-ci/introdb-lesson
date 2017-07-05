---
---

## Exercise Solutions

===

## Solution 1


~~~r
df <- dbGetQuery(con, "select species_id, taxa, genus
                       from species")
~~~

~~~
Error in dbGetQuery(con, "select species_id, taxa, genus\n                       from species"): could not find function "dbGetQuery"
~~~
{:.text-document title="lesson-3.R"}

[Return](#exercise-1)
{:.notes}

===

## Solution 2


~~~r
df <- dbGetQuery(con, "select weight, month, plot_type, taxa
                       from surveys
                       join plots on surveys.plot_id = plots.plot_id
                       join species on surveys.species_id = species.species_id
                       where weight is not null")
~~~

~~~
Error in dbGetQuery(con, "select weight, month, plot_type, taxa\n                       from surveys\n                       join plots on surveys.plot_id = plots.plot_id\n                       join species on surveys.species_id = species.species_id\n                       where weight is not null"): could not find function "dbGetQuery"
~~~
{:.text-document title="lesson-3.R"}

[Return](#exercise-2)
{:.notes}
