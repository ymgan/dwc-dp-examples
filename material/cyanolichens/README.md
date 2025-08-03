# Integrated Dataset of Fungi Associated with Peltigera Cyanolichens from Southern Chile test dataset for the DwC-DP publishing model

This is dataset is an example of a collection with media.

This integrated dataset compiles fungal diversity data associated with Peltigera cyanolichens collected across southern Chile by the Microbial Ecology Lab at Universidad de Chile. It merges three occurrence resources: (1) a collection of over 1,000 Peltigera lichen thalli sampled from diverse environments, with molecular identification of the main symbionts; (2) 180 basidiomycete yeasts; and (3) 45 ascomycete fungi, both isolated from a subset of the previously collected Peltigera thalli. The isolates were identified by sequencing the ITS marker and through subsequent phylogenetic analyses. The purpose of creating this integrated resource was to test and explore the structure and flexibility of the new Darwin Core data format, using a case study that links macro- and micro-organismal diversity within lichen symbioses. Note: - All data included here are publicly available and were originally published as three separate datasets: https://doi.org/10.15468/ef76hj, https://doi.org/10.15468/ceh6sr, and https://doi.org/10.15468/hw7k9r. - Please note that some data inconsistencies or errors may be present and could be addressed in future updates. - The use and integration of these datasets have been authorized by Yosbany Pérez and Julieta Orlando.

The data used for the mapping test in this repository were shared via https://dwcdp-ipt.gbif-test.org/resource?r=pelt_yeast_fungi. A copy of those data was made in the [input data folder](../input_data).

The process to create the output dataset for the DwC-DP publishing model is as follows:

## Create a postgreSQL database to hold the input data and the output data mapped to the DwC-DP publishing model:
```cd material/cyanolichens```

(First time) ```createdb cyanolichens && psql cyanolichens -f ../../gbif/dwc_dp_schema.sql && psql cyanolichens -f ./schema_input_cyanolichens.sql```

(Subsequent times) ```dropdb cyanolichens && createdb cyanolichens && psql cyanolichens -f ../../gbif/dwc_dp_schema.sql && psql cyanolichens -f ./schema_input_cyanolichens.sql```

## Load the input data into the input tables in the database:
```psql cyanolichens -f load_input_cyanolichens.sql```

## Run the script to produce the publishing model tables within the same database:
```psql bgbm -f map_bgbm_input.sql```

## Run the script to export the publishing model tables as TSV files:
```psql bgbm -f export_bgbm_tsvs.sql```

The Darwin Core Data Package from the IPT was also copied and can be found in the [data package download folder](../input/datapackage-download).

Do the following to test the integrity of the IPT-produced Darwin Core Data Package directly against the [database schema](../../gbif/dwc_dp_schema.sql):

## Create a postgreSQL database to hold the DwC-DP data and the output data mapped to the DwC-DP publishing model:
```cd material/bgbm```

(First time) ```createdb bgbm && psql bgbm -f ../../gbif/dwc_dp_schema.sql```

(Subsequent times) ```dropdb bgbm && createdb bgbm && psql bgbm -f ../../gbif/dwc_dp_schema.sql```

## Load the DwC-DP data directly into the tables in the database:
```psql bgbm -f load_dwc-dp_bgbm.sql```
