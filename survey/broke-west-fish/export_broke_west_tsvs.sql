-- Export the output table to TSV files
\COPY agent_identifier TO './output_data/agent_identifier.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY agent TO './output_data/agent.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY event_assertion TO './output_data/event_assertion.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY event TO './output_data/event.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY identification TO './output_data/identification.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY material_assertion TO './output_data/material_assertion.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY material_media TO './output_data/material_media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY material TO './output_data/material.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY media TO './output_data/media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence TO './output_data/occurrence.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY protocol TO './output_data/protocol.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY survey_protocol TO './output_data/survey_protocol.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY survey_target TO './output_data/survey_target.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY survey TO './output_data/survey.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
