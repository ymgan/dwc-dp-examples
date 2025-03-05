---
-- Schema for test mapping of NEON_fish dataset to Humboldt Extension in a Darwin Core 
-- Archive version 1 to be used for additional input data to be mapped to dwca_v2 
-- publishing model.
-- Source: https://github.com/sunray1/NEONFishtoHumboldt
--

CREATE TABLE dwcav1_event (
  eventID TEXT PRIMARY KEY,
  parentEventID TEXT,
  eventType TEXT,
  eventDate TEXT,
  eventRemarks TEXT,
  habitat TEXT,
  protocolNames TEXT,
  eventTime TEXT,
  eventDurationValue TEXT,
  eventDurationUnit TEXT,
  protocolReferences TEXT,
  samplingPerformedBy TEXT,
  reportedExtremeConditions TEXT,
  identifiedBy TEXT,
  decimalLatitude TEXT,
  decimalLongitude TEXT,
  coordinateUncertaintyinMeters TEXT,
  geodeticDatum TEXT,
  minimumElevationInMeters TEXT,
  maximumElevationInMeters TEXT,
  siteCount TEXT,
  siteNestingDescription TEXT,
  verbatimSiteDescriptions TEXT,
  continent TEXT,
  country TEXT,
  stateProvince TEXT,
  county TEXT,
  locality TEXT,
  verbatimSiteNames TEXT,
  reportedWeather TEXT,
  targetTaxonomicScope TEXT,
  taxonCompletenessReported TEXT,
  taxonCompletenessProtocols TEXT,
  isTaxonomicScopeFullyReported TEXT,
  isAbsenceReported TEXT,
  hasNonTargetTaxa TEXT,
  nonTargetTaxa TEXT,
  areNonTargetTaxaFullyReported TEXT,
  targetLifeStageScope TEXT,
  excludedLifeStageScope TEXT,
  isLifeStageScopeFullyReported TEXT,
  verbatimTargetScope TEXT,
  compilationTypes TEXT,
  protocolDescriptions TEXT,
  isAbundanceReported TEXT,
  isAbundanceCapReported TEXT,
  isLeastSpecificTargetCategoryQuantityInclusive TEXT,
  hasVouchers TEXT,
  voucherInstitutions TEXT,
  hasMaterialSamples TEXT,
  materialSampleTypes TEXT,
  isSamplingEffortReported TEXT,
  samplingEffortProtocol TEXT
);
CREATE INDEX idx_dwcav1_event_id ON dwcav1_event(eventID);

CREATE TABLE dwcav1_dna_derived_data (
  samp_name TEXT PRIMARY KEY,
  occurrenceID TEXT,
  samp_collec_method TEXT,
  target_gene TEXT,
  url TEXT,
  DNA_sequence TEXT,
  pcr_primer_name_forward TEXT,
  pcr_primer_name_reverse TEXT
);
CREATE INDEX idx_dwcav1_dna_id ON dwcav1_dna_derived_data(samp_name);
