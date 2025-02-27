---
-- Schema for input data to be mapped to dwc-dp publishing model.
--

CREATE TABLE input_agent (
  agent_id TEXT PRIMARY KEY,
  agent_type TEXT NOT NULL,
  preferred_agent_name TEXT
);

CREATE TABLE input_collection (
  collection_id TEXT PRIMARY KEY,
  collection_type TEXT,
  collection_code TEXT,
  institution_code TEXT,
  grscicoll_id TEXT
);

CREATE TABLE input_event (
  eventID TEXT PRIMARY KEY,
  fieldNumber TEXT,
  eventType TEXT NOT NULL,
  eventConductedBy TEXT,
  eventConductedByID TEXT,
  eventDate TEXT,
  verbatimEventDate TEXT,
  locality TEXT,
  habitat TEXT,
  continent TEXT,
  verbatimElevation TEXT,
  country TEXT,
  countryCode CHAR(2),
  decimalLatitude TEXT,
  decimalLongitude TEXT,
  geodeticDatum TEXT,
  eventRemarks TEXT
);

CREATE TABLE input_genetic_sequence (
  geneticSequenceID TEXT PRIMARY KEY,
  eventID TEXT,
  derivedFromMaterialEntityID TEXT,
  geneticSequenceType TEXT,
  geneticSequence TEXT NOT NULL,
  geneticSequenceRemarks TEXT
);

CREATE TABLE input_identification (
  identificationID TEXT PRIMARY KEY,
  identificationBasedOnMaterialEntityID TEXT,
  taxonFormula TEXT DEFAULT 'A' NOT NULL,
  typeStatus TEXT,
  identifiedBy TEXT,
  dateIdentified TEXT,
  scientificName TEXT NOT NULL,
  taxonRank TEXT,
  isAcceptedIdentification BOOLEAN DEFAULT TRUE
);

CREATE TABLE input_material_assertion (
  assertionID TEXT PRIMARY KEY,
  materialEntityID TEXT,
  assertionType TEXT NOT NULL,
  assertionTypeIRI TEXT,
  assertionTypeVocabulary TEXT,
  assertionMadeDate TEXT,
  assertionValue TEXT,
  assertionValueNumeric TEXT,
  assertionUnit TEXT,
  assertionRemarks TEXT
);

CREATE TABLE input_material_identifier (
  identifier TEXT NOT NULL,
  materialEntityID TEXT,
  identifier_type TEXT
);

CREATE TABLE input_material_media (
  mediaID TEXT,
  materialEntityID TEXT,
  mediaSubjectCategory TEXT
);

CREATE TABLE input_material (
  materialEntityID TEXT PRIMARY KEY,
  eventID TEXT,
  evidenceForOccurrenceID TEXT,
  materialEntityType TEXT NOT NULL,
  preparations TEXT,
  institutionCode TEXT,
  institutionID TEXT, 
  ownerInstitutionCode TEXT,
  owner_institutionID TEXT,
  collectionCode TEXT,
  collectionID TEXT,
  catalogNumber TEXT,
  recordNumber TEXT,
  materialEntityRemarks TEXT,
  derivedFromMaterialEntityID TEXT,
  derivationType TEXT,
  derivationEventID TEXT
);

CREATE TABLE input_media (
  mediaID TEXT PRIMARY KEY,
  materialEntityID TEXT,
  occurrenceID TEXT,
  mediaSubjectCategory TEXT,
  mediaType TEXT,
  accessURI TEXT,
  WebStatement TEXT,
  format TEXT,
  rights TEXT,
  owner TEXT,
  creator TEXT
);

CREATE TABLE input_occurrence_media (
  mediaID TEXT,
  occurrenceID TEXT,
  mediaSubjectCategory TEXT
);

CREATE TABLE input_occurrence (
  occurrenceID TEXT PRIMARY KEY,
  eventID TEXT,
  organismID TEXT,
  recordedBy TEXT,
  recordedByID TEXT,
  sex TEXT,
  occurrenceStatus TEXT,
  occurrenceRemarks TEXT
);
