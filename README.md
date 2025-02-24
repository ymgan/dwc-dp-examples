# Data Publishing using Darwin Core Data Package (dwc-dp)
This repository provides examples of datasets structured to take advantage of the expanded capabilities of Darwin Core Data Package publishing model. There are folders for mapping examples for distinct basic types of datasets (material_gathering, observation, organism-interaction, and survey).

The postgreSQL [database schema](./gbif/dwc_dp_schema.sql) provides the structure within which to test use cases supported by dwc-dp. 

Within each basic dataset type folder is a folder for each separate dataset of that type that has been mapped. Within the dataset folders are scripts and instructions to create a copy of the database, load the input files (from the ./input_data folder), transform the data into the dwc-dp structure, and write the output files (to the ./output_data folder).

The repository contains a controlled_vocabularies folder where real-world values for terms are mapped to preferred labels that match patterns for preferred labels of Darwin Core controlled vocabularies. 

Some fields whose values are strictly controlled have TYPE ENUMS defined in the [database schema](./gbif/dwc_dp_schema.sql). For example, the term occurrence.occurrenceStatus MUST be populated with either 'present' or 'absent'.

```
CREATE TYPE OCCURRENCE_STATUS AS ENUM (
  'present',
  'absent'
);
```