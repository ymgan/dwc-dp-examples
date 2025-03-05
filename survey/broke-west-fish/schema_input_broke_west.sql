---
-- Schema for input data to be mapped to dwc-dp publishing model.
--

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

CREATE TABLE input_agent (
  agentID TEXT PRIMARY KEY,
  agentType TEXT NOT NULL,
  preferredAgentName TEXT
);

CREATE TABLE input_event_assertion (
  assertionID TEXT PRIMARY KEY,
  eventID TEXT NOT NULL,
  assertionType TEXT NOT NULL,
  assertionTypeIRI TEXT,
  assertionTypeVocabulary TEXT,
  assertionValue TEXT,
  assertionValueIRI TEXT,
  assertionValueNumeric TEXT,
  assertionUnit TEXT,
  assertionUnitIRI TEXT,
  assertionUnitVocabulary TEXT,
  assertionProtocol TEXT,
  assertionProtocolID TEXT
);

CREATE TABLE input_event (
  eventID TEXT PRIMARY KEY,
  parentEventID TEXT,
  preferredEventName TEXT,
  eventType TEXT NOT NULL,
  eventConductedBy TEXT,
  eventConductedByID TEXT,
  eventDate TEXT,
  year SMALLINT,
  month SMALLINT CHECK (month BETWEEN 1 AND 12),
  day SMALLINT CHECK (day BETWEEN 1 and 31), 
  verbatimLocality TEXT,
  sampleSizeValue TEXT,
  sampleSizeUnit TEXT,
  eventCitation TEXT,
  eventRemarks TEXT,
  locationID TEXT,
  waterBody TEXT,
  countryCode CHAR(2),
  minimumDepthInMeters NUMERIC CHECK (minimumDepthInMeters BETWEEN 0 AND 11000),
  maximumDepthInMeters NUMERIC CHECK (maximumDepthInMeters BETWEEN 0 AND 11000),
  decimalLatitude TEXT,
  decimalLongitude TEXT,
  geodeticDatum TEXT,
  footprintWKT TEXT,
  footprintSRS TEXT
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

CREATE TABLE input_material_assertion (
  assertionID TEXT PRIMARY KEY,
  materialEntityID TEXT,
  assertionType TEXT NOT NULL,
  assertionTypeIRI TEXT,
  assertionValue TEXT,
  assertionValueIRI TEXT,
  assertionValueNumeric TEXT,
  assertionUnit TEXT,
  assertionUnitIRI TEXT
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
  collectedBy TEXT,
  collectedByID TEXT,
  preparations TEXT,
  disposition TEXT,
  materialEntityRemarks TEXT,
  derivedFromMaterialEntityID TEXT,
  derivationType TEXT,
  partOfMaterialEntityID TEXT,
  verbatimIdentification TEXT,
  identifiedBy TEXT,
  identifiedByID TEXT,
  identificationRemarks TEXT,
  taxonID TEXT,
  kingdom TEXT,
  scientificName TEXT,
  taxonRank TEXT
);

CREATE TABLE input_media (
  mediaID TEXT PRIMARY KEY,
  mediaType TEXT,
  accessURI TEXT,
  format TEXT,
  rights TEXT,
  creator TEXT,
  creatorID TEXT,
  mediaLanguage TEXT,
  mediaDescription TEXT
);

CREATE TABLE input_occurrence (
  occurrenceID TEXT PRIMARY KEY,
  eventID TEXT,
  recordedBy TEXT,
  recordedByID TEXT,
  organismQuantity TEXT,
  organismQuantityType TEXT,
  lifeStage TEXT,
  occurrenceStatus TEXT,
  verbatimIdentification TEXT,
  identifiedBy TEXT,
  identifiedByID TEXT,
  taxonID TEXT,
  kingdom TEXT,
  scientificName TEXT,
  taxonRank TEXT
);

CREATE TABLE input_protocol (
  protocolID TEXT PRIMARY KEY,
  protocolType TEXT,
  protocolName TEXT,
  protocolDescription TEXT,
  protocolCitation TEXT
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
  surveyID TEXT PRIMARY KEY,
  eventID TEXT NOT NULL,
  siteCount TEXT,
  siteNestingDescription TEXT,
  verbatimSiteDescriptions TEXT,
  verbatimSiteNames TEXT,
  eventDurationUnit TEXT,
  isAbsenceReported TEXT,
  areNonTargetTaxaFullyReported TEXT,
  compilationType TEXT,
  inventoryTypes TEXT,
  protocolNames TEXT,
  protocolReferences TEXT,
  isLeastSpecificTargetCategoryQuantityInclusive TEXT,
  samplingPerformedBy TEXT,
  samplingPerformedByID TEXT,
  isSamplingEffortReported TEXT,
  samplingEffortProtocol TEXT,
  samplingEffortValue TEXT,
  samplingEffortUnit TEXT
);
