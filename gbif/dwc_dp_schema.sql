---
-- Database schema for the Darwin Core Data Package (DwC-DP) publishing model.
-- Matches DwC-DP version 2025-06-04
-- 

-- ENUMs
CREATE TYPE INCLUDE_OR_EXCLUDE AS ENUM (
  'include',
  'exclude'
);

CREATE TYPE OCCURRENCE_STATUS AS ENUM (
  'detected',
  'present',
  'not detected',
  'absent'
);

CREATE TYPE TAXON_COMPLETENESS_REPORTED AS ENUM (
  'not reported',
  'reported complete',
  'reported incomplete'
);

-- RELATIONSHIP_TARGETS
--    Resource types for the subject resource and related resource in a Relationship.
CREATE TYPE RELATIONSHIP_TARGETS AS ENUM (
  'Event',
  'Occurrence',
  'Identification',
  'Material',
  'Collection',
  'NucleotideAnalysis',
  'MolecularProtocol',
  'NucleotideSequence',
  'OrganismInteraction',
  'Survey',
  'ChronometricAge',
  'GeologicalContext',
  'PhylogeneticTree',
  'PhylogeneticTreeTip',
  'Agent',
  'Media',
  'Protocol',
  'Reference',
  'Relationship'
);

-- Protocol
--    A method used during an action.

CREATE TABLE protocol (
  protocol_id TEXT PRIMARY KEY,
  protocol_type TEXT,
  protocol_type_iri TEXT,
  protocol_type_vocabulary TEXT,
  protocol_name TEXT,
  protocol_description TEXT,
  protocol_reference TEXT,
  protocol_remarks TEXT
);

-- Agent (https://www.w3.org/TR/prov-o/#Agent)
--    A person, group, organization or other entity that can act.

CREATE TABLE agent (
  agent_id TEXT PRIMARY KEY,
  agent_type TEXT NOT NULL,
  agent_type_iri TEXT,
  agent_type_vocabulary TEXT,
  preferred_agent_name TEXT
);

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
ALTER TABLE agent_identifier ADD CONSTRAINT agent_identifier_unique UNIQUE (
  identifier, agent_id, identifier_type, identifier_type_iri, identifier_type_vocabulary, identifier_language
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

-- Media
--   Media (dcmi:Sounds, dcmi:StillImages, dcmi:MovingImages or dcmi:Text) with other entities as content.

CREATE TABLE media (
  media_id TEXT PRIMARY KEY,
  media_type TEXT,
  subtype_literal TEXT,
  subtype TEXT,
  title TEXT,
  modified TEXT,
  metadata_date TEXT,
  metadata_language_literal TEXT,
  metadata_language TEXT,
  commenter_literal TEXT,
  commenter TEXT,
  comments TEXT,
  reviewer_literal TEXT,
  reviewer TEXT,
  reviewer_comments TEXT,
  available TEXT,
  has_service_access_point TEXT,
  rights TEXT,
  rights_iri TEXT,
  owner TEXT,
  usage_terms TEXT,
  web_statement TEXT,
  license_logo_url TEXT,
  credit TEXT,
  attribution_logo_url TEXT,
  attribution_link_url TEXT,
  funding_attribution TEXT,
  funding_attribution_id TEXT,
  source TEXT,
  source_iri TEXT,
  creator TEXT,
  creator_iri TEXT,
  provider_literal TEXT,
  provider TEXT,
  metadata_creator_literal TEXT,
  metadata_creator TEXT,
  metadata_provider_literal TEXT,
  metadata_provider TEXT,
  description TEXT,
  caption TEXT,
  language TEXT,
  language_iri TEXT,
  tag TEXT,
  create_date TEXT,
  time_of_day TEXT,
  capture_device TEXT,
  resource_creation_technique TEXT,
  collection_code TEXT,
  collection_id TEXT,
  derived_from TEXT,
  access_uri TEXT,
  format TEXT,
  format_iri TEXT,
  variant_literal TEXT,
  variant TEXT,
  variant_description TEXT,
  further_information_url TEXT,
  licensing_exception TEXT,
  service_expectation TEXT,
  hash_function TEXT,
  hash_value TEXT,
  pixel_x_dimension INTEGER,
  pixel_y_dimension INTEGER,
  feedback_url TEXT
);
CREATE INDEX ON media(commenter);
CREATE INDEX ON media(reviewer);
CREATE INDEX ON media(source_iri);
CREATE INDEX ON media(creator_iri);
CREATE INDEX ON media(provider);
CREATE INDEX ON media(metadata_creator);
CREATE INDEX ON media(metadata_provider);

-- MediaAssertion
--    An Assertion made by an Agent about a Media entity.

CREATE TABLE media_assertion (
  assertion_id TEXT PRIMARY KEY,
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON media_assertion(media_id);
CREATE INDEX ON media_assertion(assertion_by_id);
CREATE INDEX ON media_assertion(assertion_protocol_id);

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
ALTER TABLE media_identifier ADD CONSTRAINT media_identifier_unique UNIQUE (
  identifier, media_id, identifier_type, identifier_type_iri, identifier_type_vocabulary, identifier_language
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

-- AgentMedia
--   A link establishing an Agent as content in a Media entity.

CREATE TABLE agent_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON agent_media(agent_id);

-- Collection (see Latimer Core)
--   A persistent formal repository in which dwc:MaterialEntities and/or Media are 
--   preserved.
/*
CREATE TABLE collection (
  collection_id TEXT PRIMARY KEY,
  collection_type TEXT,
  collection_name TEXT,
  collection_code TEXT,
  institution_id TEXT,
  institution_name TEXT,
  institution_code TEXT
);
CREATE INDEX ON collection(institution_id);

-- CollectionAssertion
--    An Assertion made by an Agent about a Collection.

CREATE TABLE collection_assertion (
  assertion_id TEXT PRIMARY KEY,
  collection_id TEXT REFERENCES collection ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON collection_assertion(collection_id);
CREATE INDEX ON collection_assertion(assertion_by_id);
CREATE INDEX ON collection_assertion(assertion_protocol_id);

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

-- CollectionMedia
--   A link establishing a Collection as content in a Media entity.

CREATE TABLE collection_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  collection_id TEXT REFERENCES collection ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON collection_media(collection_id);
*/

-- Reference
--   A bibliographic reference in which an entity is mentioned.

CREATE TABLE reference (
  reference_id TEXT PRIMARY KEY,
  parent_reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  reference_type TEXT,
  bibliographic_citation TEXT,
  title TEXT,
  issued TEXT,
  identifier TEXT,
  creator TEXT,
  creator_id TEXT,
  publisher TEXT,
  publisher_id TEXT,
  pagination TEXT,
  is_peer_reviewed BOOLEAN,
  reference_remarks TEXT
);
CREATE INDEX ON reference(creator_id);
CREATE INDEX ON reference(publisher_id);

-- ProtocolReference
--   A citation of a Protocol in a bibliographic reference.

CREATE TABLE protocol_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON protocol_reference(reference_id);
CREATE INDEX ON protocol_reference(protocol_id);

-- Event (https://dwc.tdwg.org/terms/#event)
--   Something that occurs at some location during some time.

CREATE TABLE event (
  event_id TEXT PRIMARY KEY,
  parent_event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE,
  preferred_event_name TEXT,
  event_category TEXT NOT NULL,
  event_type TEXT,
  dataset_name TEXT,
  dataset_id TEXT,
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
  event_effort TEXT,
  field_notes TEXT,
  event_references TEXT,
  event_remarks TEXT,
  location_id TEXT,
  higher_geography_id TEXT,
  higher_geography TEXT,
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
  information_withheld TEXT,
  data_generalizations TEXT,
  preferred_spatial_representation TEXT,
  project_id TEXT,
  project_title TEXT,
  funding_attribution TEXT,
  funding_attribution_id TEXT,
  feedback_url TEXT
);
CREATE INDEX ON event(parent_event_id);
CREATE INDEX ON event(event_conducted_by_id);
CREATE INDEX ON event(georeferenced_by_id);
CREATE INDEX ON event(georeference_protocol_id);
CREATE INDEX ON event(funding_attribution_id);

-- EventAssertion
--    An Assertion made by an Agent about a dwc:Event.

CREATE TABLE event_assertion (
  assertion_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON event_assertion(event_id);
CREATE INDEX ON event_assertion(assertion_by_id);
CREATE INDEX ON event_assertion(assertion_protocol_id);

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
ALTER TABLE event_identifier ADD CONSTRAINT event_identifier_unique UNIQUE (
  identifier, event_id, identifier_type, identifier_type_iri, identifier_type_vocabulary, identifier_language
);

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

-- EventMedia
--   A link establishing a dwc:Event as content in a Media entity.

CREATE TABLE event_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON event_media(event_id);

-- EventProtocol
--    A link establishing a Protocol used in a dwc:Event.

CREATE TABLE event_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON event_protocol(event_id);
CREATE INDEX ON event_protocol(protocol_id);

-- EventReference
--   A citation of a dwc:Event in a bibliographic reference.

CREATE TABLE event_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON event_reference(event_id);
CREATE INDEX ON event_reference(reference_id);

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
CREATE INDEX ON chronometric_age(chronometric_age_protocol_id);
CREATE INDEX ON chronometric_age(chronometric_age_conversion_protocol_id);
CREATE INDEX ON chronometric_age(material_dated_id);
CREATE INDEX ON chronometric_age(chronometric_age_determined_by_id);

-- ChronometricAgeAssertion
--    An Assertion made by an Agent about a chrono:ChronometricAge.

CREATE TABLE chronometric_age_assertion (
  assertion_id TEXT PRIMARY KEY,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON chronometric_age_assertion(chronometric_age_id);
CREATE INDEX ON chronometric_age_assertion(assertion_by_id);
CREATE INDEX ON chronometric_age_assertion(assertion_protocol_id);

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

-- ChronometricAgeMedia
--   A link establishing a chrono:ChronometricAge as content of a Media entity

CREATE TABLE chronometric_age_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON chronometric_age_media(chronometric_age_id);

-- ChronometricAgeProtocol
--    A link establishing a Protocol used in the determination of a chrono:ChronometricAge.

CREATE TABLE chronometric_age_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON chronometric_age_protocol(protocol_id);
CREATE INDEX ON chronometric_age_protocol(chronometric_age_id);

-- ChronometricAgeReference
--   A citation of a chrono:ChronometricAge in a bibliographic reference.

CREATE TABLE chronometric_age_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  chronometric_age_id TEXT REFERENCES chronometric_age ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON chronometric_age_reference(reference_id);
CREATE INDEX ON chronometric_age_reference(chronometric_age_id);

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

-- GeologicalContextMedia
--   A link establishing a dwc:GeologicalContext as content in a Media entity.

CREATE TABLE geological_context_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  geological_context_id TEXT REFERENCES geological_context ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON geological_context_media(geological_context_id);

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
  taxon_completeness_reported TAXON_COMPLETENESS_REPORTED DEFAULT 'not reported',
  taxon_completeness_protocols TEXT,
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
  sample_size_value TEXT,
  sample_size_unit TEXT,
  sampling_performed_by TEXT,
  sampling_performed_by_id TEXT,
  is_sampling_effort_reported BOOLEAN,
  sampling_effort_protocol TEXT,
  sampling_effort_protocol_id TEXT,
  sampling_effort_value NUMERIC CHECK (sampling_effort_value >= 0),
  sampling_effort_unit TEXT,
  information_withheld TEXT,
  data_generalizations TEXT,
  feedback_url TEXT
);
CREATE INDEX ON survey(event_id);
CREATE INDEX ON survey(identified_by_id);
CREATE INDEX ON survey(sampling_performed_by_id);
CREATE INDEX ON survey(sampling_effort_protocol_id);

-- SurveyTarget
--   A specification of a characteristic of dwc:Occurrence that was included or excluded in a Survey.

CREATE TABLE survey_target (
  survey_target_id TEXT NOT NULL,
  survey_id TEXT,
  survey_target_type TEXT,
  survey_target_value TEXT,
  survey_target_unit TEXT,
  include_or_exclude INCLUDE_OR_EXCLUDE DEFAULT 'include' NOT NULL,
  is_survey_target_fully_reported BOOLEAN
);
CREATE INDEX ON survey_target(survey_id);

-- SurveyAssertion
--    An Assertion made by an Agent about a Survey.

CREATE TABLE survey_assertion (
  assertion_id TEXT PRIMARY KEY,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON survey_assertion(survey_id);
CREATE INDEX ON survey_assertion(assertion_by_id);
CREATE INDEX ON survey_assertion(assertion_protocol_id);

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
ALTER TABLE survey_identifier ADD CONSTRAINT survey_identifier_unique UNIQUE (
  identifier, survey_id, identifier_type, identifier_type_iri, identifier_type_vocabulary, identifier_language
);

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

-- SurveyProtocol
--    A link establishing a Protocol used in a Survey.

CREATE TABLE survey_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON survey_protocol(protocol_id);
CREATE INDEX ON survey_protocol(survey_id);

-- SurveyReference
--   A citation of a Survey in a bibliographic reference.

CREATE TABLE survey_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  survey_id TEXT REFERENCES survey ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON survey_reference(reference_id);
CREATE INDEX ON survey_reference(survey_id);

-- Occurrence (https://dwc.tdwg.org/terms/#occurrence)
--   The state of a dwc:Organism at some location during some time.

CREATE TABLE occurrence (
  occurrence_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  survey_target_id TEXT,
  recorded_by TEXT,
  recorded_by_id TEXT,
  organism_quantity TEXT,
  organism_quantity_type TEXT,
  sex TEXT,
  life_stage TEXT,
  reproductive_condition TEXT,
  caste TEXT,
  behavior TEXT,
  vitality TEXT,
  establishment_means TEXT,
  degree_of_establishment TEXT,
  pathway TEXT,
  substrate TEXT,
  occurrence_status OCCURRENCE_STATUS DEFAULT 'detected' NOT NULL,
  occurrence_references TEXT,
  information_withheld TEXT,
  data_generalizations TEXT,
  occurrence_remarks TEXT,
  organism_id TEXT,
  organism_scope TEXT DEFAULT 'multicellular organism',
  organism_name TEXT,
  cause_of_death TEXT,
  organism_remarks TEXT,
  verbatim_identification TEXT,
  taxon_formula TEXT DEFAULT 'A',
  identified_by TEXT,
  identified_by_id TEXT,
  date_identified TEXT,
  identification_references TEXT,
  identification_verification_status TEXT,
  identification_remarks TEXT,
  taxon_id TEXT,
  higher_classification_name TEXT,
  higher_classification_rank TEXT,
  scientific_name TEXT,
  taxon_rank TEXT,
  taxon_remarks TEXT,
  feedback_url TEXT
);
CREATE INDEX ON occurrence(event_id);
CREATE INDEX ON occurrence(survey_target_id);
CREATE INDEX ON occurrence(recorded_by_id);
CREATE INDEX ON occurrence(identified_by_id);

-- OccurrenceAssertion
--    An Assertion made by an Agent about a dwc:Occurrence.

CREATE TABLE occurrence_assertion (
  assertion_id TEXT PRIMARY KEY,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON occurrence_assertion(occurrence_id);
CREATE INDEX ON occurrence_assertion(assertion_by_id);
CREATE INDEX ON occurrence_assertion(assertion_protocol_id);

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
ALTER TABLE occurrence_identifier ADD CONSTRAINT occurrence_identifier_unique UNIQUE (
  identifier, occurrence_id, identifier_type, identifier_type_iri, identifier_type_vocabulary, identifier_language
);

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

-- OccurrenceMedia
--   A link establishing a dwc:Occurrence as content in a Media entity.

CREATE TABLE occurrence_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON occurrence_media(occurrence_id);

-- OccurrenceProtocol
--    A link establishing a Protocol used in the determination of a dwc:Occurrence.

CREATE TABLE occurrence_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON occurrence_protocol(protocol_id);
CREATE INDEX ON occurrence_protocol(occurrence_id);

-- OccurrenceReference
--   A citation of a dwc:Occurrence in a bibliographic reference.

CREATE TABLE occurrence_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON occurrence_reference(reference_id);
CREATE INDEX ON occurrence_reference(occurrence_id);

-- OrganismInteraction 
--   An interaction between two dwc:Organisms during a dwc:Event.
--   (subject Organism Occurrence interaction with related Organism Orccurrence,
--   interaction from the perspective of subject to related object)

CREATE TABLE organism_interaction (
  organism_interaction_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  organism_interaction_description TEXT,
  subject_occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  subject_organism_part TEXT,
  organism_interaction_type TEXT,
  related_occurrence_id TEXT REFERENCES occurrence ON DELETE CASCADE DEFERRABLE NOT NULL,
  related_organism_part TEXT,
  feedback_url TEXT
);
CREATE INDEX ON organism_interaction(event_id);
CREATE INDEX ON organism_interaction(subject_occurrence_id);
CREATE INDEX ON organism_interaction(related_occurrence_id);

-- OrganismInteractionAssertion
--    An Assertion made by an Agent about an OrganismInteraction.

CREATE TABLE organism_interaction_assertion (
  assertion_id TEXT PRIMARY KEY,
  organism_interaction_id TEXT REFERENCES organism_interaction ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON organism_interaction_assertion(organism_interaction_id);
CREATE INDEX ON organism_interaction_assertion(assertion_by_id);
CREATE INDEX ON organism_interaction_assertion(assertion_protocol_id);

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

-- OrganismInteractionMedia
--   A link establishing an OrganismInteraction as content in a Media entity.

CREATE TABLE organism_interaction_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  organism_interaction_id TEXT REFERENCES organism_interaction ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON organism_interaction_media(organism_interaction_id);

-- OrganismInteractionReference
--   A citation of an OrganismInteraction in a bibliographic reference.

CREATE TABLE organism_interaction_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  organism_interaction_id TEXT REFERENCES organism_interaction ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON organism_interaction_reference(reference_id);
CREATE INDEX ON organism_interaction_reference(organism_interaction_id);

-- Material (https://dwc.tdwg.org/terms/#materialentity)
--  An entity that can be identified, exist for some period of time, and consist in whole or in part of physical matter while it exists.

CREATE TABLE material (
  material_entity_id TEXT PRIMARY KEY,
  digital_specimen_id TEXT,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_category TEXT,
  discipline TEXT,
  material_entity_type TEXT,
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
  object_quantity TEXT,
  object_quantity_type TEXT,
  record_number TEXT,
  preparations TEXT,
  disposition TEXT,
  verbatim_label TEXT,
  associated_sequences TEXT,
  material_references TEXT,
  information_withheld TEXT,
  data_generalizations TEXT,
  material_entity_remarks TEXT,
  evidence_for_occurrence_id TEXT,
  derived_from_material_entity_id TEXT,
  derivation_event_id TEXT,
  derivation_type TEXT,
  is_part_of_material_entity_id TEXT,
  verbatim_identification TEXT,
  taxon_formula TEXT DEFAULT 'A',
  type_status TEXT,
  type_designation_type TEXT,
  typified_name TEXT,
  identified_by TEXT,
  identified_by_id TEXT,
  date_identified TEXT,
  identification_references TEXT,
  identification_verification_status TEXT,
  identification_remarks TEXT,
  taxon_id TEXT,
  higher_classification_name TEXT,
  higher_classification_rank TEXT,
  scientific_name TEXT,
  taxon_rank TEXT,
  taxon_remarks TEXT,
  feedback_url TEXT
);
CREATE INDEX ON material(event_id);
CREATE INDEX ON material(institution_id);
CREATE INDEX ON material(owner_institution_id);
--CREATE INDEX ON material(collection_id);
CREATE INDEX ON material(collected_by_id);
CREATE INDEX ON material(evidence_for_occurrence_id);
CREATE INDEX ON material(derived_from_material_entity_id);
CREATE INDEX ON material(derivation_event_id);
CREATE INDEX ON material(is_part_of_material_entity_id);
CREATE INDEX ON material(identified_by_id);

-- MaterialAssertion
--    An Assertion made by an Agent about a dwc:MaterialEntity.

CREATE TABLE material_assertion (
  assertion_id TEXT PRIMARY KEY,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON material_assertion(material_entity_id);
CREATE INDEX ON material_assertion(assertion_by_id);
CREATE INDEX ON material_assertion(assertion_protocol_id);

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
ALTER TABLE material_identifier ADD CONSTRAINT material_identifier_unique UNIQUE (
  identifier, material_entity_id, identifier_type, identifier_type_iri, identifier_type_vocabulary, identifier_language
);

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

-- MaterialMedia
--   A link establishing a dwc:MaterialEntity as content in a Media entity.

CREATE TABLE material_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON material_media(material_entity_id);

-- MaterialProtocol
--    A link establishing a Protocol used in the treatment of a dwc:MaterialEntity.

CREATE TABLE material_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON material_protocol(protocol_id);
CREATE INDEX ON material_protocol(material_entity_id);

-- MaterialReference
--   A citation of a dwc:MaterialEntity in a bibliographic reference.

CREATE TABLE material_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON material_reference(reference_id);
CREATE INDEX ON material_reference(material_entity_id);

-- NucleotideSequence
--   A digital representation of a nucleotide sequence.

CREATE TABLE nucleotide_sequence (
  nucleotide_sequence_id TEXT PRIMARY KEY,
  nucleotide_sequence TEXT,
  nucleotide_sequence_remarks TEXT
);

-- MolecularProtocol
--   A protocol used to derive and identify a nucleotide sequence from a dwc:MaterialEntity.

CREATE TABLE molecular_protocol (
  molecular_protocol_id TEXT PRIMARY KEY,
  assay_type TEXT,
  samp_name TEXT,
  project_name TEXT,
  experimental_factor TEXT,
  samp_taxon_id TEXT,
  neg_cont_type TEXT,
  pos_cont_type TEXT,
  env_broad_scale TEXT,
  env_local_scale TEXT,
  env_medium TEXT,
  subspecf_gen_lin TEXT,
  ploidy TEXT,
  num_replicons TEXT,
  extrachrom_elements TEXT,
  estimated_size TEXT,
  ref_biomaterial TEXT,
  source_mat_id TEXT,
  pathogenicity TEXT,
  biotic_relationship TEXT,
  specific_host TEXT,
  host_spec_range TEXT,
  host_disease_stat TEXT,
  trophic_level TEXT,
  propagation TEXT,
  encoded_traits TEXT,
  rel_to_oxygen TEXT,
  isol_growth_condt TEXT,
  samp_collec_device TEXT,
  samp_collec_method TEXT,
  samp_mat_process TEXT,
  size_frac TEXT,
  samp_size TEXT,
  samp_vol_we_dna_ext TEXT,
  source_uvig TEXT,
  virus_enrich_appr TEXT,
  nucl_acid_ext TEXT,
  nucl_acid_amp TEXT,
  lib_size TEXT,
  lib_reads_seqd TEXT,
  lib_layout TEXT,
  lib_vector TEXT,
  lib_screen TEXT,
  target_gene TEXT,
  target_subfragment TEXT,
  pcr_primers TEXT,
  mid TEXT,
  adapters TEXT,
  pcr_cond TEXT,
  seq_meth TEXT,
  seq_quality_check TEXT,
  chimera_check TEXT,
  tax_ident TEXT,
  assembly_qual TEXT,
  assembly_name TEXT,
  assembly_software TEXT,
  annot TEXT,
  number_contig TEXT,
  feat_pred TEXT,
  ref_db TEXT,
  sim_search_meth TEXT,
  tax_class TEXT,
  _16s_recover TEXT,
  _16s_recover_software TEXT,
  trnas TEXT,
  trna_ext_software TEXT,
  compl_score TEXT,
  compl_software TEXT,
  compl_appr TEXT,
  contam_score TEXT,
  contam_screen_input TEXT,
  contam_screen_param TEXT,
  decontam_software TEXT,
  sort_tech TEXT,
  single_cell_lysis_appr TEXT,
  single_cell_lysis_prot TEXT,
  wga_amp_appr TEXT,
  wga_amp_kit TEXT,
  bin_param TEXT,
  bin_software TEXT,
  reassembly_bin TEXT,
  mag_cov_software TEXT,
  vir_ident_software TEXT,
  pred_genome_type TEXT,
  pred_genome_struc TEXT,
  detec_type TEXT,
  otu_class_appr TEXT,
  otu_seq_comp_appr TEXT,
  otu_db TEXT,
  host_pred_appr TEXT,
  host_pred_est_acc TEXT,
  url TEXT,
  sop TEXT,
  pcr_primer_forward TEXT,
  pcr_primer_reverse TEXT,
  pcr_primer_name_forward TEXT,
  pcr_primer_name_reverse TEXT,
  pcr_primer_reference TEXT,
  DNA_sequence TEXT,
  concentration TEXT,
  concentrationUnit TEXT,
  methodDeterminationConcentrationAndRatios TEXT,
  ratioOfAbsorbance260_230 TEXT,
  ratioOfAbsorbance260_280 TEXT,
  annealingTemp TEXT,
  annealingTempUnit TEXT,
  probeReporter TEXT,
  probeQuencher TEXT,
  ampliconSize TEXT,
  thresholdQuantificationCycle TEXT,
  baselineValue TEXT,
  quantificationCycle TEXT,
  automaticThresholdQuantificationCycle TEXT,
  automaticBaselineValue TEXT,
  contaminationAssessment TEXT,
  partitionVolume TEXT,
  partitionVolumeUnit TEXT,
  estimatedNumberOfCopies TEXT,
  amplificationReactionVolume TEXT,
  amplificationReactionVolumeUnit TEXT,
  pcr_analysis_software TEXT,
  experimentalVariance TEXT,
  pcr_primer_lod TEXT,
  pcr_primer_loq TEXT
);

-- MolecularProtocolAssertion
--    An Assertion made by an Agent about a MolecularProtocol.

CREATE TABLE molecular_protocol_assertion (
  assertion_id TEXT PRIMARY KEY,
  molecular_protocol_id TEXT REFERENCES molecular_protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON molecular_protocol_assertion(molecular_protocol_id);
CREATE INDEX ON molecular_protocol_assertion(assertion_by_id);
CREATE INDEX ON molecular_protocol_assertion(assertion_protocol_id);

-- MolecularProtocolAgentRole
--    A role filled by an Agent with respect to a MolecularProtocol.

CREATE TABLE molecular_protocol_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  molecular_protocol_id TEXT REFERENCES molecular_protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  agent_role TEXT,
  agent_role_iri TEXT,
  agent_role_vocabulary TEXT,
  agent_role_order SMALLINT NOT NULL CHECK (agent_role_order >= 1) DEFAULT 1,
  agent_role_date TEXT
);
CREATE INDEX ON molecular_protocol_agent_role(agent_id);
CREATE INDEX ON molecular_protocol_agent_role(molecular_protocol_id);
ALTER TABLE molecular_protocol_agent_role ADD CONSTRAINT molecular_protocol_agent_role_unique_key 
UNIQUE (agent_id, molecular_protocol_id, agent_role, agent_role_iri, agent_role_date);

-- MolecularProtocolReference
--   A citation of a MolecularProtocol in a bibliographic reference.

CREATE TABLE molecular_protocol_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  molecular_protocol_id TEXT REFERENCES molecular_protocol ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON molecular_protocol_reference(reference_id);
CREATE INDEX ON molecular_protocol_reference(molecular_protocol_id);

-- NucleotideAnalysis
--   A link between a NucleotideSequence and a dwc:Event and a dwc:MaterialEntity from which it was derived, using a specified Protocol.

CREATE TABLE nucleotide_analysis (
  nucleotide_analysis_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  molecular_protocol_id TEXT REFERENCES molecular_protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  nucleotide_sequence_id TEXT REFERENCES nucleotide_sequence ON DELETE CASCADE DEFERRABLE NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  read_count INTEGER,
  total_read_count INTEGER
);
CREATE INDEX ON nucleotide_analysis(event_id);
CREATE INDEX ON nucleotide_analysis(molecular_protocol_id);
CREATE INDEX ON nucleotide_analysis(nucleotide_sequence_id);
CREATE INDEX ON nucleotide_analysis(material_entity_id);

-- NucleotideAnalysisAssertion
--    An Assertion made by an Agent about a NucleotideAnalysis.

CREATE TABLE nucleotide_analysis_assertion (
  assertion_id TEXT PRIMARY KEY,
  nucleotide_analysis_id TEXT REFERENCES nucleotide_analysis ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON nucleotide_analysis_assertion(nucleotide_analysis_id);
CREATE INDEX ON nucleotide_analysis_assertion(assertion_by_id);
CREATE INDEX ON nucleotide_analysis_assertion(assertion_protocol_id);

-- Identification (https://dwc.tdwg.org/terms/#identification)
--    A taxonomic determination (i.e., the assignment of dwc:Taxa to dwc:Organisms).

CREATE TABLE identification (
  identification_id TEXT PRIMARY KEY,
  based_on_occurrence_id TEXT,
  based_on_material_entity_id TEXT,
  based_on_nucleotide_sequence_id TEXT,
  based_on_nucleotide_analysis_id TEXT,
  based_on_media_id TEXT,
  identification_type TEXT,
  verbatim_identification TEXT,
  is_accepted_identification BOOLEAN,
  taxon_formula TEXT DEFAULT 'A',
  type_status TEXT,
  type_designation_type TEXT,
  identified_by TEXT,
  identified_by_id TEXT,
  date_identified TEXT,
  identification_references TEXT,
  taxon_assignment_method TEXT,
  identification_verification_status TEXT,
  identification_remarks TEXT,
  taxon_id TEXT,
  higher_classification_name TEXT,
  higher_classification_rank TEXT,
  scientific_name TEXT,
  taxon_rank TEXT,
  taxon_remarks TEXT,
  feedback_url TEXT
);
CREATE INDEX ON identification(based_on_occurrence_id);
CREATE INDEX ON identification(based_on_material_entity_id);
CREATE INDEX ON identification(based_on_nucleotide_sequence_id);
CREATE INDEX ON identification(based_on_nucleotide_analysis_id);
CREATE INDEX ON identification(based_on_media_id);
CREATE INDEX ON identification(identified_by_id);

-- IdentificationAgentRole
--    A role filled by an Agent with respect to a dwc:Identification.

CREATE TABLE identification_agent_role (
  agent_id TEXT REFERENCES agent ON DELETE CASCADE DEFERRABLE NOT NULL,
  identification_id TEXT REFERENCES identification ON DELETE CASCADE DEFERRABLE NOT NULL,
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

-- IdentificationTaxon
--    The components and positions of dwc:scientificNames in dwc:Identifications.

CREATE TABLE identification_taxon (
  identification_id TEXT REFERENCES identification ON DELETE CASCADE DEFERRABLE NOT NULL,
  taxon_id TEXT,
  taxon_sort_order SMALLINT CHECK (taxon_sort_order >= 1),
  higher_classification_name TEXT,
  higher_classification_rank TEXT,
  scientific_name TEXT NOT NULL,
  taxon_rank TEXT,
  taxon_remarks TEXT
);

-- PhylogeneticTree
--    A branching diagram that shows the evolutionary relationships between dwc:Organisms.

CREATE TABLE phylogenetic_tree (
  phylogenetic_tree_id TEXT PRIMARY KEY,
  phylogenetic_tree_protocol TEXT,
  phylogenetic_tree_protocol_id TEXT,
  phylogenetic_tree_reference TEXT,
  phylogenetic_tree_remarks TEXT
  );
CREATE INDEX ON phylogenetic_tree(phylogenetic_tree_protocol_id);

-- PhylogeneticTreeAssertion
--    An Assertion made by an Agent about a PhylogeneticTree.

CREATE TABLE phylogenetic_tree_assertion (
  assertion_id TEXT PRIMARY KEY,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON phylogenetic_tree_assertion(phylogenetic_tree_id);
CREATE INDEX ON phylogenetic_tree_assertion(assertion_by_id);
CREATE INDEX ON phylogenetic_tree_assertion(assertion_protocol_id);

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
ALTER TABLE phylogenetic_tree_identifier ADD CONSTRAINT phylogenetic_tree_identifier_unique UNIQUE (
  identifier, phylogenetic_tree_id, identifier_type, identifier_type_iri, identifier_type_vocabulary, identifier_language
);

-- PhylogeneticTreeMedia
--   A link establishing a PhylogeneticTree as content in a Media entity.

CREATE TABLE phylogenetic_tree_media (
  media_id TEXT REFERENCES media ON DELETE CASCADE DEFERRABLE NOT NULL,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  media_subject_category TEXT,
  media_subject_category_iri TEXT,
  media_subject_category_vocabulary TEXT,
  subject_part TEXT,
  subject_orientation TEXT,
  physical_setting TEXT
);
CREATE INDEX ON phylogenetic_tree_media(phylogenetic_tree_id);

-- PhylogeneticTreeProtocol
--    A link establishing a Protocol used in the determination of a PhylogeneticTree.

CREATE TABLE phylogenetic_tree_protocol (
  protocol_id TEXT REFERENCES protocol ON DELETE CASCADE DEFERRABLE NOT NULL,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON phylogenetic_tree_protocol(protocol_id);
CREATE INDEX ON phylogenetic_tree_protocol(phylogenetic_tree_id);

-- PhylogeneticTreeReference
--   A citation of a PhylogeneticTree in a bibliographic reference.

CREATE TABLE phylogenetic_tree_reference (
  reference_id TEXT REFERENCES reference ON DELETE CASCADE DEFERRABLE NOT NULL,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL
);
CREATE INDEX ON phylogenetic_tree_reference(reference_id);
CREATE INDEX ON phylogenetic_tree_reference(phylogenetic_tree_id);

-- PhylogeneticTreeTip
--    A terminal node on a phylogenetic tree.

CREATE TABLE phylogenetic_tree_tip (
  phylogenetic_tree_tip_id TEXT PRIMARY KEY,
  phylogenetic_tree_id TEXT REFERENCES phylogenetic_tree ON DELETE CASCADE DEFERRABLE NOT NULL,
  phylogenetic_tree_tip_label TEXT,
  taxon_id TEXT,
  scientific_name TEXT,
  material_entity_id TEXT,
  nucleotide_sequence_id TEXT
  );
CREATE INDEX ON phylogenetic_tree_tip(phylogenetic_tree_id);
CREATE INDEX ON phylogenetic_tree_tip(material_entity_id);
CREATE INDEX ON phylogenetic_tree_tip(nucleotide_sequence_id);

-- PhylogeneticTreeTipAssertion
--    An Assertion made by an Agent about a PhylogeneticTreeTip.

CREATE TABLE phylogenetic_tree_tip_assertion (
  assertion_id TEXT PRIMARY KEY,
  phylogenetic_tree_tip_id TEXT REFERENCES phylogenetic_tree_tip ON DELETE CASCADE DEFERRABLE NOT NULL,
  verbatim_assertion_type TEXT,
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
  assertion_protocols TEXT,
  assertion_protocol_id TEXT,
  assertion_references TEXT,
  assertion_remarks TEXT
);
CREATE INDEX ON phylogenetic_tree_tip_assertion(phylogenetic_tree_tip_id);
CREATE INDEX ON phylogenetic_tree_tip_assertion(assertion_by_id);
CREATE INDEX ON phylogenetic_tree_tip_assertion(assertion_protocol_id);

-- Relationship
--   A specification for a relationship of a subject entity to a related entity.

CREATE TABLE relationship (
  relationship_id TEXT PRIMARY KEY,
  subject_resource_id TEXT NOT NULL,
  subject_resource_type RELATIONSHIP_TARGETS NOT NULL,
  subject_resource_type_iri TEXT,
  subject_resource_type_vocabulary TEXT,
  relationship_type TEXT,
  relationship_type_iri TEXT,
  relationship_type_vocabulary TEXT,
  related_resource_id TEXT NOT NULL,
  related_resource_type RELATIONSHIP_TARGETS NOT NULL,
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
CREATE INDEX ON relationship(relationship_according_to_id);