# CONABIO Bees dataset for the DwCA-DP publishing model

This is dataset is an example of dwc:Organism interactions, with collected bees and observations for the plants they visited.

Original data are shared in https://github.com/gbif/model-material/tree/master/conabio-bees/original-data.

An original dataset restructured for the Unified Model version 4.5 is shared in https://github.com/gbif/model-material/tree/master/conabio-bees/data-products. A copy of those data was made in the [input data folder](../input_data).

The process to create the output dataset for the DwC-DP publishing model is as follows:

## Create a postgreSQL database to hold the input data and the output data mapped to the DwC-DP publishing model:
```cd organism_interaction/conabio-bees```

(First time) ```createdb conabio_bees && psql conabio_bees -f ../../gbif/dwc_dp_schema.sql && psql conabio_bees -f ./schema_input_conabio_bees.sql```

(Subsequent times) ```dropdb conabio_bees && createdb conabio_bees && psql conabio_bees -f ../../gbif/dwc_dp_schema.sql && psql conabio_bees -f ./schema_input_conabio_bees.sql```

## Load the input data into the conabio_bees database:
```psql conabio_bees -f load_input_conabio_bees.sql```

## Run the script to produce the publishing model tables within the same database:
```psql conabio_bees -f map_conabio_bees_input.sql```

## Run the script to export the publishing model tables as TSV files:
```psql conabio_bees -f export_conabio_bees_tsvs.sql```

