/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE EXTRACT (YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* UPDATE the species column to unspecified*/
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* transactions */
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/* DELETE all records*/
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* DELETE, CREATE a SAVEPOINT, UPDATE */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepointone;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO savepointone;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* Questions */
/*How many animals are there?*/
SELECT COUNT(*) FROM animals;
/*How many animals have never tried to escape?*/
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
/*What is the average weight of animals?
*/
SELECT AVG(weight_kg) FROM animals;
/*Who escapes the most, neutered or not neutered animals?*/
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;
/*What is the minimum and maximum weight of each type of animal?*/
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

/*Write queries (using JOIN) to answer questions*/
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) AS count FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(*) AS count FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC;

/* Queries for join tables */
SELECT a.name AS last_animal_seen FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'William Tatcher' ORDER BY v.date_of_visit DESC LIMIT 1;

SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id = species.id  JOIN visits ON visits.animal_id=animals.id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez';

SELECT v.name AS vet_name, s.name AS specialty_name FROM vets v LEFT JOIN specializations sp ON v.id = sp.vet_id LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name AS animal_name FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Stephanie Mendez' AND v.date_of_visit >= '2020-04-01' AND v.date_of_visit <= '2020-08-30';

SELECT a.name AS animal_name, COUNT(*) AS visit_count FROM visits v JOIN animals a ON v.animal_id = a.id GROUP BY v.animal_id, a.name ORDER BY visit_count DESC LIMIT 1;

SELECT a.name AS first_visit_animal FROM visits v JOIN animals a ON v.animal_id = a.id JOIN vets vt ON v.vet_id = vt.id WHERE vt.name = 'Maisy Smith' ORDER BY v.date_of_visit LIMIT 1;

SELECT  animals.name, visits.date_of_visit AS First_Visit FROM animals JOIN visits ON animals.id=visits.animal_id JOIN vets ON vets.id=visits.vet_id WHERE vets.name='Maisy Smith' ORDER BY First_Visit LIMIT 1;

SELECT animals.name AS pet_name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, species.name AS species, owners.full_name AS Owner, visits.date_of_visit, vets.name AS vet_name, vets.age, vets.date_of_graduation FROM animals  JOIN visits ON visits.animal_id=animals.id JOIN owners ON animals.owner_id=owners.id JOIN species ON animals.species_id=species.id JOIN vets ON vets.id=visits.vet_id ORDER BY visits.date_of_visit DESC LIMIT 1;

SELECT vets.name, species.name FROM vets JOIN visits ON vets.id=visits.vet_id LEFT JOIN specializations ON specializations.vet_id=vets.id LEFT JOIN species ON species.id=specializations.species_id WHERE specializations.vet_id IS NULL GROUP BY vets.name, species.name ORDER BY vets.name;

SELECT species.name AS "species", COUNT(animals.species_id) FROM vets JOIN visits ON visits.vet_id=vets.id JOIN animals ON animals.id = visits.animal_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count DESC LIMIT 1;
