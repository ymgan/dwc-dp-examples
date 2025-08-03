CREATE TABLE eventMediaTable (
  mediaid TEXT,
  eventid TEXT,
  mediasubjectcategory TEXT
);

CREATE TABLE eventTable (
  eventid TEXT,
  parenteventid TEXT,
  locationid TEXT,
  locality TEXT,
  decimallongitude NUMERIC,
  decimallatitude NUMERIC,
  datasetname TEXT,
  country TEXT,
  countrycode TEXT,
  coordinateuncertaintyinmeters TEXT,
  preferredspatialrepresentation TEXT,
  informationwithheld TEXT,
  eventeffort TEXT,
  realm TEXT,
  eventconductedbyid TEXT,
  habitat TEXT,
  footprintwkt TEXT,
  eventremarks TEXT,
  eventdate TEXT
);

CREATE TABLE identificationTable (
  identificationid TEXT,
  basedonnucleotidesequenceid TEXT,
  eventid TEXT,
  basedonmaterialentityid TEXT,
  identificationtype TEXT,
  taxonassignmentmethod TEXT,
  scientificname TEXT,
  kingdom TEXT,
  taxonrank TEXT
);

CREATE TABLE materialAssertionsTable (
  assertionid TEXT,
  materialentityid TEXT,
  assertionvaluenumeric NUMERIC,
  assertiontype TEXT,
  assertionunit TEXT
);

CREATE TABLE materialTable (
  materialentityid TEXT,
  eventid TEXT,
  materialcategory TEXT,
  materialentitytype TEXT,
  institutioncode TEXT,
  institutionid TEXT,
  ownerinstitutioncode TEXT,
  ownerinstitutionid TEXT,
  collectioncode TEXT,
  catalognumber TEXT,
  preparations TEXT,
  disposition TEXT,
  derivedfrommaterialentityid TEXT
);

CREATE TABLE mediaTable (
  mediaid TEXT,
  mediatype TEXT,
  accessuri TEXT,
  format TEXT,
  rights TEXT,
  owner TEXT,
  mediadescription TEXT
);

CREATE TABLE molecularProtocolTable (
  molecularprotocolid TEXT,
  pcr_primer_reference TEXT,
  target_gene TEXT,
  pcr_primer_forward TEXT,
  pcr_primer_reverse TEXT,
  primer_name_forward TEXT,
  primer_name_reverse TEXT,
  lib_layout TEXT,
  seq_meth TEXT,
  sop TEXT,
  assaytype TEXT
);

CREATE TABLE nucleotideAnalysisTable (
  nucleotideanalysisid TEXT,
  molecularprotocolid TEXT,
  nucleotidesequenceid TEXT,
  eventid TEXT,
  materialentityid TEXT,
  readcount INTEGER,
  totalreadcount INTEGER
);

CREATE TABLE nucleotideSequenceTable (
  nucleotidesequenceid TEXT,
  nucleotidesequence TEXT
);

CREATE TABLE occurrenceTable (
  occurrenceid TEXT,
  eventid TEXT,
  lifestage TEXT,
  vitality TEXT,
  occurrencestatus TEXT,
  scientificname TEXT,
  kingdom TEXT,
  taxonrank TEXT,
  organismquantity TEXT,
  organismquantitytype TEXT,
  surveytargetid TEXT
);

CREATE TABLE surveyTable (
  surveyid TEXT,
  eventid TEXT,
  samplingperformedbyid TEXT,
  verbatimsitenames TEXT,
  verbatimsitedescription TEXT,
  reportedweather TEXT,
  issamplingeffortreported TEXT,
  verbatimtargetscope TEXT
);

CREATE TABLE surveyTargetTable (
  surveyid TEXT,
  eventid TEXT,
  surveytargettype TEXT,
  surveytargetvalue TEXT
);
