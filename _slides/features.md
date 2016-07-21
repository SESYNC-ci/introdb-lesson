---
---

## Characteristics of a Database I

Let's begin with defining some terminology that is familiar from any system for data storage.
For concreteness, we will use the case study just introduced to provide examples.

Field
: The smallest unit of information, each having a label and holding a value of the same type.
: e.g. The time of the survey in which a small mammal was captured.

Record
: A collection of related values, from different fields, that all describe the same entity.
: e.g. The species, sex, size and location of a small mammal observed during a given survey.
  
Table
: A collection of records, each one uniquely identified by the value of one or more fields.
: e.g. All records of small mammals that were observed in any survey.

Stopping here, we may as well be describing a spreadsheet that can be curated in a data file (e.g. a CSV file) and read by almost every program for data applications.

<!--split-->

### Limitations of Data Files

Collaboration
: {:.fragment} Emailing copies among collaborators. Anybody see a problem here?

Size
: {:.fragment} Reading an entire data file into memory isn't scaleable. Some file types (e.g. MS Excel files) have size limits.

Quality
: {:.fragment} Enforcing restrictions on values is not the default behaviour of software that writes data files.

Extensions
: {:.fragment} Specialized files are needed for non-traditional data types (e.g. ESRI Shapefiles).

API
: {:.fragment} Binary or ASCII string manipulation? Yikes.

<!--split-->

### Database Solutions

Collaboration
: {:.fragment} A database accepts simultaneous users, which is most beneficial when the database is hosted on a network. There are never multiple copies of the data (aside from your backups!)

Size
: {:.fragment} The database management system only reads requested parts of the data into memory. There is no size limit!

Quality
: {:.fragment} Data types are enforced by default. No database lets you enter "9I1" in an integer field.

Extension
: {:.fragment} Special packages are needed for non-traditional data types, but they can live in the same table as traditional ones.

API
: {:.fragment} There are packages native to every programming language that ease reading and writing to databases.

