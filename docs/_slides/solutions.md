---
---

## Exercise Solutions

===

## Solution 1


~~~r
df <- dbGetQuery(con, "select species_id, taxa, genus
                       from species")
~~~
{:.text-document title="lesson-3.R"}

<aside class="notes" markdown="block">
[Return](#exercise-1)
</aside>

===

## Solution 2


~~~r
df <- dbGetQuery(con, "select weight, month, plot_type, taxa
                       from surveys
                       join plots on surveys.plot_id = plots.plot_id
                       join species on surveys.species_id = species.species_id
                       where weight is not null")
~~~
{:.text-document title="lesson-3.R"}

<aside class="notes" markdown="block">
[Return](#exercise-2)
</aside>












