-- Foreign key checking deferred due to circular dependencies

-- iconv -f UTF-16LE -t UTF-8 ./input_data/agent.txt > ./input_data/agent_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/event.txt > ./input_data/event_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/identification.txt > ./input_data/identification_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material_assertion.txt > ./input_data/material_assertion_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material_identifier.txt > ./input_data/material_identifier_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material_media.txt > ./input_data/material_media_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material.txt > ./input_data/material_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/media.txt > ./input_data/media_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/nucleotide_analysis.txt > ./input_data/nucleotide_analysis_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/nucleotide_sequence.txt > ./input_data/nucleotide_sequence_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/occurrence_media.txt > ./input_data/occurrence_media_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/occurrence.txt > ./input_data/occurrence_utf8.txt

BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.input_agent FROM './input_data/agent_utf8.txt' WITH (FORMAT CSV, HEADER);
--\copy public.input_event FROM './input_data/event_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.temp_event FROM './input_data/event_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_identification FROM './input_data/identification_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material_assertion FROM './input_data/material_assertion_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material_identifier FROM './input_data/material_identifier_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material_media FROM './input_data/material_media_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material FROM './input_data/material_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_media FROM './input_data/media_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_nucleotide_analysis FROM './input_data/nucleotide_analysis_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_nucleotide_sequence FROM './input_data/nucleotide_sequence_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_occurrence_media FROM './input_data/occurrence_media_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_occurrence FROM './input_data/occurrence_utf8.txt' WITH (FORMAT CSV, HEADER);

COMMIT;