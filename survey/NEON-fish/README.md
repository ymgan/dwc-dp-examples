# Survey dataset - NEON-Fish Example

This example is based on DwC-DP version 2025-06-10.

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

## Create a copy of the output tables with DwC headers rather than PSQL headers
From dwc_dp/tools run:
```python lsc_to_dwc_headers.py -i path_to/dwc-dp-examples/survey/NEON-fish/output_data/ -o path_to/dwc-dp-examples/survey/NEON-fish/output_data/```

## Create datapackage.json
From dwc_dp/tools run:
```python make_dp.py -p path_to/dwc-dp-examples/survey/NEON-fish/output_data/ -t "NEON Fish DwC-DP Survey Example" -n "NEON Fish Survey"```
