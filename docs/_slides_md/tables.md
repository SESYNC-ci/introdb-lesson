---
---

## Database Characteristics: I

Database terminology builds on common ways of characterizing data files. The 
breakdown of a table into records (by row) or fields (by column) is familiar
to anyone who's worked in spreadsheets. The descriptions below formalize these terms, and provide an example referencing the Portal mammals database.
{:.notes}

| **Field** |The smallest unit of information, each having a label and holding a value of the same type.<br>*e.g. The day on which a plot was surveyed.*|
| **Record** | A collection of related values, from different fields, that all describe the same entity.<br>*e.g. The species, sex, weight and size of a small mammal captured during a survey.*|
| **Table** | A collection of records, each one uniquely identified by the value of a key field.<br>*e.g. All records for small mammals observed during any survey.* |

===

Software for using a database provides different tools for working with tables than a spreadsheet program. A database is generally characterized as being tooled for
production environments, in contrast to data files tooled for ease of use.
{:.notes}

**Collaboration**
- {:.fragment} Data files are stored in the cloud (sync issues), shared on a network (user collision), or copies are emailed among collaborators.
- {:.fragment} A database accepts simultaneous users from different clients on a network. There are never multiple copies of the data (aside from backups!).

===

**Size**
- {:.fragment} Reading an entire data file into memory isn't scaleable. Some file types (e.g. MS Excel files) have size limits.
- {:.fragment} Database software only reads requested parts of the data into memory. There are no size limits.

===

**Quality**
- {:.fragment} Data file formats do not typically provide any quality controls.
- {:.fragment} Databases stricly enforce data types on each field. Letters, for example "N.A.", cannot be entered into a field for integers.

===

**Extension**
- {:.fragment} Specialized files are needed for complicated data types (e.g. ESRI Shapefiles).
- {:.fragment} Databases provide many non-standard data types, and very specialized ones (e.g. geometries) are available through extension packages.

===

**Programming**
- {:.fragment} There is no standard way to read, edit or create records in data files of different formats or from different languages.
- {:.fragment} Packages native to all popular programming languages provide access
to databases using SQL.
