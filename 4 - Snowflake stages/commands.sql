-- Change to your DB:
USE DATABASE THIS_DB;

CREATE OR REPLACE SCHEMA SCARIF;

-- Create necessary tables
CREATE OR REPLACE TABLE characters (
    name STRING,
    height INT,
    mass FLOAT,
    hair_color STRING,
    skin_color STRING,
    eye_color STRING,
    birth_year STRING,
    sex STRING,
    gender STRING,
    homeworld STRING,
    species STRING
);

CREATE OR REPLACE TABLE films (
    film STRING,
    name STRING
);

CREATE OR REPLACE TABLE character_planets (
    name STRING,
    planet_id NUMBER,
    relation_type STRING,
    planet_name STRING,
    climate STRING,
    terrain STRING,
    population NUMBER,
    affiliation STRING
);

CREATE OR REPLACE TABLE starships (
    starship STRING,
    pilot STRING,
    first_film_appearance DATE
);

-- Create file format
CREATE OR REPLACE FILE FORMAT csv_format
TYPE = 'CSV'
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
SKIP_HEADER = 1;


-- Create an internal stage
CREATE OR REPLACE STAGE starwars_stage
FILE_FORMAT = csv_format;


-- Stage the CSV files
PUT 'file:///Users/davidwilson/Documents/GitHub/is566/is-566-00-in-class-activities/4 - Snowflake stages/SCARIF_DATA/films.csv' @starwars_stage;
PUT 'file:///Users/davidwilson/Documents/GitHub/is566/is-566-00-in-class-activities/4 - Snowflake stages/SCARIF_DATA/characters.csv' @starwars_stage;
PUT 'file:///Users/davidwilson/Documents/GitHub/is566/is-566-00-in-class-activities/4 - Snowflake stages/SCARIF_DATA/character_planets_1.csv' @starwars_stage/character_planets;
PUT 'file:///Users/davidwilson/Documents/GitHub/is566/is-566-00-in-class-activities/4 - Snowflake stages/SCARIF_DATA/character_planets_2.csv' @starwars_stage/character_planets;
PUT 'file:///Users/davidwilson/Documents/GitHub/is566/is-566-00-in-class-activities/4 - Snowflake stages/SCARIF_DATA/character_planets_3.csv' @starwars_stage/character_planets;
PUT 'file:///Users/davidwilson/Documents/GitHub/is566/is-566-00-in-class-activities/4 - Snowflake stages/SCARIF_DATA/2024-11-23-02-45-23_starships.csv' @starwars_stage/starships;
PUT 'file:///Users/davidwilson/Documents/GitHub/is566/is-566-00-in-class-activities/4 - Snowflake stages/SCARIF_DATA/2024-11-26-10-23-09_starships.csv' @starwars_stage/starships;

-- Admire our work:
LIST @starwars_stage;

-- Copy data from stage into tables
COPY INTO characters 
FROM @starwars_stage/characters.csv
-- validation_mode = 'RETURN_2_ROWS'  -- it's a good idea to use a validation to check first
;  
select * from characters;

COPY INTO films 
FROM @starwars_stage/films.csv
-- validation_mode = 'RETURN_2_ROWS'
;
select * from films limit 10;

COPY INTO character_planets 
FROM @starwars_stage/character_planets/
-- validation_mode = 'RETURN_2_ROWS'
;
select * from character_planets limit 10;

COPY INTO starships 
FROM @starwars_stage/starships/ 
validation_mode = 'RETURN_2_ROWS'
;

-- Uh oh! Starships has a weird export format. 
-- Let's make a new one just for those starship logs:
CREATE OR REPLACE FILE FORMAT tilde_format 
FIELD_DELIMITER = '~'
SKIP_HEADER = 4
DATE_FORMAT = 'DD-MM-YYYY'
;

COPY INTO starships 
FROM @starwars_stage/starships/ 
FILE_FORMAT = tilde_format
-- validation_mode = 'RETURN_2_ROWS'
;
select * from starships limit 10;

list @starwars_stage;
-- This is how we clear out stages after we're done, either by subfolder:
REMOVE @starwars_stage/starships;

-- Or, more aggressively, just clear the whole stage:
REMOVE @starwars_stage;
