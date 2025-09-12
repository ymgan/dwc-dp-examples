-- Create the event table from the parentmost Event (project) first.
INSERT INTO event (
  event_id,
  parent_event_id,
  preferred_event_name,
  event_category,
  event_type,
  dataset_name,
  dataset_id,
  field_number,
  event_conducted_by,
  event_conducted_by_id,
  event_date,
  event_time,
  start_day_of_year,
  end_day_of_year,
  year,
  month,
  day,
  verbatim_event_date,
  verbatim_locality,
  verbatim_elevation,
  verbatim_depth,
  verbatim_coordinates,
  verbatim_latitude,
  verbatim_longitude,
  verbatim_coordinate_system,
  verbatim_srs,
  georeference_verification_status,
  habitat,
  event_effort,
  field_notes,
  event_references,
  event_remarks,
  location_id,
  higher_geography_id,
  higher_geography,
  continent,
  water_body,
  island_group,
  island,
  country,
  country_code,
  state_province,
  county,
  municipality,
  locality,
  minimum_elevation_in_meters,
  maximum_elevation_in_meters,
  vertical_datum,
  minimum_depth_in_meters,
  maximum_depth_in_meters,
  minimum_distance_above_surface_in_meters,
  maximum_distance_above_surface_in_meters,
  location_remarks,
  decimal_latitude,
  decimal_longitude,
  geodetic_datum,
  coordinate_uncertainty_in_meters,
  coordinate_precision,
  point_radius_spatial_fit,
  footprint_wkt,
  footprint_srs,
  footprint_spatial_fit,
  georeferenced_by,
  georeferenced_by_id,
  georeferenced_date,
  georeference_protocol_id,
  georeference_protocol,
  georeference_sources,
  georeference_remarks,
  information_withheld,
  data_generalizations,
  preferred_spatial_representation
)
SELECT 
  'NEON_fish' AS event_id, 
  NULL AS parent_event_id,
  NULL AS preferred_event_name,
  'Event' AS event_category,
  'Project' AS event_type, 
  'Fish electrofishing, gill netting, and fyke netting counts' AS dataset_name,
  'https://data.neonscience.org/data-products/DP1.20107.001' AS dataset_id,
  NULL AS field_number,
  'NEON (National Ecological Observatory Network)' AS event_conducted_by,
  NULL AS event_conducted_id,
  '2019-07-01/2024-09-26' AS event_date,
  NULL AS event_time,
  NULL AS start_day_of_year,
  NULL AS end_day_of_year,
  NULL AS year, 
  NULL AS month,
  NULL AS day,
  NULL AS verbatim_event_date,
  NULL AS verbatim_locality,
  NULL AS verbatim_elevation,
  NULL AS verbatim_depth,
  NULL AS verbatim_coordinates,
  NULL AS verbatim_latitude,
  NULL AS verbatim_longitude,
  NULL AS verbatim_coordinateSystem,
  NULL AS verbatim_srs,
  NULL AS georeference_verification_status,
  NULL AS habitat,
  NULL AS event_effort,
  NULL AS field_notes,
  'NEON (National Ecological Observatory Network). Fish electrofishing, gill netting, and fyke netting counts (DP1.20107.001), RELEASE-2025. https://doi.org/10.48443/ap3d-rp07. Dataset accessed from https://data.neonscience.org/data-products/DP1.20107.001/RELEASE-2025 on March 3, 2025.' AS event_references,
  NULL AS event_remarks,
  NULL AS location_id,
  NULL AS higher_geography_id,
  NULL AS higher_geography,
  'North America' AS continent,
  NULL AS water_body,
  NULL AS island_group,
  NULL AS island,
  'United States' AS country,
  'US' AS country_code,
  NULL AS state_province,
  NULL AS county,
  NULL AS municipality,
  NULL AS locality,
  NULL AS minimum_elevation_in_meters,
  NULL AS maximum_elevation_in_meters,
  NULL AS vertical_datum,
  NULL AS minimum_depth_in_meters,
  NULL AS maximum_depth_in_meters,
  NULL AS minimum_distance_above_surface_in_meters,
  NULL AS maximum_distance_above_surface_in_meters,
  NULL AS location_remarks,
  NULL AS decimal_latitude,
  NULL AS decimal_longitude,
  NULL AS geodetic_datum,
  NULL AS coordinate_uncertainty_in_meters,
  NULL AS coordinate_precision,
  NULL AS point_radius_spatial_fit,
  NULL AS footprint_wkt,
  NULL AS footprint_srs,
  NULL AS footprint_spatial_fit,
  NULL AS georeferenced_by,
  NULL AS georeferenced_by_id,
  NULL AS georeferenced_date,
  NULL AS georeference_protocol_id,
  NULL AS georeference_protocol,
  NULL AS georeference_sources,
  NULL AS georeference_remarks,
  NULL AS information_withheld,
  NULL AS data_generalizations,
  NULL AS preferred_spatial_representation;
-- n=1 rows added
-- n=1 rows total

-- Now add the child Site Event.
INSERT INTO event (
  event_id,
  parent_event_id,
  preferred_event_name,
  event_category,
  event_type,
  dataset_name,
  dataset_id,
  field_number,
  event_conducted_by,
  event_conducted_by_id,
  event_date,
  event_time,
  start_day_of_year,
  end_day_of_year,
  year,
  month,
  day,
  verbatim_event_date,
  verbatim_locality,
  verbatim_elevation,
  verbatim_depth,
  verbatim_coordinates,
  verbatim_latitude,
  verbatim_longitude,
  verbatim_coordinate_system,
  verbatim_srs,
  georeference_verification_status,
  habitat,
  event_effort,
  field_notes,
  event_references,
  event_remarks,
  location_id,
  higher_geography_id,
  higher_geography,
  continent,
  water_body,
  island_group,
  island,
  country,
  country_code,
  state_province,
  county,
  municipality,
  locality,
  minimum_elevation_in_meters,
  maximum_elevation_in_meters,
  vertical_datum,
  minimum_depth_in_meters,
  maximum_depth_in_meters,
  minimum_distance_above_surface_in_meters,
  maximum_distance_above_surface_in_meters,
  location_remarks,
  decimal_latitude,
  decimal_longitude,
  geodetic_datum,
  coordinate_uncertainty_in_meters,
  coordinate_precision,
  point_radius_spatial_fit,
  footprint_wkt,
  footprint_srs,
  footprint_spatial_fit,
  georeferenced_by,
  georeferenced_by_id,
  georeferenced_date,
  georeference_protocol_id,
  georeference_protocol,
  georeference_sources,
  georeference_remarks,
  information_withheld,
  data_generalizations,
  preferred_spatial_representation
)
SELECT 
  'BIGC' AS event_id, 
  'NEON_fish' AS parent_event_id,
  NULL AS preferred_event_name,
  'Survey' AS event_category, 
  'Site' AS event_type, 
  'Fish electrofishing, gill netting, and fyke netting counts' AS dataset_name,
  'https://data.neonscience.org/data-products/DP1.20107.001' AS dataset_id,
  NULL AS field_number,
  'NEON (National Ecological Observatory Network)' AS event_conducted_by,
  NULL AS event_conducted_id,
  '2019-04-22/2019-10-24' AS event_date,
  NULL AS event_time,
  NULL AS start_day_of_year,
  NULL AS end_day_of_year,
  2019 AS year, 
  NULL AS month,
  NULL AS day,
  NULL AS verbatim_event_date,
  NULL AS verbatim_locality,
  NULL AS verbatim_elevation,
  NULL AS verbatim_depth,
  NULL AS verbatim_coordinates,
  NULL AS verbatim_latitude,
  NULL AS verbatim_longitude,
  NULL AS verbatim_coordinateSystem,
  NULL AS verbatim_srs,
  NULL AS georeference_verification_status,
  'Aquatic Wadeable Stream' AS habitat,
  NULL AS event_effort,
  NULL AS field_notes,
  NULL AS event_references,
  NULL AS event_remarks,
  NULL AS location_id,
  NULL AS higher_geography_id,
  NULL AS higher_geography,
  'North America' AS continent,
  'Upper Big Creek' AS water_body,
  NULL AS island_group,
  NULL AS island,
  'United States' AS country,
  'US' AS country_code,
  'California' AS state_province,
  'Fresno' AS county,
  NULL AS municipality,
  'Pacific Southwest (D17), Upper Big Creek NEON (BIGC)' AS locality,
  1003 AS minimum_elevation_in_meters,
  1700 AS maximum_elevation_in_meters,
  NULL AS vertical_datum,
  NULL AS minimum_depth_in_meters,
  NULL AS maximum_depth_in_meters,
  NULL AS minimum_distance_above_surface_in_meters,
  NULL AS maximum_distance_above_surface_in_meters,
  NULL AS location_remarks,
  37.059719 AS decimal_latitude,
  -119.257549 AS decimal_longitude,
  'WGS84' AS geodetic_datum,
  1000 AS coordinate_uncertainty_in_meters,
  0.000001 AS coordinate_precision,
  NULL AS point_radius_spatial_fit,
  NULL AS footprint_wkt,
  NULL AS footprint_srs,
  NULL AS footprint_spatial_fit,
  NULL AS georeferenced_by,
  NULL AS georeferenced_by_id,
  NULL AS georeferenced_date,
  NULL AS georeference_protocol_id,
  NULL AS georeference_protocol,
  NULL AS georeference_sources,
  NULL AS georeference_remarks,
  NULL AS information_withheld,
  NULL AS data_generalizations,
  'point-radius' AS preferred_spatial_representation;
-- n=1 rows added
-- n=2 rows total

-- Create the child Reach Events.
INSERT INTO event (
  event_id, 
  parent_event_id,
  event_category,
  event_type,
  dataset_name,
  dataset_id,
  event_conducted_by,
  event_conducted_by_id,
  event_date, 
  year, 
  habitat,
  continent,
  water_body,
  country,
  country_code,
  state_province,
  county,
  locality,
  minimum_elevation_in_meters,
  maximum_elevation_in_meters,
  decimal_latitude, 
  decimal_longitude,
  geodetic_datum,
  coordinate_uncertainty_in_meters,
  coordinate_precision,
  preferred_spatial_representation
)
SELECT DISTINCT
  namedLocation AS event_id, 
  'BIGC' AS parent_event_id,
  'Survey' AS event_category, 
  'Reach' AS event_type, 
  'Fish electrofishing, gill netting, and fyke netting counts' AS dataset_name,
  'https://data.neonscience.org/data-products/DP1.20107.001' AS dataset_id,
  'NEON (National Ecological Observatory Network)' AS event_conducted_by,
  NULL AS event_conducted_id,
  '2019-04-22/2019-10-24' AS event_date,  
  2019 AS year, 
  'stream' AS habitat,
  'North America' AS continent,
  'Upper Big Creek' AS water_body,
  'United States' AS country,
  'US' AS country_code,
  'California' AS state_province,
  'Fresno' AS county,
  'Pacific Southwest (D17), Upper Big Creek NEON (BIGC)' AS locality,
  elevation::numeric-elevationUncertainty::numeric AS minimum_elevation_in_meters,
  elevation::numeric+elevationUncertainty::numeric AS maximum_elevation_in_meters,
  NULLIF(decimalLatitude, '')::numeric AS decimal_latitude, 
  NULLIF(decimalLongitude, '')::numeric AS decimal_longitude,
  geodeticDatum AS geodetic_datum,
  coordinateUncertainty::numeric AS coordinate_uncertainty_in_meters,
  0.000001 AS coordinate_precision,
  'point-radius' AS preferred_spatial_representation
  FROM fsh_fieldData;
-- n=6 rows added
-- n=8 rows total

-- Create a concatenation of CollectedBy fields for each reachID
CREATE TABLE temp_reach_collectors AS
SELECT 
    reachID,
    STRING_AGG(trimmed_collected_by, ' | ') AS collectors
FROM (
    SELECT 
        reachID,
        CASE WHEN aCollectedBy = 'NA' THEN '' ELSE aCollectedBy END AS trimmed_collected_by
    FROM fsh_fieldData
    UNION ALL
    SELECT 
        reachID,
        CASE WHEN bCollectedBy = 'NA' THEN '' ELSE bCollectedBy END
    FROM fsh_fieldData
    UNION ALL
    SELECT 
        reachID,
        CASE WHEN cCollectedBy = 'NA' THEN '' ELSE cCollectedBy END
    FROM fsh_fieldData
) AS collected_values
WHERE trimmed_collected_by != ''
GROUP BY reachID;
-- n=12 rows added
-- n=12 rows total

-- Create the Reach Sampling Events.
INSERT INTO event (
  event_id, 
  parent_event_id,
  event_category,
  event_type, 
  dataset_name,
  dataset_id,
  event_conducted_by,
  event_date, 
  year, 
  habitat,
  event_remarks,
  location_id,
  continent,
  water_body,
  country,
  country_code,
  state_province,
  county,
  locality,
  minimum_elevation_in_meters,
  maximum_elevation_in_meters,
  decimal_latitude, 
  decimal_longitude,
  geodetic_datum,
  coordinate_uncertainty_in_meters,
  coordinate_precision,
  preferred_spatial_representation
)
SELECT 
  a.reachID AS event_id, 
  namedLocation AS parent_event_id,
  'Survey' AS event_category, 
  'Reach Sampling' AS event_type, 
  'Fish electrofishing, gill netting, and fyke netting counts' AS dataset_name,
  'https://data.neonscience.org/data-products/DP1.20107.001' AS dataset_id,
  collectors AS event_conducted_by,
  startDate || '/' || EndDate AS event_date,  
  SUBSTRING(startDate FROM 1 FOR 4)::smallint AS year, 
  CASE 
    WHEN reachCondition = 'NA' THEN aquaticSiteType 
    ELSE aquaticSiteType || ', ' || reachCondition 
  END AS habitat,
  CASE 
    WHEN remarks = 'NA' THEN NULL 
    ELSE remarks 
  END AS event_remarks,
  NULL AS location_id,
  'North America' AS continent,
  'Upper Big Creek' AS water_body,
  'United States' AS country,
  'US' AS country_code,
  'California' AS state_province,
  'Fresno' AS county,
  'Pacific Southwest (D17), Upper Big Creek NEON (BIGC)' || ', ' || namedLocation AS locality,
  elevation::numeric-elevationUncertainty::numeric AS minimum_elevation_in_meters,
  elevation::numeric+elevationUncertainty::numeric AS maximum_elevation_in_meters,
  NULLIF(decimalLatitude, '')::numeric AS decimal_latitude, 
  NULLIF(decimalLongitude, '')::numeric AS decimal_longitude,
  geodeticDatum AS geodetic_datum,
  coordinateUncertainty::numeric AS coordinate_uncertainty_in_meters,
  0.000001 AS coordinate_precision,
  'point-radius' AS preferred_spatial_representation
  FROM fsh_fieldData a
  JOIN temp_reach_collectors b ON a.reachID=b.reachID;
-- n=12 rows added
-- n=20 rows total

-- Create the Pass Sampling Events.
INSERT INTO event (
  event_id, 
  parent_event_id,
  event_category,
  event_type, 
  dataset_name,
  dataset_id,
  event_conducted_by,
  event_date, 
  year, 
  month, 
  day, 
  habitat,
  event_remarks,
  location_id,
  continent,
  water_body,
  country,
  country_code,
  state_province,
  county,
  locality,
  minimum_elevation_in_meters,
  maximum_elevation_in_meters,
  decimal_latitude, 
  decimal_longitude,
  geodetic_datum,
  coordinate_uncertainty_in_meters,
  coordinate_precision,
  preferred_spatial_representation
)
SELECT 
  a.eventID AS event_id, 
  a.reachID AS parent_event_id,
  'Survey' AS event_category, 
  'Pass Sampling' AS event_type, 
  'Fish electrofishing, gill netting, and fyke netting counts' AS dataset_name,
  'https://data.neonscience.org/data-products/DP1.20107.001' AS dataset_id,
  c.collectors AS event_conducted_by,
  CASE WHEN samplerType = 'electrofisher' 
    THEN REPLACE(a.passStartTime, ' ', 'T') || '/' || REPLACE(a.passEndTime, ' ', 'T')
    ELSE REPLACE(a.netSetTime, ' ', 'T') || '/' || REPLACE(a.netEndTime, ' ', 'T')
    END AS event_date,
  CASE WHEN samplerType = 'electrofisher' 
    THEN SUBSTRING(a.passStartTime FROM 1 FOR 4)::smallint
    ELSE SUBSTRING(a.netSetTime FROM 1 FOR 4)::smallint
    END AS year,
  CASE WHEN samplerType = 'electrofisher' 
    THEN SUBSTRING(a.passStartTime FROM 6 FOR 2)::smallint
    ELSE SUBSTRING(a.netSetTime FROM 6 FOR 2)::smallint
    END AS month,
  CASE WHEN samplerType = 'electrofisher' 
    THEN SUBSTRING(a.passStartTime FROM 9 FOR 2)::smallint
    ELSE SUBSTRING(a.netSetTime FROM 9 FOR 2)::smallint
    END AS day,
  'Habitat: ' || habitatType || ' Subdominant Habitat: ' || subdominantHabitatType AS habitat,
  CASE 
    WHEN a.remarks = 'NA' THEN NULL 
    ELSE a.remarks 
  END AS event_remarks,  
  NULL AS locationID,
  'North America' AS continent,
  'Upper Big Creek' AS water_body,
  'United States' AS country,
  'US' AS country_code,
  'California' AS state_province,
  'Fresno' AS county,
  'Pacific Southwest (D17), Upper Big Creek NEON (BIGC)' || ', ' || a.namedLocation AS locality,
  b.elevation::numeric-b.elevationUncertainty::numeric AS minimum_elevation_in_meters,
  b.elevation::numeric+b.elevationUncertainty::numeric AS maximum_elevation_in_meters,
  NULLIF(b.decimalLatitude, '')::numeric AS decimal_latitude, 
  NULLIF(b.decimalLongitude, '')::numeric AS decimal_longitude,
  geodeticDatum AS geodetic_datum,
  coordinateUncertainty::numeric AS coordinate_uncertainty_in_meters,
  0.000001 AS coordinate_precision,
  'point-radius' AS preferred_spatial_representation
  FROM fsh_perPass a
  JOIN fsh_fieldData b on a.reachID=b.reachID
  JOIN temp_reach_collectors c ON a.reachID=c.reachID;
-- n=24 rows added
-- n=44 rows total

-- Create the occurrence table from perFish records.
INSERT INTO occurrence (
  occurrence_id,
  event_id,
  organism_quantity,
  organism_quantity_type,
  life_stage,
  taxon_formula,
  identified_by_id,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  uid AS occurrence_id,
  eventID AS event_id,
  1 AS organism_quantity,
  'individuals' AS organism_quantity_type,
  fishLifeStage AS life_stage,
  'A' AS taxon_formula,
  identifiedBy AS identified_by_id,
  taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  taxonRank AS taxon_rank
FROM fsh_perFish;
-- n=672 rows
-- n=672 rows total

-- Add to the occurrence table from bulkCount records.
INSERT INTO occurrence (
  occurrence_id,
  event_id,
  organism_quantity,
  organism_quantity_type,
  occurrence_remarks,
  taxon_formula,
  identified_by_id,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  uid AS occurrence_id,
  eventID AS event_id,
  bulkFishCount AS organism_quantity,
  'individuals' AS organism_quantity_type,
  actualOrEstimated || ' count' AS occurrence_remarks,
  'A' AS taxon_formula,
  identifiedBy AS identified_by_id,
  taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  'species' AS taxon_rank
FROM fsh_bulkCount;
-- n=4 rows
-- n=676 rows total

-- All Occurrence records have now been added.

-- Create the material table using the vouchers.
INSERT INTO material (
  material_entity_id,
  event_id,
  material_category,
  material_entity_type,
  institution_code,
  owner_institution_code,
  collection_code,
  catalog_number,
  preparations,
  evidence_for_occurrence_id,
  derived_from_material_entity_id,
  derivation_type,
  is_part_of_material_entity_id,
  taxon_formula,
  identified_by_id,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  a.voucherSampleID AS material_entity_id,
  a.eventID AS event_id,
  'preserved' AS material_category,
  'Organism' AS material_entity_type,
  'NEON' AS institution_code,
  'NEON' AS owner_institution_code,
  'FSH' AS collection_code,
  a.voucherSampleID AS catalog_number,
  sampleTypeCollected AS preparations,
  a.uid AS evidence_for_occurrence_id,
  NULL AS derived_from_material_entity_id,
  NULL AS derivation_type,
  NULL AS is_part_of_material_entity_id,
  'A' AS taxon_formula,
  identifiedBy AS identified_by_id,
  taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  taxonRank AS taxon_rank
FROM fsh_perFish a
JOIN event b ON a.eventID=b.event_id
WHERE a.voucherSampleID <> 'NA';
-- n=18 rows
-- n=18 rows total

-- Add the DNA samples to the material table.
INSERT INTO material (
  material_entity_id,
  event_id,
  material_category,
  material_entity_type,
  institution_code,
  owner_institution_code,
  collection_code,
  catalog_number,
  evidence_for_occurrence_id,
  derived_from_material_entity_id,
  derivation_type,
  taxon_formula,
  identified_by_id,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  dnaSampleID AS material_entity_id,
  eventID AS event_id,
  'DNA extract' AS material_category,
  'DNA extract' AS material_entity_type,
  'NEON' AS institution_code,
  'NEON' AS owner_institution_code,
  'FSH' AS collection_code,
  dnaSampleID AS catalog_number,
  uid AS evidence_for_occurrence_id,
  voucherSampleID AS derived_from_material_entity_id,
  'DNA extraction' AS derivation_type,
  'A' AS taxon_formula,
  identifiedBy AS identified_by_id,
  taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  taxonRank AS taxon_rank
FROM fsh_perFish
WHERE dnaSampleID<>'NA';
-- n=11 rows
-- n=29 rows total

-- All vouchers and DNA samples have now been added to the material table.

-- Create the identification table from occurrences without associated material.
INSERT INTO identification (
  identification_id,
  based_on_occurrence_id,
  identification_type,
  is_accepted_identification,
  taxon_formula,
  identified_by_id,
  date_identified,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  gen_random_uuid() AS identification_id,
  a.occurrence_id AS based_on_occurrence_id,
  'Observation' AS identification_type,
  TRUE AS is_accepted_identification,
  'A' AS taxon_formula,
  b.identifiedBy AS identified_by_id,
  c.event_date AS date_identified,
  b.taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  taxonRank AS taxon_rank
FROM occurrence a
JOIN fsh_perFish b ON a.occurrence_id=b.uid
JOIN event c ON a.event_id=c.event_id;
-- n=672 rows
-- n=672 rows total

-- Add identifications from perFish material.
INSERT INTO identification (
  identification_id,
  based_on_material_entity_id,
  identification_type,
  is_accepted_identification,
  taxon_formula,
  identified_by_id,
  date_identified,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  gen_random_uuid() AS identification_id,
  a.material_entity_id AS based_on_material_entity_id,
  'Material' AS identification_type,
  TRUE AS is_accepted_identification,
  'A' AS taxon_formula,
  b.identifiedBy AS identified_by_id,
  c.event_date AS date_identified,
  b.taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  taxonRank AS taxon_rank
FROM material a
JOIN fsh_perFish b on a.material_entity_id=b.voucherSampleID
JOIN event c ON a.event_id=c.event_id;
;
-- n=18 rows
-- n=690 rows total

-- Add identifications from perFish genetic sequences.
INSERT INTO identification (
  identification_id,
  based_on_nucleotide_sequence_id,
  identification_type,
  is_accepted_identification,
  taxon_formula,
  identified_by_id,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  gen_random_uuid() AS identification_id,
  b.dnaSampleID AS based_on_nucleotide_sequence_id,
  'GeneticSequence' AS identification_type,
  TRUE AS is_accepted_identification,
  'A' AS taxon_formula,
  b.identifiedBy AS identified_by_id,
  b.taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  taxonRank AS taxon_rank
FROM material a
JOIN fsh_perFish b on a.material_entity_id=b.dnaSampleID;
-- n=11 rows
-- n=701 rows total

-- Add identifications from bulkCount observations.
INSERT INTO identification (
  identification_id,
  based_on_occurrence_id,
  identification_type,
  is_accepted_identification,
  taxon_formula,
  identified_by_id,
  date_identified,
  taxon_id,
  higher_classification_name,
  higher_classification_rank,
  scientific_name,
  taxon_rank
)
SELECT
  gen_random_uuid() AS identification_id,
  a.occurrence_id AS based_on_occurrence_id,
  'Observation' AS identification_type,
  TRUE AS is_accepted_identification,
  'A' AS taxon_formula,
  b.identifiedBy AS identified_by_id,
  c.event_date AS date_identified,
  b.taxonID AS taxon_id,
  'Animalia' AS higher_classification_name,
  'kingdom' AS higher_classification_rank,
  CASE 
    WHEN RIGHT(scientificName, 4) = ' sp.' THEN LEFT(scientificName, LENGTH(scientificName) - 4)
    ELSE scientificName
  END AS scientific_name,
  'species' AS taxon_rank
FROM occurrence a
JOIN fsh_bulkCount b on a.occurrence_id=b.uid
JOIN event c ON a.event_id=c.event_id;
-- n=4 rows
-- n=705 rows total

-- Create the survey table for the Project.
INSERT INTO survey (
  survey_id,
  event_id,
  site_count,
  site_nesting_description,
  verbatim_site_descriptions,
  verbatim_site_names,
  reported_weather,
  reported_extreme_conditions,
  event_duration_value,
  event_duration_unit,
  taxon_completeness_reported,
  taxon_completeness_protocols,
  is_absence_reported,
  has_non_target_taxa,
  non_target_taxa,
  are_non_target_taxa_fully_reported,
  verbatim_target_scope,
  identified_by_id,
  compilation_types,
  protocol_names,
  protocol_descriptions,
  protocol_references,
  is_abundance_reported,
  is_abundance_cap_reported,
  is_least_specific_target_category_quantity_inclusive,
  has_vouchers,
  voucher_institutions,
  has_material_samples,
  material_sample_types,
  sampling_performed_by,
  is_sampling_effort_reported,
  sampling_effort_protocol
)
SELECT
  gen_random_uuid() AS survey_id,
  eventID AS event_id,
  CASE WHEN siteCount = 'NA' THEN NULL ELSE siteCount::SMALLINT END AS site_count,
  CASE WHEN siteNestingDescription = 'NA' THEN NULL ELSE siteNestingDescription END AS site_nesting_description,
  CASE WHEN verbatimSiteDescriptions = 'NA' THEN NULL ELSE verbatimSiteDescriptions END AS verbatim_site_descriptions,
  CASE WHEN verbatimSiteNames = 'NA' THEN NULL ELSE verbatimSiteNames END AS verbatim_site_names,
  CASE WHEN reportedWeather = 'NA' THEN NULL ELSE reportedWeather END AS reported_weather,
  CASE WHEN reportedExtremeConditions = 'NA' THEN NULL ELSE reportedExtremeConditions END AS reported_extreme_conditions,
  CASE WHEN eventDurationValue = 'NA' THEN NULL ELSE eventDurationValue::NUMERIC END AS event_duration_value,
  CASE WHEN eventDurationUnit = 'NA' THEN NULL ELSE eventDurationUnit END AS event_duration_unit,
  'not reported'::TAXON_COMPLETENESS_REPORTED AS taxon_completeness_reported,
  CASE WHEN taxonCompletenessProtocols = 'NA' THEN NULL ELSE taxonCompletenessProtocols END AS taxon_completeness_protocols,
  CASE WHEN isAbsenceReported = 'NA' THEN NULL ELSE isAbsenceReported::BOOLEAN END AS is_absence_reported,
  CASE WHEN hasNonTargetTaxa = 'NA' THEN NULL ELSE hasNonTargetTaxa::BOOLEAN END AS has_non_target_taxa,
  CASE WHEN nonTargetTaxa = 'NA' THEN NULL ELSE nonTargetTaxa END AS non_target_taxa,
  CASE WHEN areNonTargetTaxaFullyReported = 'NA' THEN NULL ELSE areNonTargetTaxaFullyReported::BOOLEAN END AS are_non_target_taxa_fully_reported,
  CASE WHEN verbatimTargetScope = 'NA' THEN NULL ELSE verbatimTargetScope END AS verbatim_target_scope,
  CASE WHEN identifiedBy = 'NA' THEN NULL ELSE 'https://orcid.org/' || identifiedBy END AS identified_by_id,
  CASE WHEN compilationTypes = 'NA' THEN NULL ELSE compilationTypes END AS compilation_types,
  CASE WHEN protocolNames = 'NA' THEN NULL ELSE protocolNames END AS protocol_names,
  CASE WHEN protocolDescriptions = 'NA' THEN NULL ELSE protocolDescriptions END AS protocol_descriptions,
  CASE WHEN protocolReferences = 'NA' THEN NULL ELSE protocolReferences END AS protocol_references,
  CASE WHEN isAbundanceReported = 'NA' THEN NULL ELSE isAbundanceReported::BOOLEAN END AS is_abundance_reported,
  CASE WHEN isAbundanceCapReported = 'NA' THEN NULL ELSE isAbundanceCapReported::BOOLEAN END AS is_abundance_cap_reported,
  CASE WHEN isLeastSpecificTargetCategoryQuantityInclusive = 'NA' THEN NULL ELSE isLeastSpecificTargetCategoryQuantityInclusive::BOOLEAN END AS is_least_specific_target_category_quantity_inclusive,
  CASE WHEN hasVouchers = 'NA' THEN NULL ELSE hasVouchers::BOOLEAN END AS has_vouchers,
  CASE WHEN voucherInstitutions = 'NA' THEN NULL ELSE voucherInstitutions END AS voucher_institutions,
  CASE WHEN hasMaterialSamples = 'NA' THEN NULL ELSE hasMaterialSamples::BOOLEAN END AS has_material_samples,
  CASE WHEN materialSampleTypes = 'NA' THEN NULL ELSE materialSampleTypes END AS material_sample_types,  
  CASE WHEN samplingPerformedBy = 'NA' THEN NULL ELSE samplingPerformedBy END AS sampling_performed_by,
  CASE WHEN isSamplingEffortReported = 'NA' THEN NULL ELSE isSamplingEffortReported::BOOLEAN END AS is_sampling_effort_reported,
  CASE WHEN samplingEffortProtocol = 'NA' THEN NULL ELSE samplingEffortProtocol END AS sampling_effort_protocol
FROM dwcav1_event;
-- n=44 rows
-- n=44 rows total

-- Create the event_assertion table with measuredReachLength from fsh_fieldData table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  reachID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  measuredReachLength::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_fieldData a,
  variables b
WHERE 
  _table = 'fsh_fieldData' AND
  fieldName = 'measuredReachLength' AND
  measuredReachLength <> 'NA';
-- n=12 rows
-- n=12 rows total

-- Add fixedRandomReach from fsh_fieldData to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  reachID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  fixedRandomReach AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_fieldData a,
  variables b
WHERE 
  _table = 'fsh_fieldData' AND
  fieldName = 'fixedRandomReach' AND
  fixedRandomReach <> 'NA';
-- n=12 rows
-- n=24 rows total

-- Add passNumber from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  passNumber::NUMERIC AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perFish a,
  variables b
WHERE 
  _table = 'fsh_perFish' AND
  fieldName = 'passNumber' AND
  passNumber <> 'NA';
-- n=672 rows
-- n=696 rows total

-- Add waterTemp from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  waterTemp::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'waterTemp' AND
  waterTemp <> 'NA';
-- n=24 rows
-- n=720 rows total

-- Add dissolvedOxygen from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  dissolvedOxygen::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'dissolvedOxygen' AND
  dissolvedOxygen <> 'NA';
-- n=24 rows
-- n=744 rows total

-- Add specificConductance from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  specificConductance::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'specificConductance' AND
  specificConductance <> 'NA';
-- n=24 rows
-- n=768 rows total

-- Add samplerType from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  samplerType AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'samplerType' AND
  samplerType <> 'NA';
-- n=24 rows
-- n=792 rows total

-- Add initialFrequency from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  initialFrequency::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'initialFrequency' AND
  initialFrequency <> 'NA';
-- n=24 rows
-- n=816 rows total

-- Add initialDutyCycle from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  initialDutyCycle::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'initialDutyCycle' AND
  initialDutyCycle <> 'NA';
-- n=24 rows
-- n=840 rows total

-- Add initialVoltage from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  initialVoltage::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'initialVoltage' AND
  initialVoltage <> 'NA';
-- n=24 rows
-- n=864 rows total

-- Add finalFrequency from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  finalFrequency::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'finalFrequency' AND
  finalFrequency <> 'NA';
-- n=24 rows
-- n=888 rows total

-- Add finalDutyCycle from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  finalDutyCycle::SMALLINT AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'finalDutyCycle' AND
  finalDutyCycle <> 'NA';
-- n=24 rows
-- n=912 rows total

-- Add finalVoltage from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  finalVoltage::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'finalVoltage' AND
  finalVoltage <> 'NA';
-- n=24 rows
-- n=936 rows total

-- Add efTime from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  efTime::INTEGER AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'efTime' AND
  efTime <> 'NA';
-- n=24 rows
-- n=960 rows total

-- Add settingsChanged from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  settingsChanged::SMALLINT AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'settingsChanged' AND
  settingsChanged <> 'NA';
-- n=22 rows
-- n=982 rows total

-- Add netIntegrity from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  netIntegrity AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'netIntegrity' AND
  netIntegrity <> 'NA';
-- n=24 rows
-- n=1006 rows total

-- Add targetTaxaPresent from fsh_perPass to the event_assertion table.
INSERT INTO event_assertion (
  assertion_id,
  event_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  eventID AS event_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  targetTaxaPresent AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perPass a,
  variables b
WHERE 
  _table = 'fsh_perPass' AND
  fieldName = 'targetTaxaPresent' AND
  targetTaxaPresent <> 'NA';
-- n=24 rows
-- n=1030 rows total

-- Add fishTotalLength from fsh_perFish to the occurrence_assertion table.
INSERT INTO occurrence_assertion (
  assertion_id,
  occurrence_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  uid AS occurrence_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  fishTotalLength::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perFish a,
  variables b
WHERE 
  _table = 'fsh_perFish' AND
  fieldName = 'fishTotalLength' AND
  fishTotalLength <> 'NA';
-- n=671 rows
-- n=671 rows total

-- Add fishWeight from fsh_perFish to the assertion table.
INSERT INTO occurrence_assertion (
  assertion_id,
  occurrence_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  uid AS occurrence_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  NULL AS assertion_value,
  fishWeight::NUMERIC AS assertion_value_numeric,
  b.units AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perFish a,
  variables b
WHERE 
  _table = 'fsh_perFish' AND
  fieldName = 'fishWeight' AND
  fishWeight <> 'NA';
-- n=672 rows
-- n=1343 rows total

-- Add delt from fsh_perFish to the assertion table.
INSERT INTO occurrence_assertion (
  assertion_id,
  occurrence_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  uid AS occurrence_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  delt AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perFish a,
  variables b
WHERE 
  _table = 'fsh_perFish' AND
  fieldName = 'delt' AND
  delt <> 'NA';
-- n=3 rows
-- n=1346 rows total

-- Add efMortality from fsh_perFish to the assertion table.
INSERT INTO occurrence_assertion (
  assertion_id,
  occurrence_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  uid AS occurrence_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  efMortality AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perFish a,
  variables b
WHERE 
  _table = 'fsh_perFish' AND
  fieldName = 'efMortality' AND
  efMortality <> 'NA';
-- n=8 rows
-- n=1354 rows total

-- Add efInjury from fsh_perFish to the assertion table.
INSERT INTO occurrence_assertion (
  assertion_id,
  occurrence_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  uid AS occurrence_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  efInjury AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perFish a,
  variables b
WHERE 
  _table = 'fsh_perFish' AND
  fieldName = 'efInjury' AND
  efInjury <> 'NA';
-- n=1 rows
-- n=1355 rows total

-- Add specimenNumber from fsh_perFish to the assertion table.
INSERT INTO occurrence_assertion (
  assertion_id,
  occurrence_id,
  assertion_type,
  assertion_type_iri,
  assertion_type_vocabulary,
  assertion_made_date,
  assertion_effective_date,
  assertion_value,
  assertion_value_numeric,
  assertion_unit,
  assertion_unit_iri,
  assertion_unit_vocabulary,
  assertion_by, 
  assertion_by_id,
  assertion_protocols,
  assertion_protocol_id,
  assertion_references,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  uid AS occurrence_id,
  b.description AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  specimenNumber AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocols,
  NULL AS assertion_protocol_id,
  NULL AS assertion_references,
  NULL AS assertion_remarks
FROM 
  fsh_perFish a,
  variables b
WHERE 
  _table = 'fsh_perFish' AND
  fieldName = 'specimenNumber' AND
  specimenNumber <> 'NA';
-- n=672 rows
-- n=2027 rows total

-- Create the NucleotideSequence table
INSERT INTO nucleotide_sequence (
  nucleotide_sequence_id,
  nucleotide_sequence
)
(
SELECT 
  gen_random_uuid() AS nucleotide_sequence_id,
  DNA_sequence
FROM dwcav1_dna_derived_data
GROUP BY DNA_sequence
);
-- n=4 rows
-- n=4 rows total

-- Create the MolecularProtocol table
INSERT INTO molecular_protocol (
  molecular_protocol_id,
  target_gene
)
(
SELECT
  gen_random_uuid() AS molecular_protocol_id,
  target_gene AS target_gene
FROM dwcav1_dna_derived_data
GROUP BY target_gene
);
-- n=1 rows
-- n=1 rows total

-- Create the NucleotideAnalysis table
INSERT INTO nucleotide_analysis (
  nucleotide_analysis_id,
  event_id,
  molecular_protocol_id,
  nucleotide_sequence_id,
  material_entity_id
)
SELECT
  gen_random_uuid() AS nucleotide_sequence_id,
  b.eventID AS event_id,
  d.molecular_protocol_id AS molecular_protocol_id,
  c.nucleotide_sequence_id AS nucleotide_sequence_id,
  b.voucherSampleID AS material_entity_id
FROM dwcav1_dna_derived_data a
JOIN fsh_perFish b ON a.occurrenceID=b.uid
JOIN nucleotide_sequence c ON a.DNA_sequence=c.nucleotide_sequence
JOIN molecular_protocol d ON a.target_gene=d.target_gene;
-- n=11 rows
-- n=11 rows total
