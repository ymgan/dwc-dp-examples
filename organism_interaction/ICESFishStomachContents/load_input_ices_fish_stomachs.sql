-- foreign key checking deferred due to circular dependencies
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.file_info FROM './input_data/File_information.csv' WITH (FORMAT CSV, HEADER);
\copy public.haul_info FROM './input_data/HaulInformation.csv' WITH (FORMAT CSV, HEADER);
-- Note that the input data PredatorInformation.csv has malformed lines with unescaped double quotes. These have to be fixed before copying into psql.
\copy public.predator_info FROM './input_data/PredatorInformation_fixed.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"')
\copy public.prey_info FROM './input_data/PreyInformation.csv' WITH (FORMAT CSV, HEADER);
\copy public.input_event FROM './input_data/event.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_occurrence FROM './input_data/occurrence.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.emof FROM './input_data/extendedmeasurementorfact.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);

COMMIT;