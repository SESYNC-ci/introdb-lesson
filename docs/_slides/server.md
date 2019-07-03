---
---

## The Database Server

A relational database management system (RDBMS) that resides on a server is
ideal for collaborative, data-driven projects. Working with such a database
requires communication over a network using the client/server model, which
necessitates some way of finding the database server (it's address) and some
form of authentication (a username and password).
{:.notes}

The client must know the following information to initate communication with the
database server:

- **Hostname** - name or ip address of the database server
- **Port**     - typically the default (thus safe to ignore)
- **Database** - name of one database hosted by that server
- **Username** - a user authorized by the server to access the given database
- **Password** - password for the given username

We are going to look at the Portal mammals data on a server running PostgreSQL,
which is an open-source database management system. The client we will use to
communicate with the server is the RStudio IDE for R scripting, which is just
one of very many applications that are clients for a PostgreSQL server.
{:.notes}

===

For convenience and security when accessing a PostgreSQL server, some of the
information should be stored in a [password file].

~~~
hostname:port:database:username:password
~~~
{:.text-document .no-eval title="~/.pgpass"}

[password file]: https://www.postgresql.org/docs/current/static/libpq-pgpass.html

===

## Connections

The first step from the RStudio client is creating a connection object that
verifies the given information by opening up a channel to the database
server.



~~~r
library(DBI)
con <- dbConnect(RPostgres::Postgres(),
  host = ...,
  dbname = ...,
  user = ...)
~~~
{:.text-document .no-eval title="{{ site.data.lesson.handouts[0] }}"}



===

With the connection object availble, you can begin exploring the database.



~~~r
> dbListTables(con)
~~~
{:.input title="Console"}


~~~
[1] "plots"   "animals" "species"
~~~
{:.output}


===



~~~r
> dbListFields(con, 'species')
~~~
{:.input title="Console"}


~~~
[1] "id"      "genus"   "species" "taxa"   
~~~
{:.output}


===

Read an entire database table into an R data frame with `dbReadTable`, or if you
prefer "tidyverse" functions, use the [dplyr](){:.rlib} `tbl` function.



~~~r
library(dplyr)
species <- tbl(con, 'species')
~~~
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}



~~~r
> species
~~~
{:.input title="Console"}


~~~
# Source:   table<species> [?? x 4]
# Database: postgres [student@docker01.research.sesync.org:5432/portal]
   id    genus            species         taxa   
   <chr> <chr>            <chr>           <chr>  
 1 AB    Amphispiza       bilineata       Bird   
 2 AH    Ammospermophilus harrisi         Rodent 
 3 AS    Ammodramus       savannarum      Bird   
 4 BA    Baiomys          taylori         Rodent 
 5 CB    Campylorhynchus  brunneicapillus Bird   
 6 CM    Calamospiza      melanocorys     Bird   
 7 CQ    Callipepla       squamata        Bird   
 8 CS    Crotalus         scutalatus      Reptile
 9 CT    Cnemidophorus    tigris          Reptile
10 CU    Cnemidophorus    uniparens       Reptile
# ... with more rows
~~~
{:.output}


===

The `dbWriteTable` function provides a mechanism for uploading data, as long as
the user specified in the connection object has permission to create tables.



~~~r
df <- data.frame(
  id = c(1, 2),
  name = c('Alice', 'Bob')
)
dbWriteTable(con, 'observers', df,
             append = TRUE)
~~~
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}


===



~~~r
> tbl(con, 'observers')
~~~
{:.input title="Console"}


~~~
# Source:   table<observers> [?? x 2]
# Database: postgres [student@docker01.research.sesync.org:5432/portal]
     id name 
  <dbl> <chr>
1     1 Alice
2     2 Bob  
~~~
{:.output}

