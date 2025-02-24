-- foreign key checking deferred due to circular dependencies
BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.ecoab_interaction_data FROM './input_data/ecoab-interaction-data.csv' WITH (FORMAT CSV, HEADER);
\copy public.ecoab_occurrence_taxa FROM './input_data/ecoab-occurrence-taxa.csv' WITH (FORMAT CSV, HEADER);
\copy public.ecoab_occurrences FROM './input_data/ecoab-occurrences.csv' WITH (FORMAT CSV, HEADER);
\copy public.ecoab_trait_data FROM './input_data/ecoab-trait-data.csv' WITH (FORMAT CSV, HEADER);

COMMIT;