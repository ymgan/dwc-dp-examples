-- Foreign key checking deferred due to circular dependencies

BEGIN;
SET CONSTRAINTS ALL DEFERRED;

-- missing relatedAgentID in agent_agent_role table.
--\copy public.input_agent_agent_role FROM './input_data/agent_agent_role.txt' WITH (FORMAT CSV, HEADER);
\copy public.input_agent_identifier FROM './input_data/agent_identifier.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_agent FROM './input_data/agent.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_event_assertion FROM './input_data/event_assertion.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_event FROM './input_data/event.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_identification FROM './input_data/identification.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_material_assertion FROM './input_data/material_assertion.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_material_media FROM './input_data/material_media.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_material FROM './input_data/material.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_media FROM './input_data/media.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_occurrence FROM './input_data/occurrence.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_protocol FROM './input_data/protocol.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_survey_protocol FROM './input_data/survey_protocol.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_survey_target FROM './input_data/survey_target.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);
\copy public.input_survey FROM './input_data/survey.txt' WITH (DELIMITER E'\t', FORMAT CSV, HEADER);

COMMIT;