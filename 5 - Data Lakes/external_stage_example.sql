USE database this_db;

use schema scarif;

-- Note that you likely won't have permission to create this in our account:
CREATE STORAGE INTEGRATION s3_storage_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::372879728811:role/is566_snowflake'
  STORAGE_ALLOWED_LOCATIONS = ('s3://is566byu/staging_demo/');

-- to see the commando worked
DESC INTEGRATION s3_storage_integration;

SHOW FILE FORMATS;


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

-- create the s3 stage
create or replace stage s3stage_starwars
  url = 's3://is566byu/staging_demo/'
  file_format = csv_format
  storage_integration = s3_storage_integration;


list @s3stage_starwars;


COPY INTO character_planets 
FROM @s3stage_starwars/
validation_mode = 'RETURN_2_ROWS'
;

