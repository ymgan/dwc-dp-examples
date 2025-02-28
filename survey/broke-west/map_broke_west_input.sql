-- Fill the event table.
INSERT INTO event (
    event_id, 
    parent_event_id, 
    event_type, 
    preferred_event_name,
    event_conducted_by, 
    event_conducted_by_id,
--    sampling_protocol,
--    sampling_effort,
    sample_size_value,
    sample_size_unit,
    event_date, 
    year,
    month,
    day,
    country_code, 
    decimal_latitude, 
    decimal_longitude, 
    geodetic_datum, 
    footprint_wkt,
    footprint_srs,
    water_body,
    location_id,
    minimum_depth_in_meters,
    maximum_depth_in_meters,
    verbatim_locality, 
    event_remarks,
    event_citation
)
(SELECT
    eventID AS event_id,
    parentEventID AS parent_event_id,
    eventType AS event_type, 
    preferredEventName AS preferred_event_name,
    eventConductedBy AS event_conducted_by, 
    eventConductedByID AS event_conducted_by_id, 
--    samplingProtocol AS sampling_protocol,
--    samplingEffort AS sampling_effort,
    sampleSizeValue AS sample_size_value,
    sampleSizeUnit AS sample_size_unit,
    eventDate AS event_date, 
    year,
    month,
    day,
    countryCode AS countryCode, 
    NULLIF(decimalLatitude, '')::NUMERIC AS decimal_latitude,
    NULLIF(decimalLongitude, '')::NUMERIC AS decimal_longitude,
    geodeticDatum AS geodetic_datum, 
    footprintWKT AS footprint_wkt,
    footprintSRS AS footprint_srs,
    waterBody AS water_body,
    locationID AS location_id,
    minimumDepthInMeters AS minimum_depth_in_meters,
    maximumDepthInMeters AS maximum_depth_in_meters,
    verbatimLocality AS verbatim_locality,
    eventRemarks AS event_remarks,
    eventCitation AS event_citation
FROM input_event
);
-- n = 376

-- Fill the material table.
INSERT INTO material (
    material_entity_id,
    event_id,
    material_entity_type,
    preparations,
    disposition,
    collected_by,
    collected_by_id,
    identified_by,
    identified_by_id,
    verbatim_identification,
    scientific_name,
    taxon_id,
    kingdom,
    taxon_rank,
    identification_remarks,
    material_entity_remarks,
    derived_from_material_entity_id,
    derivation_type,
    part_of_material_entity_id
)
(
SELECT 
    materialEntityID AS material_entity_id,
    eventID AS event_id,
    materialEntityType AS material_entity_type,
    preparations,
    disposition,
    collectedBy AS collected_by,
    collectedByID AS collected_by_id,
    identifiedBy AS identified_by,
    identifiedByID AS identified_by_id,
    verbatimIdentification AS verbatim_identification,
    scientificName AS scientific_name,
    taxonID AS taxon_id,
    kingdom,
    taxonRank AS taxon_rank,
    identificationRemarks AS identification_remarks,
    materialEntityRemarks AS material_entity_remarks,
    derivedFromMaterialEntityID AS derived_from_material_entity_id,
    derivationType AS derivation_type,
    partOfMaterialEntityID as part_of_material_entity_id
FROM input_material
);
-- n = 561

-- Fill the occurrence table.
INSERT INTO occurrence (
    occurrence_id,
    event_id,
    recorded_by,
    recorded_by_id,
    identified_by,
    identified_by_id,
    verbatim_identification,
    scientific_name,
    taxon_id,
    taxon_rank,
    kingdom,
    life_stage,
    organism_quantity_type,
    organism_quantity
)
(SELECT
    occurrenceID AS occurrence_id,
    eventID AS event_id,
    recordedBy AS recorded_by,
    recordedByID AS recorded_by_id,
    identifiedBy AS identified_by,
    identifiedByID AS identified_by_id,
    verbatimIdentification AS verbatim_identification,
    scientificName AS scientific_name,
    taxonID AS taxon_id,
    taxonRank AS taxon_rank,
    kingdom,
    lifeStage AS life_stage,
    organismQuantityType AS organism_quantity_type,
    organismQuantity AS organism_quantity
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
-- n = 2

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
    assertion_unit,
    assertion_unit_iri,
    assertion_value,
    assertion_value_numeric
)
(SELECT
    assertionID AS assertion_id,
    materialEntityID AS material_entity_id,
    assertionType AS assertion_type,
    assertionTypeIRI AS assertion_type_iri,
    assertionUnit AS assertion_unit,
    assertionUnitIRI AS assertion_unit_iri,
    assertionValue AS assertion_value,
    NULLIF(assertionValueNumeric, '')::NUMERIC AS assertion_value_numeric
FROM input_material_assertion
);
-- n = 1013

-- Fill the media table.
INSERT INTO media (
    media_id,
    access_uri,
    media_type,
    format,
    rights,
    creator,
    creator_id,
    media_language,
    media_description
)
(SELECT
    mediaID AS media_id,
    accessURI AS access_uri,
    mediaType AS media_type,
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

-- Fill the event_agent_role table.
/* Note: The first row of event_agent_role creates a foreign key violation because the agentID 'https://orcid.org/0000-0003-1336-5554' can't be found in the agent table. 
INSERT INTO event_agent_role (
    event_id,
    agent_id,
    agent_role
)
(SELECT
    eventID AS event_id,
    agentID AS agent_id,
    agentRole AS agent_role
FROM input_event_agent_role
);
-- n = 
*/

-- Fill the event_assertion table.
/* Note: event_assertion doesn't have assertionIDs. That won't validate.
INSERT INTO event_assertion (
    assertion_id,
    event_id,
    assertion_type,
    assertion_type_iri,
    assertion_type_vocabulary,
    assertion_value,
    assertion_value_numeric,
    assertion_value_iri,
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
    NULLIF(assertionValueNumeric, '')::NUMERIC AS assertion_value_numeric
    assertionValueIRI AS assertion_value_iri,
    assertionUnit AS assertion_unit,
    assertionUnitIRI AS assertion_unit_iri,
    assertionUnitVocabulary AS assertion_unit_vocabulary,
    assertionProtocol AS assertion_protocol,
    assertionProtocolID AS assertion_protocol_id
FROM input_event_assertion
);
-- n = 
*/

-- Fill the protocol table.
INSERT INTO protocol (
    protocol_id,
    protocol_type,
    protocol_name,
    protocol_citation,
    protocol_description
)
(SELECT
    protocolID AS protocol_id,
    protocolType AS protocol_type,
    protocolName AS protocol_name,
    protocolCitation AS protocol_citation,
    protocolDescription AS protocol_description
FROM input_protocol
);
-- n = 6

-- Fill the event_protocol table.
INSERT INTO event_protocol (
    event_id,
    protocol_id
)
(SELECT
    eventID AS event_id,
    protocolID AS protocol_id
FROM input_event_protocol
);
-- n = 125

-- Fill the identification_agent_role table.
INSERT INTO identification_agent_role (
    identification_id,
    agent_id,
    agent_role
)
(SELECT
    identificationID AS identification_id,
    agentID AS agent_id,
    agentRole AS agent_role
FROM input_identification_agent_role
);
-- n = 561

-- Fill the survey table.
INSERT INTO survey (
    event_id,
    sampling_performed_by,
    sampling_performed_by_id,
    site_count,
    site_nesting_description,
    verbatim_site_names,
    event_duration_unit,
    inventory_types,
    compilation_types,
    protocol_names,
    protocol_references,
    protocol_descriptions,
    is_absence_reported,
    is_sampling_effort_reported,
    sampling_effort_value,
    sampling_effort_unit,
    is_taxonomic_scope_fully_reported,
    is_least_specific_target_category_quantity_inclusive,
    sampling_effort_protocol,
    are_non_target_taxa_fully_reported,
    survey_id
)
(SELECT
    eventID AS event_id,
--    samplingProtocol,
    samplingPerformedBy AS sampling_performed_by,
    samplingPerformedByID AS sampling_performed_by_id,
    NULLIF(siteCount, '')::SMALLINT AS site_count,
    siteNestDescription AS site_nesting_description,
    verbatimSiteNames AS verbatim_site_names,
    eventDurationUnit AS event_duration_unit,
--    targetHabitatScope,
--    excludedHabitatScope,
    inventoryTypes AS inventory_types,
    compilationType as compilation_types,
    protocolNames AS protocol_names,
    protocolReferences AS protocol_references,
    protocolDescription AS protocol_descriptions,
    NULLIF(isAbsenceReported, '')::BOOLEAN AS is_absence_reported,
    NULLIF(isSamplingEffortReported, '')::BOOLEAN AS is_sampling_effort_reported,
    NULLIF(samplingEffortValue, '')::NUMERIC AS sampling_effort_value,
    samplingEffortUnit AS sampling_effort_unit,
    NULLIF(isTaxonomicScopeFullyReported, '')::BOOLEAN AS is_taxonomic_scope_fully_reported,
    NULLIF(isLeastSpecificTargetCategoryQuantityInclusive, '')::BOOLEAN AS is_least_specific_target_category_quantity_inclusive,
    samplingEffortProtocol AS sampling_effort_protocol,
    NULLIF(areNonTargetTaxaFullyReported, '')::BOOLEAN AS are_non_target_taxa_fully_reported,
--    netSize,
    surveyID AS survey_id
FROM input_survey
);
-- n = 250

-- Fill the survey_agent_role table.
INSERT INTO survey_agent_role (
    survey_id,
    agent_id,
    agent_role
)
(SELECT
    surveyID AS survey_id,
    agentID AS agent_id,
    agentRole AS agent_role
FROM input_survey_agent_role
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

