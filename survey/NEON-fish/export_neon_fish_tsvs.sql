-- Export the output table to TSV files
\COPY event_assertion TO './output_data/event_assertion.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY event TO './output_data/event.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY genetic_sequence TO './output_data/genetic_sequence.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY identification TO './output_data/identification.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY material TO './output_data/material.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence TO './output_data/occurrence.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence_assertion TO './output_data/occurrence_assertion.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY survey TO './output_data/survey.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
