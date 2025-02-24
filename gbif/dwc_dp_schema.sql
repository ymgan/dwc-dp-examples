---
-- Database schema for the dwc-dp data publishing model.
-- 

-- ENUMs
CREATE TYPE INCLUDE_OR_EXCLUDE AS ENUM (
  'include',
  'exclude'
);

CREATE TYPE OCCURRENCE_STATUS AS ENUM (
  'present',
  'absent'
);

CREATE TYPE TAXON_COMPLETENESS_REPORTED AS ENUM (
  'not reported',
  'reported complete',
  'reported incomplete'
);

-- Event (https://dwc.tdwg.org/terms/#event)
--   Something that occurs at some location during some time.

CREATE TABLE event (
  event_id TEXT PRIMARY KEY,
  parent_event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE,
  preferred_event_name TEXT,
  event_type TEXT NOT NULL,
  event_type_iri TEXT,
  event_type_vocabulary TEXT,
  dataset_name TEXT,
  datasetID TEXT,
  field_number TEXT,
  event_conducted_by TEXT,
  event_conducted_by_id TEXT,
  event_date TEXT,
  event_time TEXT,
  start_day_of_year SMALLINT CHECK (start_day_of_year BETWEEN 1 AND 366),
  end_day_of_year SMALLINT CHECK (start_day_of_year BETWEEN 1 AND 366),
  year SMALLINT,
  month SMALLINT CHECK (month BETWEEN 1 AND 12),
  day SMALLINT CHECK (day BETWEEN 1 and 31), 
  verbatim_event_date TEXT,
  verbatim_locality TEXT,
  verbatim_elevation TEXT,
  verbatim_depth TEXT,
  verbatim_coordinates TEXT,
  verbatim_latitude TEXT,
  verbatim_longitude TEXT,
  verbatim_coordinate_system TEXT,
  verbatim_srs TEXT,
  georeference_verification_status TEXT,
  habitat TEXT,
  sample_size_value TEXT,
  sample_size_unit TEXT,
  event_effort TEXT,
  field_notes TEXT,
  event_citation TEXT,
  event_remarks TEXT,
  location_id TEXT,
  higher_geography TEXT,
  higher_geography_id TEXT,
  continent TEXT,
  water_body TEXT,
  island_group TEXT,
  island TEXT,
  country TEXT,
  country_code CHAR(2),
  state_province TEXT,
  county TEXT,
  municipality TEXT,
  locality TEXT,
  minimum_elevation_in_meters NUMERIC CHECK (minimum_elevation_in_meters BETWEEN -430 AND 8850),
  maximum_elevation_in_meters NUMERIC CHECK (maximum_elevation_in_meters BETWEEN -430 AND 8850),
  vertical_datum TEXT,
  minimum_depth_in_meters NUMERIC CHECK (minimum_depth_in_meters BETWEEN 0 AND 11000),
  maximum_depth_in_meters NUMERIC CHECK (maximum_depth_in_meters BETWEEN 0 AND 11000),
  minimum_distance_above_surface_in_meters NUMERIC,
  maximum_distance_above_surface_in_meters NUMERIC,
  location_remarks TEXT,
  decimal_latitude NUMERIC CHECK (decimal_latitude BETWEEN -90 AND 90),
  decimal_longitude NUMERIC CHECK (decimal_longitude BETWEEN -180 AND 180),
  geodetic_datum TEXT,
  coordinate_uncertainty_in_meters NUMERIC CHECK (coordinate_uncertainty_in_meters > 0  AND coordinate_uncertainty_in_meters <= 20037509),
  coordinate_precision NUMERIC CHECK (coordinate_precision BETWEEN 0 AND 90),
  point_radius_spatial_fit NUMERIC CHECK (point_radius_spatial_fit = 0 OR point_radius_spatial_fit >= 1),
  footprint_wkt TEXT,
  footprint_srs TEXT,
  footprint_spatial_fit NUMERIC CHECK (footprint_spatial_fit >= 0),
  georeferenced_by TEXT,
  georeferenced_by_id TEXT,
  georeferenced_date TEXT,
  georeference_protocol TEXT,
  georeference_protocol_id TEXT,
  georeference_sources TEXT,
  georeference_remarks TEXT,
  informationWithheld TEXT,
  dataGeneralizations TEXT,
  preferred_spatial_representation TEXT
);
CREATE INDEX ON event(parent_event_id);
CREATE INDEX ON event(event_conducted_by_id);
CREATE INDEX ON event(georeferenced_by_id);
CREATE INDEX ON event(georeference_protocol_id);

-- Occurrence (https://dwc.tdwg.org/terms/#occurrence)
--   The state of a dwc:Organism at some location during some time.

CREATE TABLE occurrence (
  occurrence_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  recorded_by TEXT,
  recorded_by_id TEXT,
  organism_quantity TEXT,
  organism_quantity_type TEXT,
  organism_quantity_type_iri TEXT,
  organism_quantity_type_vocabulary TEXT,
  sex TEXT,
  life_stage TEXT,
  reproductive_condition TEXT,
  caste TEXT,
  behavior TEXT,
  vitality TEXT,
  establishment_means TEXT,
  degree_of_establishment TEXT,
  pathway TEXT,
  occurrence_status OCCURRENCE_STATUS DEFAULT 'present' NOT NULL,
  informationWithheld TEXT,
  dataGeneralizations TEXT,
  occurrence_remarks TEXT,
  organism_id TEXT,
  organism_scope TEXT DEFAULT 'multicellular organism' NOT NULL,
  organism_scope_iri TEXT,
  organism_scope_vocabulary TEXT,
  organism_name TEXT,
  organism_remarks TEXT,
  verbatim_identification TEXT,
  identified_by TEXT,
  identified_by_id TEXT,
  date_identified TEXT,
  identification_references TEXT,
  identification_verification_status TEXT,
  identification_verification_status_iri TEXT,
  identificationVerificationStatusVocabulary TEXT,
  identificationRemarks TEXT,
  taxon_id TEXT,
  kingdom TEXT,
  scientific_name TEXT NOT NULL,
  taxon_rank TEXT,
  taxon_remarks TEXT
);
CREATE INDEX ON occurrence(event_id);

-- Identification (https://dwc.tdwg.org/terms/#identification)
--    A taxonomic determination (i.e., the assignment of dwc:Taxa to dwc:Organisms).

CREATE TABLE identification (
  identification_id TEXT PRIMARY KEY,
  identification_based_on_occurrence_id TEXT,
  identification_based_on_material_entity_id TEXT,
  identification_based_on_genetic_sequence_id TEXT,
  identification_based_on_media_id TEXT,
  identification_type TEXT,
  identification_type_iri TEXT,
  identification_type_vocabulary TEXT,
  verbatim_identification TEXT,
  is_accepted_identification BOOLEAN DEFAULT TRUE,
  taxon_formula TEXT DEFAULT 'A' NOT NULL,
  type_status TEXT,
  type_designation_type TEXT,
  identified_by TEXT,
  identified_by_id TEXT,
  date_identified TEXT,
  identification_references TEXT,
  identification_verification_status TEXT,
  identification_verification_status_iri TEXT,
  identificationVerificationStatusVocabulary TEXT,
  identification_remarks TEXT,
  taxon_id TEXT,
  kingdom TEXT,
  scientific_name TEXT NOT NULL,
  taxon_rank TEXT,
  taxon_remarks TEXT
);
CREATE INDEX ON identification(identification_based_on_occurrence_id);
CREATE INDEX ON identification(identification_based_on_material_entity_id);
CREATE INDEX ON identification(identification_based_on_genetic_sequence_id);
CREATE INDEX ON identification(identification_based_on_media_id);

-- IdentificationTaxon
--    The components and positions of dwc:scientificNames in dwc:Identifications.

CREATE TABLE identification_taxon (
  identification_id TEXT REFERENCES identification ON DELETE CASCADE DEFERRABLE NOT NULL,
  taxon_id TEXT,
  taxon_order SMALLINT CHECK (taxon_order >= 1),
  kingdom TEXT,
  scientific_name TEXT NOT NULL,
  taxon_rank TEXT,
  taxon_remarks TEXT
);

-- Material (https://dwc.tdwg.org/terms/#materialentity)
--  An entity that can be identified, exist for some period of time, and consist in whole or in part of physical matter while it exists.

CREATE TABLE material (
  material_entity_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_type TEXT NOT NULL,
  material_entity_type_iri TEXT,
  material_entity_type_vocabulary TEXT,
  institution_code TEXT,
  institution_id TEXT, 
  owner_institution_code TEXT,
  owner_institution_id TEXT,
  collection_code TEXT,
  collection_id TEXT,
  catalog_number TEXT,
  other_catalog_numbers TEXT,
  collected_by TEXT,
  collected_by_id TEXT,
  record_number TEXT,
  preparations TEXT,
  disposition TEXT,
  verbatim_label TEXT,
  associated_sequences TEXT,
  material_citation TEXT,
  informationWithheld TEXT,
  dataGeneralizations TEXT,
  material_entity_remarks TEXT,
  evidence_for_occurrence_id TEXT,
  derived_from_material_entity_id TEXT,
  derivation_type TEXT,
  derivation_type_iri TEXT,
  derivation_type_vocabulary TEXT,
  part_of_material_entity_id TEXT,
  verbatim_identification TEXT,
  identified_by TEXT,
  identified_by_id TEXT,
  date_identified TEXT,
  identification_references TEXT,
  identification_verification_status TEXT,
  identification_verification_status_iri TEXT,
  identificationVerificationStatusVocabulary TEXT,
  identification_remarks TEXT,
  taxon_id TEXT,
  kingdom TEXT,
  scientific_name TEXT NOT NULL,
  taxon_rank TEXT,
  taxon_remarks TEXT  
);
CREATE INDEX ON material(event_id);
CREATE INDEX ON material(evidence_for_occurrence_id);
CREATE INDEX ON material(derived_from_material_entity_id);
CREATE INDEX ON material(part_of_material_entity_id);

-- Collection (see Latimer Core)
--   A persistent formal repository in which dwc:MaterialEntities and/or Media are 
--   preserved.

CREATE TABLE collection (
  collection_id TEXT PRIMARY KEY,
  collection_type TEXT,
  collection_type_iri TEXT,
  collection_type_vocabulary TEXT,
  collection_name TEXT,
  collection_code TEXT,
  institution_name TEXT,
  institution_code TEXT,
  institution_id TEXT
  );

-- GeneticSequence
--   A digital representation of a nucleotide sequence.

CREATE TABLE genetic_sequence (
  genetic_sequence_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  derived_from_material_entity_id TEXT,
  genetic_sequence_type TEXT,
  genetic_sequence_type_iri TEXT,
  genetic_sequence_type_vocabulary TEXT,
  genetic_sequence TEXT NOT NULL,
  genetic_sequence_citation TEXT,
  genetic_sequence_remarks TEXT
);
CREATE INDEX ON genetic_sequence(event_id);
CREATE INDEX ON genetic_sequence(derived_from_material_entity_id);

-- OrganismInteraction 
--   An interaction between two dwc:Organisms during a dwc:Event.
--   (subject Organism Occurrence interaction with related Organism Orccurrence,
--   interaction from the perspective of subject to related object)

CREATE TABLE organism_interaction (
  organism_interaction_id TEXT PRIMARY KEY,
  organism_interaction_description TEXT,
  subject_occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  subject_organism_part TEXT,
  organism_interaction_type TEXT,
  organism_interaction_type_iri TEXT,
  organism_interaction_type_vocabulary TEXT,
  related_occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  related_organism_part TEXT
);
CREATE INDEX ON organism_interaction(subject_occurrence_id);
CREATE INDEX ON organism_interaction(related_occurrence_id);

-- Survey
--   A biotic survey.

CREATE TABLE survey (
  survey_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  site_count SMALLINT CHECK (site_count >= 1),
  site_nesting_description TEXT,
  verbatim_site_descriptions TEXT,
  verbatim_site_names TEXT,
  geospatial_scope_area_value NUMERIC CHECK (geospatial_scope_area_value >= 0),
  geospatial_scope_area_unit TEXT,
  total_area_sampled_value NUMERIC CHECK (total_area_sampled_value >= 0),
  total_area_sampled_unit TEXT,
  reported_weather TEXT,
  reported_extreme_conditions TEXT,
  event_duration_value NUMERIC CHECK (event_duration_value >= 0),
  event_duration_unit TEXT,
  taxon_completeness_reported TAXON_COMPLETENESS_REPORTED DEFAULT 'not reported' NOT NULL,
  taxon_completeness_protocols TEXT,
  is_taxonomic_scope_fully_reported BOOLEAN,
  is_absence_reported BOOLEAN,
  absent_taxa TEXT,
  has_non_target_taxa BOOLEAN,
  non_target_taxa TEXT,
  are_non_target_taxa_fully_reported BOOLEAN,
  has_non_target_organisms BOOLEAN,
  verbatim_target_scope TEXT,
  identified_by TEXT,
  identified_by_id TEXT,
  identification_references TEXT,
  compilation_types TEXT,
  compilation_source_types TEXT,
  inventory_types TEXT,
  protocol_names TEXT,
  protocol_descriptions TEXT,
  protocol_references TEXT,
  is_abundance_reported BOOLEAN,
  is_abundance_cap_reported BOOLEAN,
  abundance_cap SMALLINT CHECK (abundance_cap >= 0),
  is_vegetation_cover_reported BOOLEAN,
  is_least_specific_target_category_quantity_inclusive BOOLEAN,
  has_vouchers BOOLEAN,
  voucher_institutions TEXT,
  has_material_samples BOOLEAN,
  material_sample_types TEXT,
  sampling_performed_by TEXT,
  sampling_performed_by_id TEXT,
  is_sampling_effort_reported BOOLEAN,
  sampling_effort_protocol TEXT,
  sampling_effort_protocol_id TEXT,
  sampling_effort_value NUMERIC CHECK (sampling_effort_value >= 0),
  sampling_effort_unit TEXT,
  informationWithheld TEXT,
  dataGeneralizations TEXT
);
CREATE INDEX ON survey(event_id);

-- SurveyTarget
--   A specification of a characteristic of dwc:Occurrence that was included or excluded in a Survey.

CREATE TABLE survey_target (
  survey_target_id TEXT PRIMARY KEY,
  survey_id TEXT,
  survey_target_type TEXT,
  survey_target_type_iri TEXT,
  survey_target_type_vocabulary TEXT,
  survey_target_value TEXT,
  survey_target_value_iri TEXT,
  survey_target_value_vocabulary TEXT,
  survey_target_unit TEXT,
  survey_target_unit_iri TEXT,
  survey_target_unit_vocabulary TEXT,
  include_or_exclude INCLUDE_OR_EXCLUDE DEFAULT 'include' NOT NULL,
  is_survey_target_fully_reported BOOLEAN
);
CREATE INDEX ON survey_target(survey_id);

-- ChronometricAge (https://tdwg.github.io/chrono/terms/#chronometricage)
--   An approximations of temporal position (in the sense conveyed by 
--   https://www.w3.org/TR/owl-time/#time:TemporalPosition) that is supported by evidence.

CREATE TABLE chronometric_age (
  chronometric_age_id TEXT PRIMARY KEY, 
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_chronometric_age TEXT,
  chronometric_age_protocol TEXT,
  chronometric_age_protocol_id TEXT,
  uncalibrated_chronometric_age TEXT,
  chronometric_age_conversion_protocol TEXT,
  chronometric_age_conversion_protocol_id TEXT,
  earliest_chronometric_age INTEGER,
  earliest_chronometric_age_reference_system TEXT,
  latest_chronometric_age INTEGER,
  latest_chronometric_age_reference_system TEXT,
  chronometric_age_uncertainty_in_years INTEGER,
  chronometric_age_uncertainty_method TEXT,
  material_dated TEXT,
  material_dated_id TEXT,
  material_dated_relationship TEXT,
  chronometric_age_determined_by TEXT,
  chronometric_age_determined_by_id TEXT,
  chronometric_age_determined_date TEXT,
  chronometric_age_references TEXT,
  chronometric_age_remarks TEXT
);
CREATE INDEX ON chronometric_age(event_id);
CREATE INDEX ON chronometric_age(material_dated_id);

-- GeologicalContext (https://dwc.tdwg.org/terms/#geologicalcontext)
--   Geological information, such as stratigraphy, that qualifies a region or place.

CREATE TABLE geological_context (
  geological_context_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  earliest_eon_or_lowest_eonothem TEXT,
  latest_eon_or_highest_eonothem TEXT,
  earliest_era_or_lowest_erathem TEXT,
  latest_era_or_highest_erathem TEXT,
  earliest_period_or_lowest_system TEXT,
  latest_period_or_highest_system TEXT,
  earliest_epoch_or_lowest_series TEXT,
  latest_epoch_or_highest_series TEXT,
  earliest_age_or_lowest_stage TEXT,
  latest_age_or_highest_stage TEXT,
  lowest_biostratigraphic_zone TEXT,
  highest_biostratigraphic_zone TEXT,
  lithostratigraphic_terms TEXT,
  "group" TEXT,
  formation TEXT,
  member TEXT,
  bed TEXT
);
CREATE INDEX ON geological_context(event_id);

-- PhylogeneticTree
--    A branching diagram that shows the evolutionary relationships between dwc:Organisms.

CREATE TABLE phylogenetic_tree (
  phylogenetic_tree_id TEXT PRIMARY KEY,
  phylogenetic_tree_protocol TEXT,
  phylogenetic_tree_protocol_id TEXT,
  phylogenetic_tree_citation TEXT
  );

-- PhylogeneticTree
--    A branching diagram that shows the evolutionary relationships between dwc:Organisms.

CREATE TABLE phylogenetic_tree_tip (
  phylogenetic_tree_tip_id TEXT PRIMARY KEY,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  phylogenetic_tree_tip_label TEXT,
  taxon_id TEXT,
  scientific_name TEXT,
  material_entity_id TEXT,
  genetic_sequence_id TEXT
  );
CREATE INDEX ON phylogenetic_tree_tip(phylogenetic_tree_id);

-- Agent (https://www.w3.org/TR/prov-o/#Agent)
--    A person, group, organization or other entity that can act.

CREATE TABLE agent (
  agent_id TEXT PRIMARY KEY,
  agent_type TEXT NOT NULL,
  agent_type_iri TEXT,
  agent_type_vocabulary TEXT,
  preferred_agent_name TEXT
);

-- AgentAgentRole
--    A role filled by an Agent with respect to another Agent.

CREATE TABLE agent_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  related_agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON agent_agent_role(agent_id);
CREATE INDEX ON agent_agent_role(related_agent_id);
ALTER TABLE agent_agent_role ADD CONSTRAINT agent_agent_role_unique_key 
UNIQUE (agent_id, related_agent_id, agent_role, agent_role_iri, agent_role_date);

-- ChronometricAgeAgentRole
--    A role filled by an Agent with respect to a chrono:ChronometricAge.

CREATE TABLE chronometric_age_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON chronometric_age_agent_role(agent_id);
CREATE INDEX ON chronometric_age_agent_role(chronometric_age_id);
ALTER TABLE chronometric_age_agent_role ADD CONSTRAINT chronometric_age_agent_role_unique_key 
UNIQUE (agent_id, chronometric_age_id, agent_role, agent_role_iri, agent_role_date);

-- CollectionAgentRole
--    A role filled by an Agent with respect to a Collection.

CREATE TABLE collection_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  collection_id TEXT REFERENCES collection ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON collection_agent_role(agent_id);
CREATE INDEX ON collection_agent_role(collection_id);
ALTER TABLE collection_agent_role ADD CONSTRAINT collection_agent_role_unique_key 
UNIQUE (agent_id, collection_id, agent_role, agent_role_iri, agent_role_date);

-- EventAgentRole
--    A role filled by an Agent with respect to a dwc:Event.

CREATE TABLE event_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON event_agent_role(agent_id);
CREATE INDEX ON event_agent_role(event_id);
ALTER TABLE event_agent_role ADD CONSTRAINT event_agent_role_unique_key 
UNIQUE (agent_id, event_id, agent_role, agent_role_iri, agent_role_date);

-- GeneticSequenceAgentRole
--    A role filled by an Agent with respect to a GeneticSequence.

CREATE TABLE genetic_sequence_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  genetic_sequence_id TEXT REFERENCES genetic_sequence ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON genetic_sequence_agent_role(agent_id);
CREATE INDEX ON genetic_sequence_agent_role(genetic_sequence_id);
ALTER TABLE genetic_sequence_agent_role ADD CONSTRAINT genetic_sequence_agent_role_unique_key 
UNIQUE (agent_id, genetic_sequence_id, agent_role, agent_role_iri, agent_role_date);

-- IdentificationAgentRole
--    A role filled by an Agent with respect to a dwc:Identification.

CREATE TABLE identification_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  identification_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON identification_agent_role(agent_id);
CREATE INDEX ON identification_agent_role(identification_id);
ALTER TABLE identification_agent_role ADD CONSTRAINT identification_agent_role_unique_key 
UNIQUE (agent_id, identification_id, agent_role, agent_role_iri, agent_role_date);

-- MaterialAgentRole
--    A role filled by an Agent with respect to a dwc:MaterialEntity.

CREATE TABLE material_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON material_agent_role(agent_id);
CREATE INDEX ON material_agent_role(material_entity_id);
ALTER TABLE material_agent_role ADD CONSTRAINT material_agent_role_unique_key 
UNIQUE (agent_id, material_entity_id, agent_role, agent_role_iri, agent_role_date);

-- Media
--   Media (dcmi:Sounds, dcmi:StillImages, dcmi:MovingImages or dcmi:Text) with other entities as content.

CREATE TABLE media (
  media_id TEXT PRIMARY KEY,
  media_type TEXT,
  media_type_iri TEXT,
  media_type_vocabulary TEXT,
  access_uri TEXT,
  web_statement TEXT,
  format TEXT,
  rights TEXT,
  owner TEXT,
  source TEXT,
  creator TEXT,
  creator_id TEXT,
  create_date TEXT,
  modified TEXT,
  media_language TEXT,
  media_description TEXT
);

-- MediaAgentRole
--    A role filled by an Agent with respect to a Media entity.

CREATE TABLE media_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON media_agent_role(agent_id);
CREATE INDEX ON media_agent_role(media_id);
ALTER TABLE media_agent_role ADD CONSTRAINT media_agent_role_unique_key 
UNIQUE (agent_id, media_id, agent_role, agent_role_iri, agent_role_date);

-- OccurrenceAgentRole
--    A role filled by an Agent with respect to a dwc:Occurrence.

CREATE TABLE occurrence_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON occurrence_agent_role(agent_id);
CREATE INDEX ON occurrence_agent_role(occurrence_id);
ALTER TABLE occurrence_agent_role ADD CONSTRAINT occurrence_agent_role_unique_key 
UNIQUE (agent_id, occurrence_id, agent_role, agent_role_iri, agent_role_date);

-- OrganismInteractionAgentRole
--    A role filled by an Agent with respect to an OrganismInteraction.

CREATE TABLE organism_interaction_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  organism_interaction_id TEXT REFERENCES organism_interaction ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON organism_interaction_agent_role(agent_id);
CREATE INDEX ON organism_interaction_agent_role(organism_interaction_id);
ALTER TABLE organism_interaction_agent_role ADD CONSTRAINT organism_interaction_agent_role_unique_key 
UNIQUE (agent_id, organism_interaction_id, agent_role, agent_role_iri, agent_role_date);

-- SurveyAgentRole
--    A role filled by an Agent with respect to a Survey.

CREATE TABLE survey_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON survey_agent_role(agent_id);
CREATE INDEX ON survey_agent_role(survey_id);
ALTER TABLE survey_agent_role ADD CONSTRAINT survey_agent_role_unique_key 
UNIQUE (agent_id, survey_id, agent_role, agent_role_iri, agent_role_date);

-- ChronometricAgeAssertion
--    An Assertion made by an Agent about a chrono:ChronometricAge.

CREATE TABLE chronometric_age_assertion (
  assertion_id TEXT PRIMARY KEY,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON chronometric_age_assertion(chronometric_age_id);

-- CollectionAssertion
--    An Assertion made by an Agent about a Collection.

CREATE TABLE collection_assertion (
  assertion_id TEXT PRIMARY KEY,
  collection_id TEXT REFERENCES collection ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON collection_assertion(collection_id);

-- EventAssertion
--    An Assertion made by an Agent about a dwc:Event.

CREATE TABLE event_assertion (
  assertion_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON event_assertion(event_id);

-- GeneticSequenceAssertion
--    An Assertion made by an Agent about a GeneticSequence.

CREATE TABLE genetic_sequence_assertion (
  assertion_id TEXT PRIMARY KEY,
  genetic_sequence_id TEXT REFERENCES genetic_sequence ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON genetic_sequence_assertion(genetic_sequence_id);

-- MaterialAssertion
--    An Assertion made by an Agent about a dwc:MaterialEntity.

CREATE TABLE material_assertion (
  assertion_id TEXT PRIMARY KEY,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON material_assertion(material_entity_id);

-- MediaAssertion
--    An Assertion made by an Agent about a Media entity.

CREATE TABLE media_assertion (
  assertion_id TEXT PRIMARY KEY,
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON media_assertion(media_id);

-- OccurrenceAssertion
--    An Assertion made by an Agent about a dwc:Occurrence.

CREATE TABLE occurrence_assertion (
  assertion_id TEXT PRIMARY KEY,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON occurrence_assertion(occurrence_id);

-- OrganismInteractionAssertion
--    An Assertion made by an Agent about an OrganismInteraction.

CREATE TABLE organism_interaction_assertion (
  assertion_id TEXT PRIMARY KEY,
  organism_interaction_id TEXT REFERENCES organism_interaction ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON organism_interaction_assertion(organism_interaction_id);

-- PhylogeneticTreeAssertion
--    An Assertion made by an Agent about a PhylogeneticTree.

CREATE TABLE phylogenetic_tree_assertion (
  assertion_id TEXT PRIMARY KEY,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON phylogenetic_tree_assertion(phylogenetic_tree_id);

-- PhylogeneticTreeTipAssertion
--    An Assertion made by an Agent about a PhylogeneticTreeTip.

CREATE TABLE phylogenetic_tree_tip_assertion (
  assertion_id TEXT PRIMARY KEY,
  phylogenetic_tree_tip_id TEXT REFERENCES phylogenetic_tree_tip ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON phylogenetic_tree_tip_assertion(phylogenetic_tree_tip_id);

-- SurveyAssertion
--    An Assertion made by an Agent about a Survey.

CREATE TABLE survey_assertion (
  assertion_id TEXT PRIMARY KEY,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL,
  assertion_type TEXT NOT NULL,
  assertion_type_iri TEXT,
  assertion_type_vocabulary TEXT,
  assertion_made_date TEXT,
  assertion_effective_date TEXT,
  assertion_value TEXT,
  assertion_value_iri TEXT,
  assertion_value_vocabulary TEXT,
  assertion_value_numeric NUMERIC,
  assertion_unit TEXT,
  assertion_unit_iri TEXT,
  assertion_unit_vocabulary TEXT,
  assertion_by TEXT, 
  assertion_by_id TEXT,
  assertion_protocol TEXT,
  assertion_protocol_id TEXT,
  assertion_citation TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON survey_assertion(survey_id);

-- ChronometricAgeCitation
--   A citation of a chrono:ChronometricAge in a bibliographic reference.

CREATE TABLE chronometric_age_citation (
  citation_id TEXT PRIMARY KEY,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON chronometric_age_citation(chronometric_age_id);

-- EventCitation
--   A citation of a dwc:Event in a bibliographic reference.

CREATE TABLE event_citation (
  citation_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON event_citation(event_id);

-- GeneticSequenceCitation
--   A citation of a GeneticSequence in a bibliographic reference.

CREATE TABLE genetic_sequence_citation (
  citation_id TEXT PRIMARY KEY,
  genetic_sequence_id TEXT REFERENCES genetic_sequence ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON genetic_sequence_citation(genetic_sequence_id);

-- MaterialCitation
--   A citation of a dwc:MaterialEntity in a bibliographic reference.

CREATE TABLE material_citation (
  citation_id TEXT PRIMARY KEY,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON material_citation(material_entity_id);

-- OccurrenceCitation
--   A citation of a dwc:Occurrence in a bibliographic reference.

CREATE TABLE occurrence_citation (
  citation_id TEXT PRIMARY KEY,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON occurrence_citation(occurrence_id);

-- OrganismInteractionCitation
--   A citation of an OrganismInteraction in a bibliographic reference.

CREATE TABLE organism_interaction_citation (
  citation_id TEXT PRIMARY KEY,
  organism_interaction_id TEXT REFERENCES organism_interaction ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON organism_interaction_citation(organism_interaction_id);

-- PhylogeneticTreeCitation
--   A citation of a PhylogeneticTree in a bibliographic reference.

CREATE TABLE phylogenetic_tree_citation (
  citation_id TEXT PRIMARY KEY,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON phylogenetic_tree_citation(phylogenetic_tree_id);

-- Protocol
--    A method used during an action.

CREATE TABLE protocol (
  protocol_id TEXT PRIMARY KEY,
  protocol_type TEXT,
  protocol_type_iri TEXT,
  protocol_type_vocabulary TEXT,
  protocol_name TEXT,
  protocol_description TEXT,
  protocol_citation TEXT,
  protocol_remarks TEXT
);

-- ProtocolCitation
--   A citation of a Protocol in a bibliographic reference.

CREATE TABLE protocol_citation (
  citation_id TEXT PRIMARY KEY,
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON protocol_citation(protocol_id);

-- SurveyCitation
--   A citation of a Protocol in a bibliographic reference.

CREATE TABLE survey_citation (
  citation_id TEXT PRIMARY KEY,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL,
  citation_type TEXT,
  citation_type_iri TEXT,
  citation_type_vocabulary TEXT,
  bibliographic_citation TEXT,
  page_number TEXT,
  reference_id TEXT,
  reference_type TEXT,
  reference_type_iri TEXT,
  reference_type_vocabulary TEXT,
  reference_year SMALLINT,
  is_peer_reviewed BOOLEAN,
  citation_remarks TEXT
);
CREATE INDEX ON survey_citation(survey_id);

-- AgentMedia
--   A link establishing an Agent as content in a Media entity.

CREATE TABLE agent_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON agent_media(agent_id);

-- ChronometricAgeMedia
--   A link establishing a chrono:ChronometricAge as content of a Media entity

CREATE TABLE chronometric_age_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON chronometric_age_media(chronometric_age_id);

-- CollectionMedia
--   A link establishing a Collection as content in a Media entity.

CREATE TABLE collection_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  collection_id TEXT REFERENCES collection ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON collection_media(collection_id);

-- EventMedia
--   A link establishing a dwc:Event as content in a Media entity.

CREATE TABLE event_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON event_media(event_id);

-- GeneticSequenceMedia
--   A link establishing a GeneticSequence as content in a Media entity.

CREATE TABLE genetic_sequence_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  genetic_sequence_id TEXT REFERENCES genetic_sequence ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON genetic_sequence_media(genetic_sequence_id);

-- EventMedia
--   A link establishing a dwc:Event as content in a Media entity.

CREATE TABLE material_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON material_media(material_entity_id);

-- OccurrenceMedia
--   A link establishing a dwc:Occurrence as content in a Media entity.

CREATE TABLE occurrence_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON occurrence_media(occurrence_id);

-- OrganismInteractionMedia
--   A link establishing an OrganismInteraction as content in a Media entity.

CREATE TABLE organism_interaction_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  organism_interaction_id TEXT REFERENCES organism_interaction ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON organism_interaction_media(organism_interaction_id);

-- PhylogeneticTreeMedia
--   A link establishing a PhylogeneticTree as content in a Media entity.

CREATE TABLE phylogenetic_tree_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT
);
CREATE INDEX ON phylogenetic_tree_media(phylogenetic_tree_id);

-- AgentIdentifier
--    An identifier for an Agent.

CREATE TABLE agent_identifier (
  identifier TEXT NOT NULL,
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
CREATE INDEX ON agent_identifier(agent_id);

-- EventIdentifier
--    An identifier for a dwc:Event.

CREATE TABLE event_identifier (
  identifier TEXT NOT NULL,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
CREATE INDEX ON event_identifier(event_id);

-- MaterialIdentifier
--    An identifier for a dwc:MaterialEntity.

CREATE TABLE material_identifier (
  identifier TEXT NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
CREATE INDEX ON material_identifier(material_entity_id);

-- MediaIdentifier
--    An identifier for a Media entity.

CREATE TABLE media_identifier (
  identifier TEXT NOT NULL,
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
CREATE INDEX ON media_identifier(media_id);

-- OccurrenceIdentifier
--    An identifier for a dwc:Occurrence.

CREATE TABLE occurrence_identifier (
  identifier TEXT NOT NULL,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
CREATE INDEX ON occurrence_identifier(occurrence_id);

-- PhylogeneticTreeIdentifier
--    An identifier for a PhylogeneticTree.

CREATE TABLE phylogenetic_tree_identifier (
  identifier TEXT NOT NULL,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
CREATE INDEX ON phylogenetic_tree_identifier(phylogenetic_tree_id);

-- SurveyIdentifier
--    An identifier for a Survey.

CREATE TABLE survey_identifier (
  identifier TEXT NOT NULL,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
CREATE INDEX ON survey_identifier(survey_id);

-- ChronometricAgeProtocol
--    A link establishing a Protocol used in the determination of a chrono:ChronometricAge.

CREATE TABLE chronometric_age_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON chronometric_age_protocol(chronometric_age_id);

-- EventProtocol
--    A link establishing a Protocol used in a dwc:Event.

CREATE TABLE event_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON event_protocol(event_id);

-- GeneticSequenceProtocol
--    A link establishing a Protocol used in the determination of a GeneticSequence.

CREATE TABLE genetic_sequence_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  genetic_sequence_id TEXT REFERENCES genetic_sequence ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON genetic_sequence_protocol(genetic_sequence_id);

-- MaterialProtocol
--    A link establishing a Protocol used in the treatment of a dwc:MaterialEntity.

CREATE TABLE material_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON material_protocol(material_entity_id);

-- OccurrenceProtocol
--    A link establishing a Protocol used in the determination of a dwc:Occurrence.

CREATE TABLE occurrence_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON occurrence_protocol(occurrence_id);

-- PhylogeneticTreeProtocol
--    A link establishing a Protocol used in the determination of a PhylogeneticTree.

CREATE TABLE phylogenetic_tree_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON phylogenetic_tree_protocol(phylogenetic_tree_id);

-- SurveyProtocol
--    A link establishing a Protocol used in a Survey.

CREATE TABLE survey_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON survey_protocol(survey_id);

-- COMMON_TARGETS
--    Resource types for the subject resource and related resource in a Relationship.
CREATE TYPE COMMON_TARGETS AS ENUM (
  'Event',
  'Occurrence',
  'Identification',
  'Material',
  'Collection',
  'Genetic Sequence',
  'Organism Interaction',
  'Survey',
  'Survey Target',
  'Chronometric Age',
  'Geological Context',
  'Phylogenetic Tree',
  'Phylogenetic Tree Tip',
  'Agent',
  'Media',
  'Protocol',
  'Relationship'
);

-- Relationship
--   A specification for a relationship of a subject entity to a related entity.

CREATE TABLE relationship (
  relationship_id TEXT PRIMARY KEY,
  subject_resource_id TEXT NOT NULL,
  subject_resource_type COMMON_TARGETS NOT NULL,
  subject_resource_type_iri TEXT,
  subject_resource_type_vocabulary TEXT,
  relationship_type TEXT,
  relationship_type_iri TEXT,
  relationship_type_vocabulary TEXT,
  related_resource_id TEXT NOT NULL,
  related_resource_type COMMON_TARGETS NOT NULL,
  related_resource_type_iri TEXT,
  related_resource_type_vocabulary TEXT,
  relationship_order SMALLINT NOT NULL DEFAULT 1 CHECK (relationship_order >= 1),
  relationship_according_to TEXT,
  relationship_according_to_id TEXT,
  relationship_effective_date TEXT,
  relationship_remarks TEXT
);
CREATE INDEX ON relationship(subject_resource_id);
CREATE INDEX ON relationship(related_resource_id);