-- foreign key checking deferred due to circular dependencies
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.fsh_bulkCount FROM './input_data/NEON_fish/fsh_bulkCount.csv' WITH DELIMITER E',' CSV HEADER;
\copy public.fsh_fieldData FROM './input_data/NEON_fish/fsh_fieldData.csv' WITH DELIMITER E',' CSV HEADER;
\copy public.fsh_invertBycatch FROM './input_data/NEON_fish/fsh_invertBycatch.csv' WITH DELIMITER E',' CSV HEADER;
\copy public.fsh_perFish FROM './input_data/NEON_fish/fsh_perFish.csv' WITH DELIMITER E',' CSV HEADER;
\copy public.fsh_perPass FROM './input_data/NEON_fish/fsh_perPass.csv' WITH DELIMITER E',' CSV HEADER;

COMMIT;