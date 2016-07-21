---
---

## Communicating with a Database

A database management system that resides on a network is ideal for collaborative, data-driven projects.
Communication is therefore designed for networks: it involves a server application and a client application.
We are going to look at the Portal Mammals data on a server running PostgreSQL, which is an open-source database management system.
The client we will use to communicate with the server is a browser-based application called PostgreSQL Studio, which is just one of very many clients that connects to a PostgreSQL database.

![]({{ site.baseurl }}/images/pgstudio-login.png){: width="30%"}

Point a browser to `pgstudio.research.sesync.org` and login.

<!--split-->

Exercise
: Examine the primary and foreign keys on the three tables. What columns make up the primary keys for each table? Are there many-to-one relationships? Are there many-to-many relationships?
^
Hint #1
: The "Columns" tab has a field labeled "PK".

Hint #2
: The "Constraints" tab shows different types of constraints that govern a table.
{:.fragment}

<!--split-->

Reviews came back from the manuscript you submitted to Nature on the portal mammals project.
The always humble reviewer #2 suspects bias introduced by the surveyor and recommends controling for the identity of the observer that conducted each survey.

The "Script" tab tells us about an existing table by showing a command that would create an empty table with the same fields.
{:.fragment data-fragment-index="1"}

~~~
CREATE TABLE public.plots {
    plot_id integer NOT NULL PRIMARY KEY,
    plot_type text
}
~~~
{: .fragment data-fragment-index="1" .text-document title="plots"}

<!--split-->

Select the ![]({{ site.baseurl }}/images/sql-button.png) button and run the following script.

~~~
CREATE TABLE surveyor (
    person_id integer PRIMARY KEY,
    first_name text,
    last_name text
)
~~~
{:.input}

All of you? Yes, go ahead and *try it*.

<!--split-->

The table exists, now we need to populate it with data.
In the last step, you used Structured Query Language (SQL) to communicate with the database.
In this step, you will use SQL to add yourself as a surveyor.

~~~
INSERT INTO surveyor (person_id, first_name, last_name)
VALUES (%your_id%, %your_first name%, %your_last_name%);
~~~
{:.input}

<!--split-->

To fix the problem everyone just encountered, unless you happened to pick an unused `person_id`, let's define a smarter `person_id`.

Before we can re-create the surveyor table, we have to drop the existing table.
A `CREATE TABLE` statement would never overwrite existing data.

~~~
DROP TABLE surveyor CASCADE;
~~~
{:.input}

Question
: What event cascaded through to another table?
{:.fragment}

<!--split-->

Previously we used `integer` as the data type.
This time we are going to use `serial`, a sort of simple extension to the integer data type.
A `serial` value is an integer sequence that populates a record automatically.

~~~
CREATE TABLE surveyor (
    person_id serial PRIMARY KEY,
    first_name text,
    last_name text
)
~~~
{:.input .fragment}

~~~
INSERT INTO surveyor (first_name, last_name)
VALUES (%your_first name%, %your_last_name%);
~~~
{:.input .fragment}

~~~
ALTER TABLE surveys
  ADD FOREIGN KEY(surveyor) REFERENCES surveyor(surveyor_id);
~~~
{:.input .fragment}

Do you have to SHOUT all the time? No, but it helps distinguish keywords from variables.
{:.fragment}

<!--split-->

Exercise
: How would the solution be different if there were multiple surveyors for each survey? Pseudocode a couple database commands that would accomodate multiple surveyors.
