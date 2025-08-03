BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.agent FROM './input_data/datapackage-download/agent.csv' WITH (FORMAT CSV, HEADER);
\copy public.event FROM './input_data/datapackage-download/event.csv' WITH (FORMAT CSV, HEADER);
\copy public.identification FROM './input_data/datapackage-download/identification.csv' WITH (FORMAT CSV, HEADER);
\copy public.material_assertion FROM './input_data/datapackage-download/material-assertion.csv' WITH (FORMAT CSV, HEADER);
\copy public.material_identifier FROM './input_data/datapackage-download/material-identifier.csv' WITH (FORMAT CSV, HEADER);
\copy public.material_media FROM './input_data/datapackage-download/material-media.csv' WITH (FORMAT CSV, HEADER);
\copy public.material FROM './input_data/datapackage-download/material.csv' WITH (FORMAT CSV, HEADER);
\copy public.media FROM './input_data/datapackage-download/media.csv' WITH (FORMAT CSV, HEADER);
\copy public.nucleotide_analysis FROM './input_data/datapackage-download/nucleotide-analysis.csv' WITH (FORMAT CSV, HEADER);
\copy public.nucleotide_sequence FROM './input_data/datapackage-download/nucleotide-sequence.csv' WITH (FORMAT CSV, HEADER);
\copy public.occurrence_media FROM './input_data/datapackage-download/occurrence-media.csv' WITH (FORMAT CSV, HEADER);
\copy public.occurrence FROM './input_data/datapackage-download/occurrence.csv' WITH (FORMAT CSV, HEADER);

COMMIT;