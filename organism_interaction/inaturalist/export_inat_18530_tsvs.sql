-- Export the output table to TSV files
-- Table Checklist
-- +3. Media
-- +6. Event
-- +6.4 EventMedia
-- +6.10 Occurrence
-- +6.10.1 OccurrenceAssertion
-- +6.10.4 OccurrenceMedia
-- +6.10.7 OrganismInteraction
-- +6.10.7.3 OrganismInteractionMedia
-- +11. Identification

\COPY media TO './output_data/media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY event TO './output_data/event.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY event_media TO './output_data/event_media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence TO './output_data/occurrence.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence_assertion TO './output_data/occurrence_assertion.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence_media TO './output_data/occurrence_media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY organism_interaction TO './output_data/organism_interaction.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY organism_interaction_media TO './output_data/organism_interaction_media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY identification TO './output_data/identification.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
