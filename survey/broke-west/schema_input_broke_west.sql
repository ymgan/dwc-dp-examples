---
-- Schema for input data to be mapped to dwc-dp publishing model.
--

CREATE TABLE input_agent (
  agentID TEXT PRIMARY KEY,
  agentType TEXT NOT NULL,
  preferredAgentName TEXT
);

CREATE TABLE input_agent_agent_role (
  agentID TEXT NOT NULL,
-- missing   related_agent_id TEXT NOT NULL,
  agentRole TEXT NOT NULL
);

CREATE TABLE input_agent_identifier (
  identifier TEXT NOT NULL,
  agentID TEXT NOT NULL,
  identifierType TEXT NOT NULL,
  identifierLanguage TEXT
);

CREATE TABLE input_event_agent_role (
  eventID TEXT NOT NULL,
  agentID TEXT NOT NULL,
  agentRole TEXT NOT NULL
);

CREATE TABLE input_event_assertion (
  assertionID TEXT PRIMARY KEY,
  eventID TEXT NOT NULL,
  assertionType TEXT NOT NULL,
  assertionTypeIRI TEXT,
  assertionTypeVocabulary TEXT,
  assertionValue TEXT,
  assertionValueNumeric TEXT,
  assertionValueIRI TEXT,
  assertionUnit TEXT,
  assertionUnitIRI TEXT,
  assertionUnitVocabulary TEXT,
  assertionProtocol TEXT,
  assertionProtocolID TEXT
);

CREATE TABLE input_event_protocol (
  eventID TEXT NOT NULL,
  protocolID TEXT NOT NULL
);

CREATE TABLE input_event (
  eventID TEXT PRIMARY KEY,
  parentEventID TEXT,
  eventType TEXT NOT NULL,
  preferredEventName TEXT,
  eventConductedBy TEXT,
  eventConductedByID TEXT,
  samplingProtocol TEXT,
  samplingEffort TEXT,
  sampleSizeValue TEXT,
  sampleSizeUnit TEXT,
  eventDate TEXT,
  year SMALLINT,
  month SMALLINT CHECK (month BETWEEN 1 AND 12),
  day SMALLINT CHECK (day BETWEEN 1 and 31), 
  countryCode CHAR(2),
  decimalLatitude TEXT,
  decimalLongitude TEXT,
  geodeticDatum TEXT,
  footprintWKT TEXT,
  footprintSRS TEXT,
  waterBody TEXT,
  locationID TEXT,
  minimumDepthInMeters NUMERIC CHECK (minimumDepthInMeters BETWEEN 0 AND 11000),
  maximumDepthInMeters NUMERIC CHECK (maximumDepthInMeters BETWEEN 0 AND 11000),
  verbatimLocality TEXT,
  eventRemarks TEXT,
  eventCitation TEXT
);

CREATE TABLE input_identification_agent_role (
  identificationID TEXT NOT NULL,
  agentID TEXT NOT NULL,
  agentRole TEXT NOT NULL
);

CREATE TABLE input_identification (
  identificationID TEXT PRIMARY KEY,
  identificationBasedOnMaterialEntityID TEXT,
  identificationType TEXT,
  identificationTypeIRI TEXT,
  verbatimIdentification TEXT,
  identifiedBy TEXT,
  identifiedByID TEXT,
  identificationReferences TEXT,
  identificationRemarks TEXT,
  taxonID TEXT,
  kingdom TEXT,
  scientificName TEXT,
  taxonRank TEXT
);

-- NOTE: measurmentValue is not a DwC-DP term
CREATE TABLE input_material_assertion (
  assertionID TEXT PRIMARY KEY,
  materialEntityID TEXT,
  assertionType TEXT NOT NULL,
  assertionTypeIRI TEXT,
  measurementValue TEXT,
  assertionUnit TEXT,
  assertionUnitIRI TEXT,
  assertionValue TEXT,
  assertionValueNumeric TEXT
);

CREATE TABLE input_material_media (
  mediaID TEXT,
  materialEntityID TEXT,
  mediaSubjectCategory TEXT
);

CREATE TABLE input_material (
  materialEntityID TEXT PRIMARY KEY,
  eventID TEXT,
  materialEntityType TEXT NOT NULL,
  preparations TEXT,
  disposition TEXT,
  collectedBy TEXT,
  collectedByID TEXT,
  identifiedBy TEXT,
  identifiedByID TEXT,
  verbatimIdentification TEXT,
  scientificName TEXT,
  taxonID TEXT,
  kingdom TEXT,
  taxonRank TEXT,
  identificationRemarks TEXT,
  materialEntityRemarks TEXT,
  derivedFromMaterialEntityID TEXT,
  derivationType TEXT,
  partOfMaterialEntityID TEXT
);

-- NOTE: filename is not in DwC-DP
-- NOTE: The structure of this media file is very different from the DwC-DP media 
-- structure. It looks like a hydrid with material.
CREATE TABLE input_media (
  mediaID TEXT PRIMARY KEY,
  filename TEXT,
  accessURI TEXT,
  mediaType TEXT,
  materialEntityID TEXT,
  format TEXT,
  rights TEXT,
  creator TEXT,
  creatorID TEXT,
  mediaLanguage TEXT,
  eventID TEXT,
  materialEntityType TEXT,
  preparations TEXT,
  disposition TEXT,
  collectedBy TEXT,
  collectedByID TEXT,
  identifiedBy TEXT,
  identifiedByID TEXT,
  verbatimIdentification TEXT,
  scientificName TEXT,
  taxonID TEXT,
  kingdom TEXT,
  taxonRank TEXT,
  identificationRemarks TEXT,
  materialEntityRemarks TEXT,
  derivedFromMaterialEntityID TEXT,
  derivationType TEXT,
  partOfMaterialEntityID TEXT,
  mediaDescription TEXT
);

CREATE TABLE input_occurrence (
  occurrenceID TEXT PRIMARY KEY,
  eventID TEXT,
  recordedBy TEXT,
  recordedByID TEXT,
  identifiedBy TEXT,
  identifiedByID TEXT,
  verbatimIdentification TEXT,
  scientificName TEXT,
  taxonID TEXT,
  taxonRank TEXT,
  kingdom TEXT,
  lifeStage TEXT,
  organismQuantityType TEXT,
  organismQuantity TEXT
);

CREATE TABLE input_protocol (
  protocolID TEXT PRIMARY KEY,
  protocolType TEXT,
  protocolName TEXT,
  protocolCitation TEXT,
  protocolDescription TEXT
);

CREATE TABLE input_survey_agent_role (
  surveyID TEXT NOT NULL,
  agentID TEXT NOT NULL,
  agentRole TEXT NOT NULL
);

CREATE TABLE input_survey_protocol (
  surveyID TEXT NOT NULL,
  protocolID TEXT NOT NULL
);

CREATE TABLE input_survey_target (
  surveyTargetID TEXT NOT NULL,
  surveyID TEXT NOT NULL,
  surveyTargetType TEXT NOT NULL,
  surveyTargetValue TEXT,
  surveyTargetValueIRI TEXT,
  surveyTargetUnit TEXT,
  surveyTargetUnitIRI TEXT
);

-- NOTE: The scopes are no longer part of Survey
-- NOTE: netSize is not part of Survey
CREATE TABLE input_survey (
  eventID TEXT NOT NULL,
  samplingProtocol TEXT,
  samplingPerformedBy TEXT,
  samplingPerformedByID TEXT,
  siteCount TEXT,
  siteNestDescription TEXT,
  verbatimSiteNames TEXT,
  eventDurationUnit TEXT,
  targetHabitatScope TEXT,
  excludedHabitatScope TEXT,
  inventoryTypes TEXT,
  compilationType TEXT,
  protocolNames TEXT,
  protocolReferences TEXT,
  protocolDescription TEXT,
  isAbsenceReported TEXT,
  isSamplingEffortReported TEXT,
  samplingEffortValue TEXT,
  samplingEffortUnit TEXT,
  isTaxonomicScopeFullyReported TEXT,
  isLeastSpecificTargetCategoryQuantityInclusive TEXT,
  samplingEffortProtocol TEXT,
  areNonTargetTaxaFullyReported TEXT,
  netSize TEXT,
  surveyID TEXT PRIMARY KEY
);
