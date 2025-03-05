-- Fill the event table.
INSERT INTO event (
    event_id, 
    parent_event_id, 
    preferred_event_name,
    event_type, 
    event_conducted_by, 
    event_conducted_by_id,
    event_date, 
    year,
    month,
    day,
    verbatim_locality, 
    sample_size_value,
    sample_size_unit,
    event_citation,
    event_remarks,
    location_id,
    water_body,
    country_code, 
    minimum_depth_in_meters,
    maximum_depth_in_meters,
    decimal_latitude, 
    decimal_longitude, 
    geodetic_datum, 
    footprint_wkt,
    footprint_srs
)
(SELECT
    eventID AS event_id,
    parentEventID AS parent_event_id,
    preferredEventName AS preferred_event_name,
    eventType AS event_type, 
    eventConductedBy AS event_conducted_by, 
    eventConductedByID AS event_conducted_by_id, 
    eventDate AS event_date, 
    year,
    month,
    day,
    verbatimLocality AS verbatim_locality,
    sampleSizeValue AS sample_size_value,
    sampleSizeUnit AS sample_size_unit,
    eventCitation AS event_citation,
    eventRemarks AS event_remarks,
    locationID AS location_id,
    waterBody AS water_body,
    countryCode AS countryCode, 
    minimumDepthInMeters AS minimum_depth_in_meters,
    maximumDepthInMeters AS maximum_depth_in_meters,
    NULLIF(decimalLatitude, '')::NUMERIC AS decimal_latitude,
    NULLIF(decimalLongitude, '')::NUMERIC AS decimal_longitude,
    geodeticDatum AS geodetic_datum, 
    footprintWKT AS footprint_wkt,
    footprintSRS AS footprint_srs
FROM input_event
);
-- n = 376

-- Fill the material table.
INSERT INTO material (
    material_entity_id,
    event_id,
    material_entity_type,
    collected_by,
    collected_by_id,
    preparations,
    disposition,
    material_entity_remarks,
    derived_from_material_entity_id,
    derivation_type,
    part_of_material_entity_id,
    verbatim_identification,
    identified_by,
    identified_by_id,
    identification_remarks,
    taxon_id,
    kingdom,
    scientific_name,
    taxon_rank
)
(
SELECT 
    materialEntityID AS material_entity_id,
    eventID AS event_id,
    materialEntityType AS material_entity_type,
    collectedBy AS collected_by,
    collectedByID AS collected_by_id,
    preparations,
    disposition,
    materialEntityRemarks AS material_entity_remarks,
    derivedFromMaterialEntityID AS derived_from_material_entity_id,
    derivationType AS derivation_type,
    partOfMaterialEntityID as part_of_material_entity_id,
    verbatimIdentification AS verbatim_identification,
    identifiedBy AS identified_by,
    identifiedByID AS identified_by_id,
    identificationRemarks AS identification_remarks,
    taxonID AS taxon_id,
    kingdom,
    scientificName AS scientific_name,
    taxonRank AS taxon_rank
FROM input_material
);
-- n = 561

-- Fill the occurrence table.
INSERT INTO occurrence (
    occurrence_id,
    event_id,
    recorded_by,
    recorded_by_id,
    organism_quantity,
    organism_quantity_type,
    life_stage,
    occurrence_status,
    verbatim_identification,
    identified_by,
    identified_by_id,
    taxon_id,
    kingdom,
    scientific_name,
    taxon_rank
)
(SELECT
    occurrenceID AS occurrence_id,
    eventID AS event_id,
    recordedBy AS recorded_by,
    recordedByID AS recorded_by_id,
    organismQuantity AS organism_quantity,
    organismQuantityType AS organism_quantity_type,
    lifeStage AS life_stage,
    NULLIF(occurrenceStatus, '')::OCCURRENCE_STATUS AS occurrence_status,
    verbatimIdentification AS verbatim_identification,
    identifiedBy AS identified_by,
    identifiedByID AS identified_by_id,
    taxonID AS taxon_id,
    kingdom,
    scientificName AS scientific_name,
    taxonRank AS taxon_rank
FROM input_occurrence
);
-- n = 151

-- Fill the agent table.
INSERT INTO agent (
    agent_id,
    agent_type,
    preferred_agent_name
)
(SELECT
    agentID AS agent_id,
    agentType AS agent_type,
    preferredAgentName AS preferred_agent_name
FROM input_agent
);
-- n = 2

-- Fill the agent_agent_role table.
/* NOTE: table is missing related_agent_id
INSERT INTO agent_agent_role (
    agent_id,
    related_agent_id,
    agent_role
)
(SELECT
    agentID AS identification_id,
    relatedAgentID AS agent_id,
    agentRole AS agent_role
FROM input_identification_agent_role
);
*/
-- n = 1

-- Fill the agent_identifier table.
INSERT INTO agent_identifier (
    identifier,
    agent_id,
    identifier_type,
    identifier_language
)
(SELECT
    identifier,
    agentID AS agent_id,
    identifierType AS identifier_type,
    identifierLanguage AS identifier_language
FROM input_agent_identifier
);
-- n = 1

-- Fill the identification table.
INSERT INTO identification (
    identification_id,
    identification_based_on_material_entity_id,
    identification_type,
    identification_type_iri,
    verbatim_identification,
    identified_by,
    identified_by_id,
    identification_references,
    identification_remarks,
    taxon_id,
    kingdom,
    scientific_name,
    taxon_rank
)
(SELECT
    identificationID AS identification_id,
    identificationBasedOnMaterialEntityID AS identification_based_on_material_entity_id,
    identificationType AS identification_type,
    identificationTypeIRI AS identification_type_iri,
    verbatimIdentification AS verbatim_identification,
    identifiedBy AS identified_by,
    identifiedByID AS identified_by_id,
    identificationReferences AS identification_references,
    identificationRemarks AS identification_remarks,
    taxonID AS taxon_id,
    kingdom,
    scientificName AS scientific_name,
    taxonRank AS taxon_rank
FROM input_identification
);
-- n = 561

-- Fill the material_assertion table.
INSERT INTO material_assertion (
    assertion_id,
    material_entity_id,
    assertion_type,
    assertion_type_iri,
    assertion_value,
    assertion_value_iri,
    assertion_value_numeric,
    assertion_unit,
    assertion_unit_iri
)
(SELECT
    assertionID AS assertion_id,
    materialEntityID AS material_entity_id,
    assertionType AS assertion_type,
    assertionTypeIRI AS assertion_type_iri,
    assertionValue AS assertion_value,
    assertionValueIRI AS assertion_value_iri,
    NULLIF(assertionValueNumeric, '')::NUMERIC AS assertion_value_numeric,
    assertionUnit AS assertion_unit,
    assertionUnitIRI AS assertion_unit_iri
FROM input_material_assertion
);
-- n = 1013

-- Fill the media table.
INSERT INTO media (
    media_id,
    media_type,
    access_uri,
    format,
    rights,
    creator,
    creator_id,
    media_language,
    media_description
)
(SELECT
    mediaID AS media_id,
    mediaType AS media_type,
    accessURI AS access_uri,
    format,
    rights,
    creator,
    creatorID AS creator_id,
    mediaLanguage AS media_language,
    mediaDescription AS media_description
FROM input_media
);
-- n = 215

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
-- n = 215

INSERT INTO event_assertion (
    assertion_id,
    event_id,
    assertion_type,
    assertion_type_iri,
    assertion_type_vocabulary,
    assertion_value,
    assertion_value_iri,
    assertion_value_numeric,
    assertion_unit,
    assertion_unit_iri,
    assertion_unit_vocabulary,
    assertion_protocol,
    assertion_protocol_id
)
(SELECT
    assertionID AS assertion_id,
    eventID AS event_id,
    assertionType AS assertion_type,
    assertionTypeIRI AS assertion_type_iri,
    assertionTypeVocabulary AS assertion_type_vocabulary,
    assertionValue AS assertion_value,
    assertionValueIRI AS assertion_value_iri,
    NULLIF(assertionValueNumeric, '')::NUMERIC AS assertion_value_numeric,
    assertionUnit AS assertion_unit,
    assertionUnitIRI AS assertion_unit_iri,
    assertionUnitVocabulary AS assertion_unit_vocabulary,
    assertionProtocol AS assertion_protocol,
    assertionProtocolID AS assertion_protocol_id
FROM input_event_assertion
);
-- n = 1619


-- Fill the protocol table.
INSERT INTO protocol (
    protocol_id,
    protocol_type,
    protocol_name,
    protocol_description,
    protocol_citation
)
(SELECT
    protocolID AS protocol_id,
    protocolType AS protocol_type,
    protocolName AS protocol_name,
    protocolDescription AS protocol_description,
    protocolCitation AS protocol_citation
FROM input_protocol
);
-- n = 6

-- Fill the survey table.
INSERT INTO survey (
    survey_id,
    event_id,
    site_count,
    site_nesting_description,
    verbatim_site_descriptions,
    verbatim_site_names,
    event_duration_unit,
    is_absence_reported,
    are_non_target_taxa_fully_reported,
    compilation_types,
    inventory_types,
    protocol_names,
    protocol_references,
    is_least_specific_target_category_quantity_inclusive,
    sampling_performed_by,
    sampling_performed_by_id,
    is_sampling_effort_reported,
    sampling_effort_protocol,
    sampling_effort_value,
    sampling_effort_unit
)
(SELECT
    surveyID AS survey_id,
    eventID AS event_id,
    NULLIF(siteCount, '')::SMALLINT AS site_count,
    siteNestingDescription AS site_nesting_description,
    verbatimSiteDescriptions AS verbatim_site_descriptions,
    verbatimSiteNames AS verbatim_site_names,
    eventDurationUnit AS event_duration_unit,
    NULLIF(isAbsenceReported, '')::BOOLEAN AS is_absence_reported,
    NULLIF(areNonTargetTaxaFullyReported, '')::BOOLEAN AS are_non_target_taxa_fully_reported,
    compilationType as compilation_types,
    inventoryTypes AS inventory_types,
    protocolNames AS protocol_names,
    protocolReferences AS protocol_references,
    NULLIF(isLeastSpecificTargetCategoryQuantityInclusive, '')::BOOLEAN AS is_least_specific_target_category_quantity_inclusive,
    samplingPerformedBy AS sampling_performed_by,
    samplingPerformedByID AS sampling_performed_by_id,
    NULLIF(isSamplingEffortReported, '')::BOOLEAN AS is_sampling_effort_reported,
    samplingEffortProtocol AS sampling_effort_protocol,
    NULLIF(samplingEffortValue, '')::NUMERIC AS sampling_effort_value,
    samplingEffortUnit AS sampling_effort_unit
FROM input_survey
);
-- n = 250

-- Fill the survey_protocol table.
INSERT INTO survey_protocol (
    survey_id,
    protocol_id
)
(SELECT
    surveyID AS event_id,
    protocolID AS protocol_id
FROM input_survey_protocol
);
-- n = 250

-- Fill the survey_target table.
INSERT INTO survey_target (
    survey_target_id,
    survey_id,
    survey_target_type,
    survey_target_value,
    survey_target_value_iri,
    survey_target_unit,
    survey_target_unit_iri
)
(SELECT
    surveyTargetID AS survey_target_id,
    surveyID AS survey_id,
    surveyTargetType AS survey_target_type,
    surveyTargetValue AS survey_target_value,
    surveyTargetValueIRI AS survey_target_value_iri,
    surveyTargetUnit AS survey_target_unit,
    surveyTargetUnitIRI AS survey_target_unit_iri
FROM input_survey_target
);
-- n = 10750