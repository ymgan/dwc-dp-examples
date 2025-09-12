# ICES Fish stomach content test dataset for the DwC-DP publishing model

This example is based on DwC-DP version 2025-06-10.

This dataset is an example of dwc:Organism interactions based on stomach contents.

The original source data was acquired from https://datsu.ices.dk/web/selRep.aspx?Dataset=157.

The process to create the output dataset for the DwC-DP publishing model is as follows:

## Create a postgreSQL database to hold the input data and the output data mapped to the DwC-DP publishing model:
```cd organism_interaction/ICESFishStomachContents```

(First time) ```createdb ices_fish_stomachs && psql ices_fish_stomachs -f ../../gbif/dwc_dp_schema.sql && psql ices_fish_stomachs -f ./schema_input_ices_fish_stomachs.sql```

(Subsequent times) ```dropdb ices_fish_stomachs && createdb ices_fish_stomachs && psql ices_fish_stomachs -f ../../gbif/dwc_dp_schema.sql && psql ices_fish_stomachs -f ./schema_input_ices_fish_stomachs.sql```

## Load the input data into the input tables in the database:
```psql ices_fish_stomachs -f load_input_ices_fish_stomachs.sql```

## Run the script to produce the publishing model tables within the same database:
```psql ices_fish_stomachs -f map_ices_fish_stomachs_input.sql```

## Run the script to export the publishing model tables as TSV files:
```psql ices_fish_stomachs -f export_ices_fish_stomachs_tsvs.sql```

## Create a copy of the output tables with DwC headers rather than PSQL headers
From dwc_dp/tools run:
```python lsc_to_dwc_headers.py -i path_to/dwc-dp-examples/organism_interaction/inaturalist/output_data/ -o path_to/dwc-dp-examples/organism_interaction/inaturalist/output_data/```

## Create datapackage.json
From dwc_dp/tools run:
```python make_dp.py -p path_to/dwc-dp-examples/organism_interaction/inaturalist/output_data/ -t "iNaturalist DwC-DP OrganismInteraction Example" -n "iNat OrganismInteraction"```
