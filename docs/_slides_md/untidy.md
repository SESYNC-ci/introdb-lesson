---
---


## Normalized data is Tidy data

Proper use of table relationships is a challenging part of database design.
The objective is **normalization**, or taking steps to minimize data redundency.

For example, the genus and species names are not associated with every survey record -- only with the species_id.
Data about the species is a different "observational unit" than data about the individual caught in a survey.
{:.fragment}

With an ideal database design, any value discovered to be erroneous should only have to be corrected in one record in one table.
{:.fragment}

===

Question
: Currently, `plots` is pretty sparse. What other kind of data might go into plots?

Answer
: {:.framgnet} Additional properties, such as location, that do not change over time.




Exercise
: Examine the primary and foreign keys on the three tables. What columns make up the primary keys for each table? 



Are there many-to-one relationships? Are there many-to-many relationships?
^
Hint #1
: The "Columns" tab has a field labeled "PK".

Hint #2
: The "Constraints" tab shows different types of constraints that govern a table.
{:.fragment}

===
