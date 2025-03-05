---
-- Schema for NEON_fish input data to be mapped to dwca_v2 publishing model.
--

CREATE TABLE fsh_bulkCount (
    uid TEXT PRIMARY KEY,
    domainID TEXT,
    siteID TEXT,
    namedLocation TEXT,
    passStartTime TEXT,
    passEndTime TEXT,
    passNumber TEXT,
    eventID TEXT,
    taxonID TEXT,
    scientificName TEXT,
    morphospeciesID TEXT,
    bulkFishCount TEXT,
    actualOrEstimated TEXT,
    identificationQualifier TEXT,
    identifiedBy TEXT,
    remarks TEXT,
    publicationDate TEXT,
    release TEXT
);

CREATE TABLE fsh_fieldData (
    uid TEXT PRIMARY KEY,
    domainID TEXT,
    siteID TEXT,
    namedLocation TEXT,
    aquaticSiteType TEXT,
    decimalLatitude TEXT,
    decimalLongitude TEXT,
    coordinateUncertainty TEXT,
    elevation TEXT,
    elevationUncertainty TEXT,
    geodeticDatum TEXT,
    startDate TEXT,
    endDate TEXT,
    reachID TEXT,
    samplingProtocolVersion TEXT,
    samplingImpractical TEXT,
    reachCondition TEXT,
    measuredReachLength TEXT,
    fixedRandomReach TEXT,
    identifiedBy TEXT,
    aCollectedBy TEXT,
    bCollectedBy TEXT,
    cCollectedBy TEXT,
    remarks TEXT,
    publicationDate TEXT,
    release TEXT
);
CREATE INDEX idx_domain_id ON fsh_fieldData(domainID);
CREATE INDEX idx_site_id ON fsh_fieldData(siteID);
CREATE INDEX idx_reach_id ON fsh_fieldData(reachID);

CREATE TABLE fsh_invertBycatch (
    uid TEXT PRIMARY KEY,
    domainID TEXT,
    siteID TEXT,
    namedLocation TEXT,
    passStartTime TEXT,
    passEndTime TEXT,
    passNumber TEXT,
    eventID TEXT,
    voucherSampleID TEXT,
    voucherSampleCode TEXT,
    scientificName TEXT,
    morphospeciesID TEXT,
    morphospeciesIDRemarks TEXT,
    bulkInvertCount TEXT,
    bulkMortality TEXT,
    identificationQualifier TEXT,
    identificationReferences TEXT,
    identifiedBy TEXT,
    remarks TEXT
);
CREATE INDEX idx_invert_domain_id ON fsh_invertBycatch(domainID);
CREATE INDEX idx_invert_site_id ON fsh_invertBycatch(siteID);
CREATE INDEX idx_invert_event_id ON fsh_invertBycatch(eventID);

CREATE TABLE fsh_perFish (
    uid TEXT PRIMARY KEY,
    domainID TEXT,
    siteID TEXT,
    namedLocation TEXT,
    passStartTime TEXT,
    passEndTime TEXT,
    eventID TEXT,
    passNumber TEXT,
    specimenNumber TEXT,
    taxonID TEXT,
    scientificName TEXT,
    taxonRank TEXT,
    morphospeciesID TEXT,
    morphospeciesIDRemarks TEXT,
    identificationQualifier TEXT,
    fishTotalLength TEXT,
    fishWeight TEXT,
    delt TEXT,
    efMortality TEXT,
    efInjury TEXT,
    fishLifeStage TEXT,
    sampleTypeCollected TEXT,
    voucherSampleID TEXT,
    dnaSampleID TEXT,
    identifiedBy TEXT,
    remarks TEXT,
    publicationDate TEXT,
    release TEXT
);
CREATE INDEX idx_perfish_domain_id ON fsh_perFish(domainID);
CREATE INDEX idx_perfish_site_id ON fsh_perFish(siteID);
CREATE INDEX idx_perfish_event_id ON fsh_perFish(eventID);

CREATE TABLE fsh_perPass (
    uid TEXT PRIMARY KEY,
    domainID TEXT,
    siteID TEXT,
    namedLocation TEXT,
    passStartTime TEXT,
    passEndTime TEXT,
    passNumber TEXT,
    reachID TEXT,
    eventID TEXT,
    waterTemp TEXT,
    dissolvedOxygen TEXT,
    specificConductance TEXT,
    samplerType TEXT,
    habitatType TEXT,
    subdominantHabitatType TEXT,
    initialFrequency TEXT,
    initialDutyCycle TEXT,
    initialVoltage TEXT,
    finalFrequency TEXT,
    finalDutyCycle TEXT,
    finalVoltage TEXT,
    efTime TEXT,
    settingsChanged TEXT,
    initialFrequency2 TEXT,
    initialDutyCycle2 TEXT,
    initialVoltage2 TEXT,
    finalFrequency2 TEXT,
    finalDutyCycle2 TEXT,
    finalVoltage2 TEXT,
    efTime2 TEXT,
    settingsChanged2 TEXT,
    netIntegrity TEXT,
    netSetTime TEXT,
    netEndTime TEXT,
    netDeploymentTime TEXT,
    netLength TEXT,
    netDepth TEXT,
    targetTaxaPresent TEXT,
    remarks TEXT,
    publicationDate TEXT,
    release TEXT
);