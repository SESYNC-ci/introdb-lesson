---
---

## What good is a database?

For a team of researchers implementing a collaborative workflow, the top three reasons to use a database are:

1. **concurrency** - Multiple users can safely read and edit database entries simultaneously.
1. **reliability** - Relational databases formalize and can enforce concepts of "tidy" data.
1. **scalability** - Very large tables can be read, searched, and merged
quickly.

In this lesson, the term "database" more precisely means a relational database
that allows data manipulation with Structured Query Language (SQL). Strictly
speaking, the word "database" describes any collection of digitized data--a
distinction that has mostly outlived its usefulness.
{:.notes}

**This lesson also assumes you have access to a database server populated with data by
the lesson instructor.** Check back here for forthcoming instructions to get setup with Docker.
{:.notes}

===

## Objectives

- Understand how a database differs from a data file
- Introduce the PostgreSQL database system
- Meet Structured Query Language (SQL)
- Recognize the value of typed data
<!-- - Glimpse spatial extensions in action -->

===
	
## Specific Achievements

- Access a database from RStudio
- Create a table and view table definitions
- Insert records one at a time into a table
- Check primary and foreign key constraints
<!-- - Alter the definition of an existing table -->

<!--
## Specific Achievements

- Access a SQLite database from R
- Select data to read into data frame
- Test primary and foreign key constraints
-->
