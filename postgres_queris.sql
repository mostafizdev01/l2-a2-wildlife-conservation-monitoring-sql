-- Active: 1747405674511@@127.0.0.1@5432@conservation_db@public
CREATE DATABASE conservation_db;

CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT
)

-- insert data on rangers table
INSERT INTO
    rangers (name, region)
VALUES ('Alice Morgan', 'North Zone'),
    ('Brian Singh', 'East Zone'),
    ('Carlos Nunez', 'West Zone'),
    ('Diana Patel', 'South Zone'),
    ('Ethan Zhao', 'Central Zone');

--- Creating species table
CREATE Table species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE,
    conservation_status TEXT
);

-- insert data on species table
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Shadow Leopard',
        'Panthera nebulosa',
        '1997-06-15',
        'Endangered'
    ),
    (
        'Forest Elephant',
        'Loxodonta cyclotis',
        '1983-04-10',
        'Vulnerable'
    ),
    (
        'Spotted Deer',
        'Axis axis',
        '1970-11-23',
        'Least Concern'
    ),
    (
        'Marsh Crocodile',
        'Crocodylus palustris',
        '1965-02-05',
        'Vulnerable'
    ),
    (
        'Golden Langur',
        'Trachypithecus geei',
        '1990-08-12',
        'Endangered'
    );

--- Creating sightings table
CREATE Table sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT,
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    species_id INT,
    FOREIGN KEY (species_id) REFERENCES species (species_id),
    sighting_time DATE,
    location TEXT NOT NULL,
    notes text
);

-- insert data on sightings table
INSERT INTO
    sightings (
        ranger_id,
        species_id,
        sighting_time,
        location,
        notes
    )
VALUES (
        1,
        1,
        '2025-05-20',
        'North Zone - Cliffside',
        'Shadow Leopard spotted near cave entrance.'
    ),
    (
        2,
        2,
        '2025-05-21',
        'East Zone - Watering Hole',
        'Forest Elephant seen drinking water.'
    ),
    (
        3,
        3,
        '2025-05-22',
        'West Zone - Grasslands',
        'Spotted Deer grazing in herds.'
    ),
    (
        4,
        4,
        '2025-05-23',
        'South Zone - Swamp Edge',
        'Marsh Crocodile sunbathing near the shore.'
    ),
    (
        5,
        5,
        '2025-05-24',
        'Central Zone - Canopy Trail',
        'Golden Langur swinging between trees.'
    ),
    (
        1,
        3,
        '2025-05-25',
        'North Zone - Meadow',
        'Spotted Deer were calm and not afraid.'
    ),
    (
        2,
        5,
        '2025-05-25',
        'East Zone - Tall Trees',
        'Golden Langur observed eating leaves.'
    );

----PostgreSQL Wildlife Conservation Monitoring Problems Solutions...

-- Problem no 01:-
INSERT into
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem no 02:-
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;

-- Problem no 03:-
SELECT * FROM sightings WHERE location ILIKE '%pass%'

-- Problem no 04:-
SELECT rangers.name, COUNT(sightings.sighting_id) AS total_sightings
FROM rangers
    LEFT JOIN sightings ON rangers.ranger_id = sightings.sighting_id
GROUP BY
    rangers.name
ORDER BY total_sightings;

-- Problem no 05:-
SELECT species.common_name, species.scientific_name
FROM species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE
    sightings.species_id IS NULL;

-- Problem no 06:-
SELECT sp.common_name, s.sighting_time, r.name
FROM
    sightings s
    JOIN species sp ON s.species_id = sp.species_id
    JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Problem no 07:-
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

-- Problem no 08:-
SELECT
    sighting_id,
    sighting_time,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'Morning'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) >= 12
        AND EXTRACT(
            HOUR
            FROM sighting_time
        ) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;


-- Problem no 09:-
DELETE FROM rangers
WHERE ranger_id NOT IN (
  SELECT DISTINCT ranger_id FROM sightings
);


SELECT * FROM rangers;

SELECT * FROM species;

SELECT * FROM sightings;