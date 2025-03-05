-- foreign key checking deferred due to circular dependencies
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.dwcav1_event FROM './input_data/dwcav1/event.csv' WITH DELIMITER E',' CSV HEADER;
\copy public.dwcav1_dna_derived_data FROM './input_data/dwcav1/dnaDerivedData.csv' WITH DELIMITER E',' CSV HEADER;

COMMIT;