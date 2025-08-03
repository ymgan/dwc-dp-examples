---
-- Schema for input data to be mapped to dwc-dp publishing model.
--

CREATE TABLE input_agent (
  agent_id TEXT PRIMARY KEY,
  agent_type TEXT NOT NULL,
  preferred_agent_name TEXT
);

CREATE TABLE input_event (
  eventID TEXT PRIMARY KEY,
  parentEventID TEXT,
  preferredEventName TEXT,
  eventCategory TEXT NOT NULL,
  eventType TEXT,
  eventDate TEXT,
  verbatimElevation TEXT,
  habitat TEXT,
  country TEXT,
  countryCode CHAR(2),
  stateProvince TEXT,
  locality TEXT,
  decimalLatitude TEXT,
  decimalLongitude TEXT
);

CREATE TABLE input_material (
  materialEntityID TEXT PRIMARY KEY,
  eventID TEXT NOT NULL,
  materialCategory TEXT NOT NULL,
  materialEntityType TEXT,
  institutionCode TEXT,
  institutionID TEXT, 
  collectionCode TEXT,
  catalogNumber TEXT,
  preparations TEXT,
  disposition TEXT,
  associatedSequences TEXT,
  evidenceForOccurrenceID TEXT,
  derivedFromMaterialEntityID TEXT,
  derivationType TEXT,
  identifiedBy TEXT,
  dateIdentified TEXT,
  scientificName TEXT,
  taxonRank TEXT
);

CREATE TABLE input_media (
  mediaID TEXT PRIMARY KEY,
  mediaType TEXT,
  subtype TEXT,
  title TEXT,
  rights TEXT,
  Owner TEXT,
  creator TEXT,
  description TEXT,
  CreateDate TEXT,
  accessURI TEXT,
  format TEXT,
  furtherInformationURL TEXT
);

CREATE TABLE input_occurrence_agent_role (
  agentID TEXT NOT NULL,
  occurrenceID TEXT NOT NULL,
  agentRole TEXT NOT NULL
);

CREATE TABLE input_occurrence_media (
  mediaID TEXT NOT NULL,
  occurrenceID TEXT NOT NULL,
  mediaSubjectCategory TEXT,
  physicalSetting TEXT
);

CREATE TABLE input_occurrence (
  occurrenceID TEXT PRIMARY KEY,
  eventID TEXT NOT NULL,
  recordedBy TEXT,
  recordedByID TEXT,
  lifeStage TEXT,
  occurrenceRemarks TEXT,
  identifiedBy TEXT,
  dateIdentified TEXT,
  scientificName TEXT,
  taxonRank TEXT  
);
