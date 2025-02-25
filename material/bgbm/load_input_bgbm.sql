-- Foreign key checking deferred due to circular dependencies

-- Row 3 of occurrence.txt has an unquoted string with commas in it. Quote those before 
-- converting to utf8.

-- Rows 6 and 7 in identification.txt are invalid duplications of row 3. Row 8 is an 
-- invalid duplication of row 1. The duplicates should either be removed or have 
-- isAcceptedIdentification set to False. I did the latter in the file 
-- ./input_data/identification_utf8.txt for this mapping test.

-- iconv -f UTF-16LE -t UTF-8 ./input_data/agent.txt > ./input_data/agent_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/collection.txt > ./input_data/collection_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/event.txt > ./input_data/event_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/genetic_sequence.txt > ./input_data/genetic_sequence_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/identification.txt > ./input_data/identification_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material_assertion.txt > ./input_data/material_assertion_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material_identifier.txt > ./input_data/material_identifier_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material_media.txt > ./input_data/material_media_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/material.txt > ./input_data/material_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/media.txt > ./input_data/media_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/occurrence_media.txt > ./input_data/occurrence_media_utf8.txt
-- iconv -f UTF-16LE -t UTF-8 ./input_data/occurrence.txt > ./input_data/occurrence_utf8.txt

BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.input_agent FROM './input_data/agent_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_collection FROM './input_data/collection_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_event FROM './input_data/event_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_genetic_sequence FROM './input_data/genetic_sequence_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_identification FROM './input_data/identification_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material_assertion FROM './input_data/material_assertion_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material_identifier FROM './input_data/material_identifier_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material_media FROM './input_data/material_media_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_material FROM './input_data/material_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_media FROM './input_data/media_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_occurrence_media FROM './input_data/occurrence_media_utf8.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_occurrence FROM './input_data/occurrence_utf8.txt' WITH (FORMAT CSV, HEADER);

COMMIT;