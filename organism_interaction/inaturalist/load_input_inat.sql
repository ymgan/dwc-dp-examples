-- foreign key checking deferred due to circular dependencies
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.observations FROM './input_data/inat_interactions.csv' WITH (FORMAT CSV, HEADER);

COMMIT;