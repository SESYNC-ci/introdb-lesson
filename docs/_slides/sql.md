---
---

## Communicating with a Database

A database management system that resides on a network is ideal for collaborative, data-driven projects.
Communication is therefore designed for networks: it involves a server application and a client application.

We are going to look at the Portal Mammals data on a server running PostgreSQL, which is an open-source database management system.
The client we will use to communicate with the server is a browser-based application called PostgreSQL Studio, which is just one of very many clients that connects to a PostgreSQL database.

===

Point a browser to `pgstudio.research.sesync.org` and login.

![]({{ site.baseurl }}/images/pgstudio-login.png){: width="30%"}

===

Exercise
: Examine the primary and foreign keys on the three tables. What columns make up the primary keys for each table? Are there many-to-one relationships? Are there many-to-many relationships?
^
Hint #1
: The "Columns" tab has a field labeled "PK".

Hint #2
: The "Constraints" tab shows different types of constraints that govern a table.
{:.fragment}

===

Reviews came back from the manuscript you submitted to Nature on the portal mammals project.
The always humble Reviewer #2 suspects bias introduced by the surveyor and recommends controling for the identity of the observer that conducted each survey.

The "Script" tab tells us about an existing table by showing a command that would create an empty table with the same fields.
{:.fragment data-fragment-index="1"}

~~~
CREATE TABLE public.plots (
    plot_id integer NOT NULL PRIMARY KEY,
    plot_type text
)
~~~
{: .fragment data-fragment-index="1" .text-document title="plots"}

The command is written in **Structured Query Language (SQL)**, which is a language all database management systems support for database communication.
In the next steps, you will use SQL to alter the portal database in response to the Reviewer.
{:.fragment data-fragment-index="2"}

===

Select the ![]({{ site.baseurl }}/images/sql-button.png) button and run the following two scripts.
The first script creates a new table, the second script adds a relationship to the `surveys` table.

~~~
CREATE TABLE surveyor (
    person_id serial PRIMARY KEY,
    first_name text,
    last_name text
);
~~~
{:.input}

~~~
ALTER TABLE surveys
    ADD COLUMN person_id integer REFERENCES surveyor(person_id);
~~~
{:.input}

All of you? Yes, go ahead and *try it*.

===

In the `plots` table we see `integer` as the data type of the primary key.
We used `serial`, a simple extension to the integer data type.
A `serial` value is an integer sequence that populates a record automatically.

~~~
INSERT INTO surveyor (first_name, last_name)
    VALUES ('%your_first_name%', '%your_last_name%');
~~~
{:.input .fragment}

Question
: What's your person_id?
{.fragment}

===

The foreign key on `surveys.person_id` exists, now we need to populate the column with data.
Choose a `record_id` you will use as `%record_id%` in the next command.
This is a survey on which you claim to be the surveyor -- let's update the data to reflect your work!

~~~
UPDATE surveys SET person_id = "%your_person_id%"
WHERE record_id = "%record_id%";
~~~
{:.input .fragment}

===

To view the result of your update, and everyone elses, run the following query on the database.
Two new SQL phrases come into play here: `SELECT ... FROM` and `JOIN`.

~~~
SELECT record_id, surveyor.* FROM surveys
JOIN surveyor USING(person_id);
~~~
{:.input}

===

Exercise
: How would the solution be different if there were multiple surveyors for each survey? Pseudocode a couple database commands that would create tables to address the situation with multiple surveyors for each survey.
