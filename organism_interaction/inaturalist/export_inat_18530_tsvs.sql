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
\COPY event_media TO './output_data/event-media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence TO './output_data/occurrence.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence_assertion TO './output_data/occurrence-assertion.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY occurrence_media TO './output_data/occurrence-media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY organism_interaction TO './output_data/organism-interaction.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY organism_interaction_media TO './output_data/organism-interaction_media.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);
\COPY identification TO './output_data/identification.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);

\COPY ( SELECT identification_id, based_on_occurrence_id, based_on_material_entity_id, based_on_nucleotide_sequence_id, based_on_nucleotide_analysis_id, based_on_media_id, identification_type, verbatim_identification, CASE WHEN is_accepted_identification THEN 'true' ELSE 'false' END AS is_accepted_identification, taxon_formula, type_status, type_designation_type, identified_by, identified_by_id, date_identified, identification_references, taxon_assignment_method, identification_verification_status, identification_remarks, taxon_id, higher_classification_name, higher_classification_rank, scientific_name, taxon_rank, taxon_remarks, feedback_url FROM identification ) TO './output_data/identification.tsv' WITH (FORMAT TEXT, DELIMITER E'\t', NULL '', HEADER);