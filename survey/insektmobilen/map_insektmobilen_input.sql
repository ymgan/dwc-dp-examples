-- Fill the event table.
INSERT INTO event (
    event_id,
    parent_event_id,
    event_category,
    event_type,
    dataset_name,
    event_conducted_by_id,
    event_date,
    habitat,
    event_effort,
    event_remarks,
    location_id,
    country,
    country_code,
    locality,
    decimal_latitude,
    decimal_longitude,
    geodetic_datum,
    coordinate_uncertainty_in_meters,
    footprint_wkt,
    footprint_srs,
    preferred_spatial_representation,
    information_withheld
)
(SELECT
    eventid AS event_id,
    parenteventid AS parent_event_id,
    'Survey' AS event_category,
    'check me' AS event_type,
    datasetname as dataset_name,
    eventconductedbyid AS event_conducted_by_id, 
    eventdate AS event_date, 
    habitat AS habitat,
    eventeffort AS event_effort,
    eventremarks AS event_remarks,
    locationid AS location_id,
    country AS country,
    countrycode AS country_code,
    locality AS locality,
    decimallatitude AS decimal_latitude,
    decimallongitude AS decimal_longitude,
    'epsg:4326' AS geodetic_datum,
    NULLIF(replace(coordinateuncertaintyinmeters,'"',''), '')::NUMERIC AS coordinate_uncertainty_in_meters,
    footprintwkt AS footprint_wkt,
    'epsg:4326' AS footprint_srs,
    preferredspatialrepresentation AS preferred_spatial_representation,
    informationwithheld AS information_withheld
FROM eventTable
LIMIT 1
);
-- n = 

-- Fill the media table.
INSERT INTO media (
    media_id,
    media_type,
    access_uri,
    format,
    rights,
    owner,
    description
)
(SELECT
    mediaid AS media_id,
    mediatype AS media_type,
    accessuri AS access_uri,
    format AS format,
    rights AS rights,
    owner AS owner,
    mediadescription AS description
FROM mediaTable
);
-- n = 1027

-- Fill the event_media table.
INSERT INTO event_media (
    media_id,
    event_id,
    media_subject_category
)
(SELECT
    mediaID AS media_id,
    eventID AS event_id,
    mediaSubjectCategory AS media_subject_category
FROM eventMediaTable
);
-- n = 
	
-- Fill the material table.
INSERT INTO material (
    material_entity_id,
    event_id,
    material_category,
    material_entity_type,
    institution_code,
    institution_id,
    owner_institution_code,
    owner_institution_id,
    collection_code,
    catalog_number,
    preparations,
    disposition,
    derived_from_material_entity_id
)
(
SELECT 
    materialentityid AS material_entity_id,
    eventid AS event_id,
    materialcategory AS material_category,
    materialentitytype AS material_entity_type,
    institutioncode AS institution_code,
    institutionid AS institution_id,
    ownerinstitutioncode AS owner_institution_code,
    ownerinstitutionid AS owner_institution_id,
    collectioncode AS collection_code,
    catalognumber AS catalog_number,
    preparations,
    disposition,
    derivedfrommaterialentityid AS derived_from_material_entity_id
FROM materialTable
);
-- n = 

-- Fill the occurrence table.
INSERT INTO occurrence (
    occurrence_id,
    event_id,
    life_stage,
    vitality,
    occurrence_status,
    higher_classification_name,
    higher_classification_rank,
    scientific_name,
    taxon_rank,
    organism_quantity,
    organism_quantity_type,
    survey_target_id
)
(SELECT
    occurrenceid AS occurrence_id,
    eventid AS event_id,
    lifestage AS life_stage,
    vitality AS vitality,
    NULLIF(occurrencestatus, '')::OCCURRENCE_STATUS AS occurrence_status,
    kingdom AS higher_classification_name,
    'kingdom' AS higher_classification_rank,
    scientificName AS scientific_name,
    taxonRank AS taxon_rank,
    organismquantity AS organism_quantity,
    organismquantitytype AS organism_quantity_type,
    surveytargetid AS survey_target_id
FROM occurrenceTable
);
-- n = 

-- Fill the identification table.
INSERT INTO identification (
    identification_id,
    based_on_nucleotide_sequence_id,
    based_on_material_entity_id,
    identification_type,
    taxon_assignment_method,
    higher_classification_name,
    scientific_name,
    taxon_rank
)
(SELECT
    identificationid AS identification_id,
    basedonnucleotidesequenceid AS based_on_nucleotide_sequence_id,
    basedonmaterialentityid AS based_on_material_entity_id,
    identificationtype AS identification_type,
    taxonassignmentmethod AS taxon_assignment_method,
    kingdom AS higher_classification_name,
    scientificname AS scientific_name,
    taxonrank AS taxon_rank
FROM identificationTable
);
-- n = 

-- Fill the material_assertion table.
INSERT INTO material_assertion (
    assertion_id,
    material_entity_id,
    assertion_type,
    assertion_value_numeric,
    assertion_unit
)
(SELECT
    assertionid AS assertion_id,
    materialentityid AS material_entity_id,
    assertiontype AS assertion_type,
    assertionvaluenumeric AS assertion_value_numeric,
    assertionunit AS assertion_unit
FROM materialAssertionsTable
);
-- n = 

-- Fill the molecular_protocol table.
INSERT INTO molecular_protocol (
    molecular_protocol_id,
    pcr_primer_reference,
    target_gene,
    pcr_primer_forward,
    pcr_primer_reverse,
    pcr_primer_name_forward,
    pcr_primer_name_reverse,
    lib_layout,
    seq_meth,
    sop,
    assay_type
)
(SELECT
  molecularprotocolid AS molecular_protocol_id,
  pcr_primer_reference AS pcr_primer_reference,
  target_gene AS target_gene,
  pcr_primer_forward AS pcr_primer_forward,
  pcr_primer_reverse AS pcr_primer_reverse,
  primer_name_forward AS pcr_primer_name_forward,
  primer_name_reverse AS pcr_primer_name_reverse,
  lib_layout AS lib_layout,
  seq_meth AS seq_meth,
  sop AS sop,
  assaytype AS assay_type
FROM molecularProtocolTable
);
-- n = 3

-- Fill the nucleotide_analysis table.
INSERT INTO nucleotide_analysis (
    nucleotide_analysis_id,
    molecular_protocol_id,
    nucleotide_sequence_id,
    event_id,
    material_entity_id,
    read_count,
    total_read_count
)
(SELECT
    nucleotideanalysisid AS nucleotide_analysis_id,
    molecularprotocolid AS molecular_protocol_id,
    nucleotidesequenceid AS nucleotide_sequence_id,
    eventid AS event_id,
    materialentityid AS material_entity_id,
    readcount AS read_count,
    totalreadcount AS total_read_count
FROM nucleotideAnalysisTable
);

-- Fill the nucleotide_sequence table.
INSERT INTO nucleotide_sequence (
    nucleotide_sequence_id,
    nucleotide_sequence
)
(SELECT
  nucleotidesequenceid AS nucleotide_sequence_id,
  nucleotidesequence AS nucleotide_sequence
FROM nucleotideSequenceTable
);
-- n = 26342

-- Fill the survey table.
INSERT INTO survey (
    survey_id,
    event_id,
    verbatim_site_descriptions,
    verbatim_site_names,
    reported_weather,
    verbatim_target_scope,
    sampling_performed_by_id,
    is_sampling_effort_reported
)
(SELECT
    surveyid AS survey_id,
    eventid AS event_id,
    verbatimsitedescription AS verbatim_site_descriptions,
    verbatimsitenames AS verbatim_site_names,
    reportedweather AS reported_weather,
    verbatimtargetscope AS verbatim_target_scope,
    samplingperformedbyid AS sampling_performed_by_id,
    NULLIF(issamplingeffortreported, '')::BOOLEAN AS is_sampling_effort_reported
FROM surveyTable
);
-- n = 

-- Fill the survey_target table.
INSERT INTO survey_target (
    survey_target_id,
    survey_id,
    survey_target_type,
    survey_target_value
)
(SELECT
    gen_random_uuid() AS survey_target_id,
    surveyid AS survey_id,
    surveytargettype AS survey_target_type,
    surveytargetvalue AS survey_target_value
FROM surveyTargetTable
);
-- n = 3164