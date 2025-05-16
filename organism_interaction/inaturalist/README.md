# iNaturalist organism interaction test dataset for the DwC-DP publishing model

This is dataset is an example of dwc:Organism interactions, with observations captured by the iNaturalist Project 18530.

The process to create the output dataset for the DwC-DP publishing model is as follows:

## Create a postgreSQL database to hold the input data and the output data mapped to the DwC-DP publishing model:
```cd organism_interaction/inaturalist```

(First time) ```createdb inat_18530 && psql inat_18530 -f ../../gbif/dwc_dp_schema.sql && psql inat_18530 -f ./schema_input_inat.sql```

(Subsequent times) ```dropdb inat_18530 && createdb inat_18530 && psql inat_18530 -f ../../gbif/dwc_dp_schema.sql && psql inat_18530 -f ./schema_input_inat.sql```

## Load the input data into the input tables in the database:
```psql inat_18530 -f load_input_inat.sql```

## Run the script to produce the publishing model tables within the same database:
```psql inat_18530 -f map_inat_input.sql```

## Run the script to export the publishing model tables as TSV files:
```psql conabio_bees -f export_conabio_bees_tsvs.sql```

