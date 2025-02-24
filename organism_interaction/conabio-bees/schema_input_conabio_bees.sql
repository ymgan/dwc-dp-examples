---
-- Schema for input data to be mapped to dwca_v2 publishing model.
--

CREATE TABLE ecoab_interaction_data (
    occurrenceID TEXT,
    relatedResourceID TEXT,
    resourceID TEXT,
    relationshipOfResource TEXT,
    relationshipOfResourceID TEXT
);
CREATE INDEX idx_occurrenceID ON ecoab_interaction_data(occurrenceID);
CREATE INDEX idx_relatedResourceID ON ecoab_interaction_data(relatedResourceID);
CREATE INDEX idx_resourceID ON ecoab_interaction_data(resourceID);

CREATE TABLE ecoab_occurrence_taxa (
    taxonID TEXT PRIMARY KEY,
    scientificName TEXT,
    taxonRank TEXT,
    kingdom TEXT,
    phylum TEXT,
    "class" TEXT,    
    "order" TEXT,
    family TEXT,
    genus TEXT,
    verbatimScientificName TEXT
);

CREATE TABLE ecoab_occurrences (
    occurrenceID TEXT PRIMARY KEY,
    collectionCode TEXT,
    catalogNumber TEXT,
    year SMALLINT,
    month SMALLINT,
    day SMALLINT,
    locationID TEXT,
    country TEXT,
    stateProvince TEXT,
    municipality TEXT,
    locality TEXT,
    decimalLatitude NUMERIC,
    decimalLongitude NUMERIC,
    minimumElevationInMeters NUMERIC,
    recordedByID TEXT,
    recordedBy TEXT,
    taxonID TEXT,
    identifiedByID TEXT,
    identifiedBy TEXT,
    eventDate TEXT,
    sex TEXT
);
CREATE INDEX idx_taxonID ON ecoab_occurrences(taxonID);

CREATE TABLE ecoab_trait_data (
    index TEXT,
    taxonID TEXT,
    measurementType TEXT,
    measurementValue TEXT
);
CREATE INDEX idx_trait_taxonID ON ecoab_trait_data(taxonID);
