-- Exercise 2

CREATE TABLE [%schema%.]%table% (
  %column_name% %data_type% [%option% ...],
    ...
);

-- Insert

... observers
VALUES ...;

... plots (...)
... (1, 'Control');

-- Foreign key

INSERT INTO ...
... (35550, 789);

-- Basic queries

SELECT ...;

SELECT ...
... animals;

...
FROM ...;

-- Limit

... year, species_id
FROM animals
...;

-- Unique

... species_id
FROM animals;

SELECT ...
FROM animals;

-- Calculated values

... year, month, day, ...
FROM animals;

... plot_id, species_id, sex, weight, ...(weight / 1000.0, ...)
FROM animals;

SELECT plot_id, species_id, sex, weight, ROUND(weight / 1000.0, 2) ...
FROM animals;

-- Exercise 3

...

-- Filtering

SELECT *
FROM animals
...;

SELECT *
FROM animals
...;

SELECT *
FROM animals
WHERE year >= 2000 ...;

SELECT *
FROM animals
WHERE ... AND species_id = 'DM';

-- One-to-many

SELECT ...
FROM animals
... animals.plot_id = plots.id;

-- Many-to-many

SELECT ...
FROM animals
JOIN plots ON animals.plot_id = plots.id
...;

-- Exercise 5

...

