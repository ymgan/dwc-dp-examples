# Data Publishing using Darwin Core Data Package (dwc-dp)
This repository provides examples of original datasets that have been structured (mapped) to take advantage of the expanded capabilities of [Darwin Core Data Package](https://github.com/gbif/dwc-dp/blob/master/README.md) publishing model. There are folders for mapped examples for distinct basic types of datasets (material_gathering, observation, organism-interaction, and survey).

The postgreSQL [database schema](./gbif/dwc_dp_schema.sql) provides the structure within which to test use cases supported by dwc-dp. 

Within each basic dataset type folder is a folder for each separate dataset of that type that has been mapped. Within the dataset folders are scripts and instructions to create a copy of the database, load the input files (from the ./input_data folder), transform the data into the dwc-dp structure, and write the output files (to the ./output_data folder).

Guidance on how to approach mapping a dataset to DwC-DP is given in [Data Mapping](../data-mapping.md).
