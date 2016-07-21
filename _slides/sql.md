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
CREATE TABLE public.plots (
    plot_id integer NOT NULL PRIMARY KEY,
    plot_type text
)
~~~
{: .fragment data-fragment-index="1" .text-document title="plots"}

<!--split-->

Select the ![]({{ site.baseurl }}/images/sql-button.png) button and run the following script.

~~~
CREATE TABLE surveyor (
    person_id integer PRIMARY KEY,
    first_name text,
    last_name text
);
~~~
{:.input}

All of you? Yes, go ahead and *try it*.

<!--split-->

The table exists, now we need to populate it with data.
In the previous step, you used Structured Query Language (SQL) to communicate with the database.
In this step, you will use SQL to add yourself as a surveyor.

~~~
INSERT INTO surveyor (person_id, first_name, last_name)
    VALUES (%your_id%, %your_first name%, %your_last_name%);
~~~
{:.input}

Question
: Did anyone get an error? Ideas on what our problem is?
{: .fragment}

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

<!--split-->

Finally we create the relationship between `surveys` and `surveyors` by adding a Foreign Key to `surveys`.

~~~
ALTER TABLE surveys
    ADD FOREIGN KEY(person_id) REFERENCES surveyor(person_id);
~~~
{:.input .fragment}

<!--split-->

Now, choose a `record_id` you will use as `%record_id%` in the next command.
This is a survey on which you claim to be the surveyor -- let's update the data to reflect your work!

~~~
UPDATE surveys SET person_id = %your_person_id% WHERE record_id = %record_id%;
~~~
{:.input .fragment}

<!--split-->

To view the result of your update, and everyone elses, run the following query on the database.
Two new SQL commands come into play here: `SELECT ... FROM` and `JOIN`.

~~~
SELECT record_id, surveyor.*
FROM surveys JOIN surveyor USING(person_id);
~~~
{:.input}

<!--split-->

Exercise
: How would the solution be different if there were multiple surveyors for each survey? Pseudocode a couple database commands that would create tables to address the situation with multiple surveyors for each survey.
