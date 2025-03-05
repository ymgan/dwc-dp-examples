# Survey dataset - NEON-Fish Example

This dataset consists of a small subset of a Survey of Fish in streams and Lakes conducted by the US National Ecological Observatory Network (NEON).

This example dataset was extracted from the [originally released data](https://data.neonscience.org/data-products/DP1.20107.001) and from a [Darwin Core Archive version 1 mapping](https://github.com/sunray1/NEONFishtoHumboldt) of the same dataset.

The process to create the output dataset for the DwC-DP publishing model is as follows:

## Create a postgreSQL database to hold the input data and the output data mapped to the DwC-dp publishing model:
```cd survey/NEON-fish```

(First time) ```createdb neon_fish && psql neon_fish -f ../../gbif/dwc_dp_schema.sql  && psql neon_fish -f ./schema_input_neon_fish.sql```

(Subsequent times) ```dropdb neon_fish && createdb neon_fish && psql neon_fish -f ../../gbif/dwc_dp_schema.sql && psql neon_fish -f ./schema_input_neon_fish.sql && psql neon_fish -f ./schema_input_dwcav1.sql```

## Load the NEON_fish input data into the database:
```psql neon_fish -f load_input_neon_fish.sql```

## Load the Darwin Core Archive version 1 input data into the database:
```psql neon_fish -f load_input_dwcav1.sql```

## Run the script to produce the publishing model tables within the same database:
```psql neon_fish -f map_neon_fish_input.sql```

## Run the script to export the publishing model tables as TSV files:
```psql neon_fish -f export_neon_fish_tsvs.sql```

