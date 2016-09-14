---
---

## Data Types

A key tactic in data quality control is precise (and enforceable!) definitions of the values allowed for each field.
We just saw `integer`, `text` and the slightly more complicated `serial`.

Some of the essential data types, specifically for a PostgreSQL database.
{:.fragment data-fragment-index="1"}

| Type      | Description                                                                                             |
|-----------+---------------------------------------------------------------------------------------------------------|
| integer   | whole numbers between -2,147,483,648 and 2,147,483,647                                                  |
| double    | Inexact, variable-precision numeric value that can represent almost any number, and several non-numbers |
| decimal   | Exact numeric value with user-specified precision (decimal places)                                      |
| char      | Fixed-length character string                                                                           |
| varchar   | Variable-length (up to a limit) character string                                                        |
| boolean   | True or False                                                                                           |
| date      | day with no time specification                                                                          |
{:.fragment data-fragment-index="1"}

<!--split-->

### Data Granularity

The degree to which information is broken up into diferent fields is called **granularity**, and it's an important consideration in database design.
On one hand, because it is easier to aggregate fields than disaggregate them down the road, initially erring on the side of too granular is best.
On the other hand, some consideration of how each field will get used can lead to less granularity.

Question
: In the surveys table, the date is broken into three integer fields. What are some advantages and disadvantages of such fine granularity over using a single field of type date?

Answer
: {:.fragment} Advantages include easy selection by month, day or year. Disadvantages include difficulty of selecting by date range.
