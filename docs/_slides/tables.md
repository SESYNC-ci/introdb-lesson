---
---

## Characteristics of a Database: Part I

Most database terminology is the same as that used for characterizing data files.
The examples below refer to the Portal mammals database.

Field
: The smallest unit of information, each having a label and holding a value of the same type.
: e.g. The day on which a plot was surveyed.

Record
: A collection of related values, from different fields, that all describe the same entity.
: e.g. The species, sex, weight and size of a small mammal captured during a survey.
  
Table
: A collection of records, each one uniquely identified by the value of a key field.
: e.g. All records for small mammals observed during any survey.

These characteristics could equally be applied to a spreadsheet, one that can be curated in a text file (e.g. a CSV file) as well as specialized formats (e.g. a MS Excel file).
{:.notes}

===

## Limitations of Data Files

Collaboration
: {:.fragment} Email copies among collaborators, store in the cloud (sync issues) or share on a network (user collision).

Size
: {:.fragment} Reading an entire data file into memory isn't scaleable. Some file types (e.g. MS Excel files) have size limits.

Quality
: {:.fragment} Enforcing restrictions on values is not the default behaviour of software that writes data files.

Extensions
: {:.fragment} Specialized files are needed for non-traditional data types (e.g. ESRI Shapefiles).

API
: {:.fragment} No standard approach for different application to read, edit or create records.

===

## Database Solutions

Collaboration
: {:.fragment} A database accepts simultaneous users, which is most beneficial when the database is hosted on a server. There are never multiple copies of the data (aside from backups!)

Size
: {:.fragment} The database management system only reads requested parts of the data into memory. There are no size limits.

Quality
: {:.fragment} Data types are enforced by default. No database lets you "accidentally" enter letters (e.g. "N.A.") in a field for integers.

Extension
: {:.fragment} Special packages are needed for non-traditional data types, but they can live in the same table as traditional ones.

API
: {:.fragment} There are packages native to every programming language that ease reading and writing to databases.

===

## The Database Server

A relational database management system (RDBMS) that resides on a server is ideal for collaborative, data-driven projects.
Communication is therefore accross a network: it involves a server application and a client application.

We are going to look at the Portal mammals data on a server running PostgreSQL, which is an open-source database management system.
The client we will use to communicate with the server is a browser-based application called PostgreSQL Studio, which is just one of very many clients that connects to a PostgreSQL database.

===

Open PostgreSQL Studio and login with the connection parameters:

![]({{ site.baseurl }}/images/pgstudio-login-1.png){:width="40%"}
{:.captioned}

A more typical database host would be a URL or IP address. Using "localhost" is unusual in that the server is not typically on the same system as the client.
{:.notes}

===

The "Data" tab provides a quick preview of some records. The "Columns" and "Scripts" tabs provide detailed information on how data types are set on the different fields.

Columns
: Most are integer or text data, and "nullable" fields allow missing data (regardless of data type).

Scripts
: The Structured Query Language (SQL) statement that defines each table.

===

## Exercise 1

Study the "Columns" and "Script" tabs for the species table. Pick a field that is currently allowed to be null, and guess how to re-write the script beginning with `CREATE TABLE` to prohibit null values in the database.
