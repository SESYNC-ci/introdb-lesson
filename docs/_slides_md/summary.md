---
---

## Summary

- **concurrency**
- **reliability**
- **scaleability**

===

Databases are a core element of a centralized workflow that requires
simultaneous use by multiple members of a collaborative team. We have just
skimmed the topic of **concurrency** in database interactions: there is a lot
going on under the hood to prevent data corruption.

===

The ability to precisely define keys and data types is the primary database
feature that guaranties **reliability**. As you develop scripts for analysis and
vizualization, certainty that you'll never encounter a "NaN" when you expect an
Integer will prevent, or help you catch, bugs in your code.

===

The third major feature to motivate databae use, **scaleability**, remains for
you to discover, using the tools from this lesson. Very large tables can be
queried, sorted and combined quickly when the work is done by a powerful
relational database management system (RDBMS), such as PostgreSQL.
