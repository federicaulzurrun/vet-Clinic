/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23),
  (2, 'Gabumon', '2018-11-15', 2, TRUE, 8),
  (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04),
  (4, 'Devimon', '2017-05-12', 5, TRUE, 11);

/* Insert more animal to the database */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES
  (5, 'Charmander', '2020-02-08', 0, FALSE, -11, NULL),
  (6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7, NULL),
  (7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13, NULL),
  (8, 'Angemon', '2005-06-12', 1, TRUE, -45, NULL),
  (9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4, NULL),
  (10, 'Blossom', '1998-10-13', 3, TRUE, 17, NULL),
  (11, 'Ditto', '2022-05-14', 4, TRUE, 22, NULL);

/* Insert Owners */
INSERT INTO owners (full_name, age) VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

/* Update animals' species_id and owner_id based on their names */
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon'), owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

/* Populate vets table */

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
        ('Maisy Smith', 26, '2019-01-17'),
        ('Stephanie Mendez', 64, '1981-05-04'),
        ('Jack Harkness', 38, '2008-06-08');


/* Populate specializations table */

INSERT INTO specializations(vet_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM species WHERE name='Pokemon')),
((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Digimon')),
((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Pokemon')),
((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM species WHERE name='Digimon'));

/* Populate visits table */
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name ='William Tatcher'), '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name ='Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24');
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';


/* Decreasing execution times */

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id=4;

EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
