BEGIN;
SET CONSTRAINTS ALL DEFERRED;

\copy public.agent_identifier FROM './input_data/datapackage-download/agent-identifier.csv' WITH (FORMAT CSV, HEADER);
\copy public.agent FROM './input_data/datapackage-download/agent.csv' WITH (FORMAT CSV, HEADER);
\copy public.event_assertion FROM './input_data/datapackage-download/event-assertion.csv' WITH (FORMAT CSV, HEADER);
\copy public.event FROM './input_data/datapackage-download/event.csv' WITH (FORMAT CSV, HEADER);
\copy public.identification FROM './input_data/datapackage-download/identification.csv' WITH (FORMAT CSV, HEADER, NULL '');
\copy public.material_assertion FROM './input_data/datapackage-download/material-assertion.csv' WITH (FORMAT CSV, HEADER);
\copy public.material_media FROM './input_data/datapackage-download/material-media.csv' WITH (FORMAT CSV, HEADER);
\copy public.material FROM './input_data/datapackage-download/material.csv' WITH (FORMAT CSV, HEADER);
\copy public.media FROM './input_data/datapackage-download/media.csv' WITH (FORMAT CSV, HEADER);
\copy public.occurrence FROM './input_data/datapackage-download/occurrence.csv' WITH (FORMAT CSV, HEADER);
\copy public.protocol FROM './input_data/datapackage-download/protocol.csv' WITH (FORMAT CSV, HEADER);
\copy public.survey_protocol FROM './input_data/datapackage-download/survey-protocol.csv' WITH (FORMAT CSV, HEADER);
\copy public.survey_target FROM './input_data/datapackage-download/survey-target.csv' WITH (FORMAT CSV, HEADER);
\copy public.survey FROM './input_data/datapackage-download/survey.csv' WITH (FORMAT CSV, HEADER);

COMMIT;