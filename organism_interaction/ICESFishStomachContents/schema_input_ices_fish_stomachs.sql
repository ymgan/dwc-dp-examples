---
-- Schema for input data to be mapped to dwc-dp publishing model.
--

Not yet configured

-- From the original data set: https://datsu.ices.dk/web/selRep.aspx?Dataset=157
CREATE TABLE file_info (
    tblUploadID INTEGER,
    Country VARCHAR(2),
    Reporting_organisation VARCHAR(6),
    CruiseID VARCHAR(20)
);
CREATE INDEX ON file_info(tblUploadID);
CREATE INDEX ON file_info(CruiseID);

CREATE TABLE haul_info (
    tblUploadID INTEGER,
    tblHaulID INTEGER,
    Ship VARCHAR(4),
    Gear VARCHAR(15),
    HaulNo INTEGER,
    StationNumber VARCHAR(10),
    Year VARCHAR(4),
    Month VARCHAR(2),
    Day VARCHAR(2),
    Time VARCHAR(4),
    ShootLat NUMERIC(8,4),
    ShootLong  NUMERIC(8,4),
    HaulLat  NUMERIC(8,4), 
    HaulLong  NUMERIC(8,4),
    ICESrectangle VARCHAR(4),
    Depth INTEGER,
    Survey VARCHAR(20),
    ICESDatabase BOOLEAN,
    Notes VARCHAR(100)
);
CREATE INDEX ON haul_info(tblUploadID);
CREATE INDEX ON haul_info(tblHaulID);

-- Note that the input data PredatorInformation.csv has malformed lines with unescaped double quotes. These have to be fixed before copying into psql.
CREATE TABLE predator_info (
    tblUploadID INTEGER,
    tblHaulID INTEGER,
    tblPredatorInformationID INTEGER,
    Ship VARCHAR(4),
    Gear VARCHAR(15),
    HaulNo INTEGER,
    StationNumber VARCHAR(10),
    Year VARCHAR(4),
    Month VARCHAR(2),
    Day VARCHAR(2),
    Time VARCHAR(4),
    FishID VARCHAR(20),
    AphiaIDPredator INTEGER,
    IndWgt NUMERIC,
    Number INTEGER,
    MeasurementIncrement NUMERIC,
    Length NUMERIC,
    Code VARCHAR,
    Age INTEGER,
    Sex VARCHAR(1),
    MaturityScale VARCHAR(6),
    MaturityStage VARCHAR(4),
    PreservationMethod VARCHAR(8),
    Regurgitated INTEGER,
    StomachFullness VARCHAR(1),
    FullStomWgt NUMERIC,
    EmptyStomWgt NUMERIC,
    StomachEmpty INTEGER,
    GenSamp BOOLEAN,
    Notes VARCHAR(100)
);
CREATE INDEX ON predator_info(tblUploadID);
CREATE INDEX ON predator_info(tblHaulID);
CREATE INDEX ON predator_info(tblPredatorInformationID);

CREATE TABLE prey_info (
    tblUploadID INTEGER,
    tblHaulID INTEGER,
    tblPredatorInformationID INTEGER,
    tblPreyInformationID INTEGER,
    Ship VARCHAR(4),
    Gear VARCHAR(15),
    HaulNo INTEGER,
    StationNumber VARCHAR(10),
    Year VARCHAR(4),
    Month VARCHAR(2),
    Day VARCHAR(2),
    Time VARCHAR(4),
    FishID VARCHAR(20),
    AphiaIDPredator INTEGER,
    AphiaIDPrey VARCHAR(10),
    IdentMet VARCHAR(10),
    DigestionStage VARCHAR(5),
    GravMethod VARCHAR(5),
    SubFactor NUMERIC(9,4),
    PreySequence VARCHAR(10),
    Count INTEGER,
    UnitWgt VARCHAR(6),
    Weight NUMERIC,
    UnitLngt VARCHAR(6),
    Length NUMERIC,
    OtherItems VARCHAR(100),
    OtherCount INTEGER,
    OtherWgt NUMERIC,
    AnalysingOrg VARCHAR(6),
    Notes VARCHAR(100)
);
CREATE INDEX ON prey_info(tblUploadID);
CREATE INDEX ON prey_info(tblHaulID);
CREATE INDEX ON prey_info(tblPredatorInformationID);
CREATE INDEX ON prey_info(tblPreyInformationID);

-- From the Darwin Core Archive shared with OBIS: https://obis.org/dataset/7e1f81d3-fe7a-48e8-9a44-fe62c8ca302a
CREATE TABLE input_event (
    id VARCHAR,
    modified VARCHAR,
    datasetID VARCHAR,
    datasetName VARCHAR,
    dataGeneralizations VARCHAR,
    dynamicProperties VARCHAR,
    eventID VARCHAR,
    parentEventID VARCHAR,
    fieldNumber VARCHAR,
    eventDate VARCHAR,
    eventTime VARCHAR,
    startDayOfYear VARCHAR,
    endDayOfYear VARCHAR,
    year VARCHAR,
    month VARCHAR,
    day VARCHAR,
    samplingProtocol VARCHAR,
    sampleSizeValue VARCHAR,
    sampleSizeUnit VARCHAR,
    samplingEffort VARCHAR,
    eventRemarks VARCHAR,
    locationID VARCHAR,
    waterBody VARCHAR,
    country VARCHAR,
    stateProvince VARCHAR,
    county VARCHAR,
    locality VARCHAR,
    minimumElevationInMeters VARCHAR,
    maximumElevationInMeters VARCHAR,
    minimumDepthInMeters VARCHAR,
    maximumDepthInMeters VARCHAR,
    verbatimDepth VARCHAR,
    locationRemarks VARCHAR,
    decimalLatitude VARCHAR,
    decimalLongitude VARCHAR,
    geodeticDatum VARCHAR,
    coordinateUncertaintyInMeters VARCHAR,
    footprintWKT VARCHAR,
    footprintSRS VARCHAR,
    georeferenceRemarks VARCHAR
);
CREATE INDEX ON input_event(id);
CREATE INDEX ON input_event(eventID);

CREATE TABLE input_occurrence (
    id VARCHAR,
    modified VARCHAR,
    bibliographicCitation VARCHAR,
    "references" VARCHAR,
    datasetID VARCHAR,
    institutionCode VARCHAR,
    collectionCode VARCHAR,
    datasetName VARCHAR,
    basisOfRecord VARCHAR,
    dataGeneralizations VARCHAR,
    dynamicProperties VARCHAR,
    occurrenceID VARCHAR,
    catalogNumber VARCHAR,
    recordNumber VARCHAR,
    recordedBy VARCHAR,
    individualCount VARCHAR,
    organismQuantity VARCHAR,
    organismQuantityType VARCHAR,
    sex VARCHAR,
    lifeStage VARCHAR,
    occurrenceStatus VARCHAR,
    associatedMedia VARCHAR,
    associatedOccurrences VARCHAR,
    otherCatalogNumbers VARCHAR,
    occurrenceRemarks VARCHAR,
    organismID VARCHAR,
    preparations VARCHAR,
    associatedSequences VARCHAR,
    eventID VARCHAR,
    parentEventID VARCHAR,
    fieldNumber VARCHAR,
    eventDate VARCHAR,
    eventTime VARCHAR,
    startDayOfYear VARCHAR,
    endDayOfYear VARCHAR,
    year VARCHAR,
    month VARCHAR,
    day VARCHAR,
    samplingProtocol VARCHAR,
    samplingEffort VARCHAR,
    locationID VARCHAR,
    continent VARCHAR,
    country VARCHAR,
    stateProvince VARCHAR,
    county VARCHAR,
    locality VARCHAR,
    minimumElevationInMeters VARCHAR,
    maximumElevationInMeters VARCHAR,
    minimumDepthInMeters VARCHAR,
    maximumDepthInMeters VARCHAR,
    verbatimDepth VARCHAR,
    locationRemarks VARCHAR,
    decimalLatitude VARCHAR,
    decimalLongitude VARCHAR,
    geodeticDatum VARCHAR,
    coordinateUncertaintyInMeters VARCHAR,
    footprintWKT VARCHAR,
    georeferenceRemarks VARCHAR,
    verbatimIdentification VARCHAR,
    identificationQualifier VARCHAR,
    typeStatus VARCHAR,
    identifiedBy VARCHAR,
    dateIdentified VARCHAR,
    identificationReferences VARCHAR,
    identificationVerificationStatus VARCHAR,
    taxonID VARCHAR,
    scientificNameID VARCHAR,
    taxonConceptID VARCHAR,
    scientificName VARCHAR,
    higherClassification VARCHAR,
    kingdom VARCHAR,
    phylum VARCHAR,
    class VARCHAR,
    "order" VARCHAR,
    family VARCHAR,
    genus VARCHAR,
    subgenus VARCHAR,
    specificEpithet VARCHAR,
    infraspecificEpithet VARCHAR,
    scientificNameAuthorship VARCHAR
);
CREATE INDEX ON input_occurrence(id);
CREATE INDEX ON input_occurrence(occurrenceID);
CREATE INDEX ON input_occurrence(eventID);

CREATE TABLE emof (
    id VARCHAR,
    measurementID VARCHAR,
    occurrenceID VARCHAR,
    measurementType VARCHAR,
    measurementTypeID VARCHAR,
    measurementValue VARCHAR,
    measurementValueID VARCHAR,
    measurementAccuracy VARCHAR,
    measurementUnit VARCHAR,
    measurementUnitID VARCHAR,
    measurementDeterminedDate VARCHAR,
    measurementDeterminedBy VARCHAR,
    measurementMethod VARCHAR,
    measurementRemarks VARCHAR
);
CREATE INDEX ON emof(id);
CREATE INDEX ON emof(occurrenceID);
