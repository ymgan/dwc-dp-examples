-- Foreign key checking deferred due to circular dependencies

BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.input_agent FROM './input_data/agent.csv' WITH (FORMAT CSV, HEADER);
\copy public.input_event FROM './input_data/event.csv' WITH (FORMAT CSV, HEADER);
\copy public.input_material FROM './input_data/material.csv' WITH (FORMAT CSV, HEADER);
\copy public.input_media FROM './input_data/media.csv' WITH (FORMAT CSV, HEADER);
\copy public.input_occurrence_agent_role FROM './input_data/occurrence-agent-role.csv' WITH (FORMAT CSV, HEADER);
\copy public.input_occurrence_media FROM './input_data/occurrence-media.csv' WITH (FORMAT CSV, HEADER);
\copy public.input_occurrence FROM './input_data/occurrence.csv' WITH (FORMAT CSV, HEADER);

COMMIT;