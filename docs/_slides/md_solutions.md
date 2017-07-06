---
---

## Solutions

### Solution 1

~~~
CREATE TABLE public.species (
   id   text   NOT NULL   PRIMARY KEY,
   genus   text NOT NULL,
   species   text,
   taxa   text
);
~~~
{:.text-document title="SQL Worksheet"}

[Return](#exercise-1)
{:.notes}

===

### Solution 2

~~~
CREATE TABLE observers (
    id integer PRIMARY KEY,
    name text
);
~~~
{:.text-document title="SQL Worksheet"}

[Return](#exercise-2)
{:.notes}

===

### Solution 3

~~~
SELECT year, month, day, species_id, ROUND(weight * 1000) AS weight_mg
FROM species;
~~~
{:.text-document title="SQL Worksheet"}

[Return](#exercise-3)
{:.notes}

===

### Solution 4

| First Table | Second Table        |
| plots(id)   | animals(plot_id)    |
| species(id) | animals(species_id) |

[Return](#exercise-4)
{:.notes}

===

### Solution 5

~~~
CREATE TABLE captures (
  observer_id integer REFERENCES observers(id),
  animal_id integer REFERENCES animals(id)
);
~~~
{:.text-document title="SQL Worksheet"}

[Return](#exercise-5)
{:.notes}

===
