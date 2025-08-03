# Insektmobilen test dataset for the DwC-DP publishing model
This dataset is an example of a biotic survey with target organism and land cover scopes, collections material, media, DNA metabarcoding analysis and multiple identifications.

Currently, only the output files are shared and will be updated with further information in the survey table and updated media and identification tables.

Scripts for integrity testing use the data provided in the output_data folder.

The process to test the dataset integrity for the DwC-DP publishing model is as follows:

## Create a postgreSQL database to hold the input data and the output data mapped to the DwC-DP publishing model:
```cd survey/insektmobilen```

(First time) ```createdb insektmobilen && psql insektmobilen -f ../../gbif/dwc_dp_schema.sql && psql insektmobilen -f ./schema_input_insektmobilen.sql```

(Subsequent times) ```dropdb insektmobilen && createdb insektmobilen && psql insektmobilen -f ../../gbif/dwc_dp_schema.sql && psql insektmobilen -f ./schema_input_insektmobilen.sql```

## Load the input data into the input tables in the database:
```psql insektmobilen -f load_input_insektmobilen.sql```

## Run the script to produce the publishing model tables within the same database:
```psql insektmobilen -f map_insektmobilen_input.sql```
