---
---

## When untidy data okay

Record, store, and read data in the most normalized form possible.
Only untidy your tables as needed for particular analyses.
The most common operation for untidying is to "join" tables. For example, to carry out a regression with formula:

"weight ~ month + plot_type"

you'll need a table with rows for each "record_id" that also includes a "plot_type", which can be inferred from the "plot_id".
There are two kinds of table relationships -- uses of primary and foreign key references -- that permit database joins.

===

### One-To-Many Relationship

![]({{ site.baseurl }}/images/many-to-one.svg){: width="80%"}

===

The SQL keyword "join" lines up two tables, repeating records as necessary, to satisfy the constrain given after "on".


~~~r
df <- dbGetQuery(con, "select weight, month, plot_type
                       from surveys
                       join plots on surveys.plot_id = plots.plot_id
                       where weight is not null")
str(df)
~~~
{:.text-document title="lesson-3.R"}
~~~
'data.frame':	32283 obs. of  3 variables:
 $ weight   : int  40 48 29 46 36 52 8 22 35 7 ...
 $ month    : int  8 8 8 8 8 8 8 8 8 8 ...
 $ plot_type: chr  "Long-term Krat Exclosure" "Rodent Exclosure" "Control" "Control" ...
~~~
{:.output}

===

### Many-To-Many Relationship

![]({{ site.baseurl }}/images/many-to-many-2.svg){: width="80%"}

## Exercise 2

Construct a data frame that you could use to fit the regression model "weight ~ month + plot_type + taxa".
