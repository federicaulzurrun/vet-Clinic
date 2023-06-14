/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL NOT NULL
);

/* added new column */
ALTER TABLE animals
ADD COLUMN species VARCHAR(255);

/* added owners and species tables */
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);

/* Insert species */
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);