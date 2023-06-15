/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN aNOT NULL,
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

/* Modified animals table */
ALTER TABLE animals
  ADD COLUMN species_id INTEGER REFERENCES species(id),
  ADD COLUMN owner_id INTEGER REFERENCES owners(id),
  DROP COLUMN species;

/* Added vets table */
CREATE TABLE vets (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    age INT,
    date_of_graduation DATE
);

/* Added specializations table*/
CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    CONSTRAINT fk_vets
      FOREIGN KEY (vet_id) REFERENCES vets(id)
      ON DELETE CASCADE,
    CONSTRAINT fk_species
      FOREIGN KEY (species_id) REFERENCES species(id)
      ON DELETE CASCADE
);

/* Added visits table*/
CREATE TABLE visits (
    id INT PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY,
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_vets
      FOREIGN KEY (vet_id) REFERENCES vets(id)
      ON DELETE CASCADE,
    CONSTRAINT fk_animals
      FOREIGN KEY (animal_id) REFERENCES animals(id)
      ON DELETE CASCADE
);