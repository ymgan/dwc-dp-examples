-- For this dataset, every record in input/ecoab-occurrences.csv represents a 
-- MaterialEntity and an Occurrence. The occurrenceID in ecoab-occurrences best 
-- represents a materialEntityID, as it is constructed from a Darwin Core triplet.
-- Generate Event eventIDs based on the MaterialEntities. These events will be reused
-- between material, occurrence, and organism_interaction.

-- Before beginning, make the capitalization consistent on occurrenceID and resourceID in the 
-- ecoab_interaction_data table.

UPDATE ecoab_interaction_data
SET 
occurrenceID = UPPER(occurrenceID),
resourceID = UPPER(resourceID);
-- n = 17265

-- Make a temp_material table to mint eventIDs, occurrence_ids, and 
-- organism_interaction_ids.
SELECT 
    occurrenceID as material_entity_id,
    gen_random_uuid()::TEXT AS event_id,
    gen_random_uuid()::TEXT AS subject_occurrence_id,
    gen_random_uuid()::TEXT AS related_occurrence_id,
    gen_random_uuid()::TEXT AS organism_interaction_id
INTO TABLE temp_material
FROM ecoab_occurrences;

-- Fill the Event table from ecoab-occurrences

INSERT INTO event (
    event_id, 
    event_type, 
    year, 
    month, 
    day, 
    location_id, 
    country, 
    state_province, 
    municipality, 
    locality, 
    decimal_latitude, 
    decimal_longitude, 
    minimum_elevation_in_meters, 
    event_date
)
(SELECT
    b.event_id AS event_id,
    'mixed' AS event_type, 
    year, 
    month, 
    day, 
    locationID, 
    country, 
    stateProvince, 
    municipality, 
    locality, 
    decimalLatitude, 
    decimalLongitude, 
    minimumElevationInMeters, 
    eventDate 
FROM ecoab_occurrences a
JOIN temp_material b ON a.occurrenceID=b.material_entity_id
);
-- n = 17265

-- Fill the material table, generating the event_id.

INSERT INTO material (
    material_entity_id,
    event_id,
    material_category,
    material_entity_type,
    institution_code,
    collection_code,
    catalog_number,
    other_catalog_numbers,
    collected_by,
    collected_by_id,
    evidence_for_occurrence_id,
    identified_by,
    identified_by_id,
    taxon_id,
    kingdom,
    scientific_name,
    taxon_rank
)
(
SELECT 
    b.material_entity_id AS material_entity_id,
    b.event_id AS event_id,
    'preserved' AS material_category,
    'Organism' AS material_entity_type,
    'ECOSUR-SC' AS institution_code,
    collectionCode AS collection_code,
    catalogNumber AS catalog_number,
    occurrenceID AS other_catalog_numbers,
    recordedBy AS collected_by,
    recordedByID AS collected_by_id,
    b.subject_occurrence_id AS evidence_for_occurrence_id,
    identifiedBy AS identified_by,
    identifiedByID AS identified_by_id,
    a.taxonID AS taxon_id,
    c.kingdom AS kingdom,
    c.scientificName AS scientific_name,
    c.taxonRank AS taxon_rank
FROM ecoab_occurrences a
JOIN temp_material b ON a.occurrenceID=b.material_entity_id
JOIN ecoab_occurrence_taxa c ON a.taxonID=c.taxonID
);
-- n = 17265

-- Fill the Occurrence table with the subject Occurrences
INSERT INTO occurrence (
    occurrence_id,
    event_id,
    recorded_by,
    recorded_by_id,
    organism_quantity,
    organism_quantity_type,
    sex,
    occurrence_status,
    organism_id,
    organism_scope,
    identified_by,
    identified_by_id,
    taxon_id,
    kingdom,
    scientific_name,
    taxon_rank
)
(SELECT
    b.subject_occurrence_id,
    b.event_id,
    recordedBy AS recorded_by,
    recordedByID AS recorded_by_id,
    '1' AS organism_quantity,
    'individuals' AS organism_quantity_type,
    sex,
    'detected' AS occurrence_status,
    occurrenceID as organism_id,
    'multicellular organism' AS organism_scope,
    identifiedBy AS identified_by,
    identifiedByID AS identified_by_id,
    a.taxonID AS taxon_id,
    c.kingdom,
    c.scientificName AS scientific_name,
    c.taxonRank AS taxon_rank
FROM ecoab_occurrences a
JOIN temp_material b ON a.occurrenceID=b.material_entity_id
JOIN ecoab_occurrence_taxa c ON a.taxonID=c.taxonID
);
-- n = 17265

-- Fill the Occurrence table with the related Occurrences
INSERT INTO occurrence (
    occurrence_id,
    event_id,
    recorded_by,
    recorded_by_id,
    organism_quantity,
    organism_quantity_type,
    occurrence_status,
    organism_scope,
    identified_by,
    identified_by_id,
    taxon_id,
    kingdom,
    scientific_name,
    taxon_rank
)
(SELECT
    b.related_occurrence_id,
    b.event_id,
    recordedBy AS recorded_by,
    recordedByID AS recorded_by_id,
    '1' AS organism_quantity,
    'individuals' AS organism_quantity_type,
    'detected' AS occurrence_status,
    'multicellular organism' AS organism_scope,
    recordedBy AS identified_by,
    recordedByID AS identified_by_id,
    d.relatedResourceID AS taxon_id,
    c.kingdom,
    c.scientificName AS scientific_name,
    c.taxonRank AS taxon_rank
FROM ecoab_occurrences a
JOIN ecoab_interaction_data d ON a.occurrenceID=d.occurrenceID
JOIN temp_material b ON a.occurrenceID=b.material_entity_id
JOIN ecoab_occurrence_taxa c ON c.taxonID=d.relatedResourceID
);
-- n = 17265

-- All Occurrences have now been made

-- Make OrganismInteractions
INSERT INTO organism_interaction (
    organism_interaction_id,
    event_id,
    organism_interaction_description,
    subject_occurrence_id,
    organism_interaction_type,
    related_occurrence_id,
    related_organism_part
)
(SELECT
    a.organism_interaction_id,
    a.event_id,
    relationshipOfResource AS organism_interaction_description,
    a.subject_occurrence_id,
    relationshipOfResource AS organism_interaction_type,
    a.related_occurrence_id,
    'flowers' AS related_organism_part
FROM temp_material a
JOIN ecoab_interaction_data b ON a.material_entity_id=b.occurrenceID
);
-- n = 17265

-- Make OrganismInteractionAssertions with organismInteractionTypeIRIs
INSERT INTO organism_interaction_assertion (
  assertion_id,
  organism_interaction_id,
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
  assertion_protocol,
  assertion_protocol_id,
  assertion_citation,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  organism_interaction_id,
  'organismInteractionTypeIRI' AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  b.relationshipOfResourceID AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocol,
  NULL AS assertion_protocol_id,
  NULL AS assertion_citation,
  NULL AS assertion_remarks
FROM temp_material a
JOIN ecoab_interaction_data b ON a.material_entity_id=b.occurrenceID;

-- Add organismInteractionTypeVocabulary to OrganismInteractionAssertions
INSERT INTO organism_interaction_assertion (
  assertion_id,
  organism_interaction_id,
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
  assertion_protocol,
  assertion_protocol_id,
  assertion_citation,
  assertion_remarks
)
SELECT
  gen_random_uuid() AS assertion_id,
  organism_interaction_id,
  'organismInteractionTypeVocabulary' AS assertion_type,
  NULL AS assertion_type_iri,
  NULL AS assertion_type_vocabulary,
  NULL AS assertion_made_date,
  NULL AS assertion_effective_date,
  'https://obofoundry.org/ontology/ro.html' AS assertion_value,
  NULL AS assertion_value_numeric,
  NULL AS assertion_unit,
  NULL AS assertion_unit_iri,
  NULL AS assertion_unit_vocabulary,
  NULL AS assertion_by,
  NULL AS assertion_by_id,
  NULL AS assertion_protocol,
  NULL AS assertion_protocol_id,
  NULL AS assertion_citation,
  NULL AS assertion_remarks
FROM temp_material a
JOIN ecoab_interaction_data b ON a.material_entity_id=b.occurrenceID
