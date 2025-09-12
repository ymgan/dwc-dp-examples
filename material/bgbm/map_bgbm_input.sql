-- Before beginning, make the occurrenceStatus lowercase, consistent with the ENUM
-- values in the target database structure at 
-- https://github.com/gbif/model-dwc-dp/blob/master/gbif/dwc_dp_schema.sql

-- Temporary measure to remove duplicate eventIDs on input from event.txt
INSERT INTO input_event (
SELECT DISTINCT ON (eventID) *
FROM temp_event
ORDER BY eventID
);

-- Fill the event table.
INSERT INTO event (
    event_id, 
    field_number,
    event_type, 
    event_category, 
    event_conducted_by, 
    event_conducted_by_id,
    event_date, 
    verbatim_event_date, 
    locality, 
    habitat,
    continent,
    verbatim_elevation, 
    country, 
    country_code, 
    decimal_latitude, 
    decimal_longitude, 
    geodetic_datum, 
    event_remarks
)
(SELECT
    eventID AS event_id,
    fieldNumber AS field_number, 
    eventType AS event_type, 
    eventCategory AS event_category, 
    eventConductedBy AS event_conducted_by, 
    eventConductedByID AS event_conducted_by_id, 
    eventDate AS event_date, 
    verbatimEventDate AS verbatim_event_date, 
    locality, 
    habitat, 
    continent, 
    verbatimElevation AS verbatim_elevation, 
    country, 
    countryCode AS countryCode, 
    NULLIF(decimalLatitude, '')::NUMERIC AS decimal_latitude,
    NULLIF(decimalLongitude, '')::NUMERIC AS decimal_longitude,
    geodeticDatum AS geodetic_datum, 
    eventRemarks AS event_remarks 
FROM input_event
);
-- n = 529704

-- Fill the material table.
INSERT INTO material (
    material_entity_id,
    event_id,
    evidence_for_occurrence_id,
    material_entity_type,
    material_category,
    preparations,
    institution_code,
    institution_id,
    owner_institution_code,
    owner_institution_id,
    collection_code,
    collection_id,
    catalog_number,
    record_number,
    material_entity_remarks,
    derived_from_material_entity_id,
    derivation_type,
    derivation_event_id
)
(
SELECT 
    TRIM(materialEntityID) AS material_entity_id,
    eventID AS event_id,
    evidenceForOccurrenceID AS evidence_for_occurrence_id,
    materialEntityType AS material_entity_type,
    'preserved' AS material_category,
    preparations,
    institutionCode AS institution_code,
    institutionID AS institution_id,
    ownerInstitutionCode AS owner_institution_code,
    owner_institutionID AS owner_institution_id,
    collectionCode AS collection_code,
    collectionID AS collection_id,
    catalogNumber AS catalog_number,
    recordNumber AS record_number,
    materialEntityRemarks AS material_entity_remarks,
    derivedFromMaterialEntityID AS derived_from_material_entity_id,
    derivationType AS derivation_type,
    derivationEventID AS derivation_event_id
FROM input_material
);
-- n = 529704

--UPDATE material a
--SET 
--    scientific_name = b.scientificName,
--    taxon_rank = b.taxonRank
--FROM input_identification b
--WHERE a.material_entity_id=b.identificationBasedOnMaterialEntityID
--AND b.isAcceptedIdentification = True;
-- n = 

-- Fill the occurrence table.
INSERT INTO occurrence (
    occurrence_id,
    event_id,
    organism_id,
    recorded_by,
    recorded_by_id,
    sex,
    occurrence_status,
    occurrence_remarks
)
(SELECT
    TRIM(occurrenceID) AS occurrence_id,
    eventID AS event_id,
    organismID AS organism_id,
    recordedBy AS recorded_by,
    recordedByID AS recorded_by_id,
    sex,
    NULLIF(occurrenceStatus, '')::OCCURRENCE_STATUS AS occurrence_status,
    occurrenceRemarks as occurrence_remarks
FROM input_occurrence a
);
-- n = 503395

-- Fill the agent table.
INSERT INTO agent (
    agent_id,
    agent_type,
    preferred_agent_name
)
(SELECT
    agent_id,
    agent_type,
    preferred_agent_name
FROM input_agent
);
-- n = 1

-- Kludge to further test despite missing molecular_protocol table.
INSERT INTO molecular_protocol (
    molecular_protocol_id
)
(SELECT
    'petD' AS molecular_protocol_id
);
-- n = 1

-- Fill the nucleotide_sequence table.
INSERT INTO nucleotide_sequence (
    nucleotide_sequence_id,
    nucleotide_sequence,
    nucleotide_sequence_remarks
)
(SELECT
    nucleotideSequenceID AS nucleotide_sequence_id,
    nucleotideSequence AS nucleotide_sequence,
    nucleotideSequenceRemarks AS nucleotide_sequence_remarks
FROM input_nucleotide_sequence
);
-- n = 224

-- Fill the nucleotide_analysis table.
INSERT INTO nucleotide_analysis (
    nucleotide_analysis_id,
    nucleotide_sequence_id,
    event_id,
    material_entity_id,
    molecular_protocol_id
)
(SELECT
    nucleotideAnalysisID AS nucleotide_analysis_id,
    nucleotideSequenceID AS nucleotide_sequence_id,
    eventID AS event_id,
    materialEntityID AS material_entity_id,
    molecularProtocolID AS molecular_protocol_id
FROM input_nucleotide_analysis
);
-- n = 224

-- Fill the identification table.
INSERT INTO identification (
    identification_id,
    based_on_material_entity_id,
    taxon_formula,
    type_status,
    identified_by,
    date_identified,
    scientific_name,
    taxon_rank,
    is_accepted_identification
)
(SELECT
    identificationID AS identification_id,
    identificationBasedOnMaterialEntityID AS based_on_material_entity_id,
    taxonFormula AS taxon_formula,
    typeStatus AS type_status,
    identifiedBy AS identified_by,
    dateIdentified AS date_identified,
    scientificName AS scientific_name,
    taxonRank AS taxon_rank,
    isAcceptedIdentification AS is_accepted_identification
FROM input_identification
);
-- n = 578109

-- Fill the material_assertion table.

INSERT INTO material_assertion (
    assertion_id,
    material_entity_id,
    assertion_type,
    assertion_type_iri,
    assertion_type_vocabulary,
    assertion_made_date,
    assertion_value,
    assertion_value_numeric,
    assertion_unit,
    assertion_remarks
)
(SELECT
    assertionID AS assertion_id,
    materialEntityID AS material_entity_id,
    assertionType AS assertion_type,
    assertionTypeIRI AS assertion_type_iri,
    assertionTypeVocabulary AS assertion_type_vocabulary,
    assertion_made_date AS assertion_made_date,
    assertion_value AS assertion_value,
    NULLIF(assertion_value_numeric, '')::NUMERIC AS assertion_value_numeric,
    assertion_unit AS assertion_unit,
    assertion_remarks AS assertion_remarks
FROM input_material_assertion
);
-- n = 28081

-- Fill the material_identifier table.

INSERT INTO material_identifier (
    identifier,
    material_entity_id,
    identifier_type
)
(SELECT
    identifier,
    TRIM(materialEntityID) AS material_entity_id,
    identifier_type AS identifier_type
FROM input_material_identifier
);
-- n = 529704

-- Fill the media table.

INSERT INTO media (
    media_id,
    media_type,
    access_uri,
    web_statement,
    format,
    rights,
    owner,
    creator
)
(SELECT
    mediaID AS media_id,
    mediaType AS media_type,
    accessURI AS access_uri,
    WebStatement AS web_statement,
    format,
    rights,
    owner,
    creator
FROM input_media
);
-- n = 454098

-- Fill the material_media table.

INSERT INTO material_media (
    media_id,
    material_entity_id,
    media_subject_category
)
(SELECT
    mediaID AS media_id,
    materialEntityID AS material_entity_id,
    mediaSubjectCategory AS media_subject_category
FROM input_material_media
);
-- n = 369194

-- Fill the occurrence_media table.
-- Kludge: one occurrenceID isn't present in the input_occurrence table, even after trimming.
INSERT INTO occurrence_media (
    media_id,
    occurrence_id,
    media_subject_category
)
(SELECT
    mediaID AS media_id,
    occurrenceID AS occurrence_id,
    mediaSubjectCategory AS media_subject_category
FROM input_occurrence_media
WHERE occurrenceID<>'B -W 07872x-00 0'
);
-- n = 84901
