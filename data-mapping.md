# Data Mapping

## Table of Contents
[Introduction](#introduction)<br>
[Participating and Getting Help](#participating-and-getting-help)<br>
[General Considerations](#general-considerations)
 - [Diagrams](#diagrams)
 - [Implicit Data](#implicit-data)
 - [Rearranging Data](#rearranging-data)
 - [Identifiers](#identifiers)
 - [Strictly controlled vocabularies](#strictly-controlled-vocabularies)
 - [Agents and Their Roles](#agents-and-their-roles)<br>
 
[Suggested Mapping Order](#suggested-mapping-order)

## Introduction

The Darwin Core Data Package ("DwC-DP" hereafter) is highly normalized and it may seem overwhelming at first. That is understandable. Remember that the DwC-DP is meant to be a comprehensive representation that accommodates all use cases. It may not seem the simplest way to represent the data you'll be mapping, but that is because it has to cover other perspectives as well. 

This guide is targeted at preparing CSV files that comply with the structure of the table schemas of DwC-DP. The resulting table can be used to map in a DwC-D-enabled instance of the Integrated Publishing toolkit (e.g., https://dwcdp-ipt.gbif-test.org/) or to populate a postgresql database using the DwC-DP structure we have provided in the creation script [dwc_dp_schema.sql](./gbif/dwc_dp_schema.sql), using data from your database as a source. This will require "mapping" between your structure and that of DwC-DP. 

## Participating and Getting Help
In anticipation of a formal public review, scheduled to begin 2025-09-01, we would like to invite people to gain familiarity with and test the DwC-DP by attempting to map original datasets to it. We are just beginning to work on the "Darwin Core Data Package Guide", which is intended to contain various "recipes" for publishing different types of datasets. Until that document contains useful content, the best way forward is to look at an already-mapped example dataset that is similar to the one you want to test ([gbif/dwc-dp-examples](https://github.com/gbif/dwc-dp-examples)). This community testing phase will remain open until 2025-08-01.

- **Getting started** - In addition to this document, the easiest way to start to understand DwC-DP is to look at the [Darwin Core Data Package - Quick Reference Guide](https://gbif.github.io/dwc-dp/qrg/index.html).

- **Mapping datasets to DwC-DP** - If you need help getting started with mapping a dataset to DwC-DP, see the [Data Mapping Guide](https://gbif.github.io/dwc-dp-examples/data-mapping.html). For feedback about the Guide or any of the [DwC-DP Examples](https://github.com/gbif/dwc-dp-examples/), feel free to register an [Issue](https://github.com/gbif/dwc-dp-examples/issues).

- **Issues** For feedback about the structure or documentation of DwC-DP, feel free to register an [Issue](https://github.com/gbif/dwc-dp/issues).

- **Discussion** - For open discussion on the Darwin Core Data Package, see the GBIF [Darwin Core Data Package (DwC-DP) discourse forum topic](https://discourse.gbif.org/t/darwin-core-data-package-dwc-dp/5937).

For help with an issue, feel free to contact [John Wieczorek](mailto:gtuco.btuco@gmail.com).

## General Considerations

### Diagrams

In this document we will use figures to illustrate the structure of the DwC-DP. These figures take the form of Entity-Relationship (ER) diagrams. In these diagrams, concepts or classes are implemented as tables and are denoted by boxes with labels in UpperCamelCase. The properties (fields) for these tables are listed within the box for the concept they are properties of, and are in lowerCamelCase. The figures do not necessarily show the full set of fields for the tables they represent, nor do they show data types and other constraints. For that detailed information, you should consult either the [table schemas](https://github.com/gbif/dwc-dp/tree/master/dwc-dp/0.1/table-schemas) or the [DwC-DP Quick Reference Guide](https://gbif.github.io/dwc-dp/qrg/). At times we will show snippets of the schema (such as table definitions) for reference. The definitive version of the tables to populate is in [dwc_dp_schema.sql](./gbif/dwc_dp_schema.sql). The term names in the figures (e.g., `eventType`) correspond to their equivalents in lower_snake_case in the database (e.g., `event_type`).

### Implicit Data

You will not be expected to parse the data in your database to make it fit into DwC-DP, but you will be asked in some cases to provide explicit data in DwC-DP that are only implicit in your data.

### Rearranging Data

It is likely that the source data won't have all tables to match the ones in DwC-DP, so some will need to be created, usually by separating the data in a source table to more than one table in the publishing model. For example, a source database may have collecting events and the material collected merged into a single table. This will require the table to be split to map correctly into `Events` and `Material`. 

### Identifiers

In DwC-DP tables represent concepts that are semantically separate from each other and each MUST be identified separately.

The use of record identifiers for concepts in DwC-DP is ubiquitous, and required whenever you have data that correspond to a given concept. When creating tables in DwC-DP, use resolvable global unique identifiers for the `ID` fields if you have them. If you don't, use non-resolvable global unique identifiers if you have them. If you don't, generate UUIDS as identifiers in place of the identifiers that are unique only within the scope of your database. In cases where your database does not have identifiers for records that can be inferred for DwC-DP, generate UUIDs for these identifiers. For every identifier you have to create in the place of a local one in your database, you CAN also create an `Identifier` record that translates between your local identifier and the one you created for sharing via DwC-DP. If you do this, set the `identifierType` to `local`. As an example, here is the statement from [dwc_dp_schema.sql](./gbif/dwc_dp_schema.sql) that creates the structure of the `MaterialIdentifier` table. 

```
-- MaterialIdentifier
--    An identifier for a dwc:MaterialEntity.

CREATE TABLE material_identifier (
  identifier TEXT NOT NULL,
  material_entity_id TEXT REFERENCES material ON DELETE CASCADE DEFERRABLE NOT NULL,
  identifier_type TEXT,
  identifier_type_iri TEXT,
  identifier_type_vocabulary TEXT,
  identifier_language TEXT
);
```

The `Identifier` and other "common model" tables are described in [GBIF Common Models document](https://docs.google.com/document/d/1ZTMt-V3U0D0761bqqogeN58MjuHhIs_Kisu6CRtl-uA/edit?usp=sharing) and will be discussed in context as we proceed through the [Suggested steps](#suggested-steps) for data mapping.

### Strictly controlled vocabularies

Some fields whose values are strictly controlled have TYPE ENUMS defined in the [database schema](./gbif/dwc_dp_schema.sql). For example, the term occurrence.occurrenceStatus MUST be populated with either 'detected', 'present', 'not detected', or 'absent'.

```
CREATE TYPE OCCURRENCE_STATUS AS ENUM (
  'detected',
  'present',
  'not detected',
  'absent'
);
```

### Agents and their roles

Some `Agent` roles are explicit in DwC-DP. Most of these are simply fields for the name of the `Agent` fulfilling the role (e.g., `georeferencedBy`), while others are fields for an identifier for the `Agent` (e.g., `recordedByID`. Separate `AgentRole` records are not necessary for these explicit relationships.

Several fields in DwC-DP MUST use values from a specific controlled vocabulary. In the database creation script these can be found as ENUMs. Following is an example for the strictly controlled vocabulary for the `taxon_completeness_reported` field in the `survey` table (no other values are valid):

```
CREATE TYPE TAXON_COMPLETENESS_REPORTED AS ENUM (
  'not reported',
  'reported complete',
  'reported incomplete'
);

CREATE TABLE survey (
  survey_id TEXT PRIMARY KEY,
  event_id TEXT REFERENCES event ON DELETE CASCADE DEFERRABLE NOT NULL,
  site_count SMALLINT CHECK (site_count >= 1),
  ...
  taxon_completeness_reported TAXON_COMPLETENESS_REPORTED DEFAULT 'not reported',
  ...
);
```

# Suggested Mapping Order

No dataset will require all of the tables in DwC-DP, but every table will be required by some dataset. Below is a list of the steps we suggest to follow to map your data to DwC-DP. Each step has a link to a more detailed description of what to do. The order of these steps was designed to make sure that you will already have records for tables that will be linked to in subsequent steps of the mapping process. 

You can use the list below to quickly make a checklist of the tables you want to populate. Basically, ask yourself, "Do I have data for this table?" If so, prepare that table before moving on to the next one on the list. If you encounter a table that you do not expect to populate, you can skip it and any other tables that are further indented below it. For example, if you do not have or need a separate Agent table, you can skip it plus the `AgentIdentifier` and `AgentAgentRole` tables without even looking at them. There might be additional tables in other sections of the list that you don't need to look at either. Continuing with `Media` as a second example, if you have no `Media` references in your data, you can skip the `Media` table plus the `MediaAssertion`, `MediaIdentifier`, `MediaAgentRole`, and `AgentMedia` tables (they are further indented below `Media`). You can also skip every other table in the list that has "Media" in its name (`CollectionMedia`, `EventMedia`, `ChronometricAgeMedia`, `GeologicalContextMedia`, `OccurrenceMedia`, `OrganismInteractionMedia`, `MaterialMedia`, and `PhylogeneticTreeMedia`).

You can see that, for a given dataset, you are likely end up with a very much shorter checklist of tables that you will actually populate. Proceed to populate them successively in the order you find them on the list, as tables further down the list depend on one or more tables above them on the list to have been populated.

[1. Protocol](#1-protocol)<br>
[2. Agent](#2-agent)
- [2.1 AgentIdentifier](#21-agentidentifier)
- [2.2 AgentAgentRole](#22-agentagentrole)<br>

[3. Media](#3-media)
- [3.1 MediaAssertion](#31-mediaassertion)
- [3.2 MediaIdentifier](#32-mediaidentifier)
- [3.3 MediaAgentRole](#33-mediaagentrole)
- [3.4 AgentMedia](#34-agentmedia)<br>

[4. Collection](#4-collection)
- [4.1 CollectionAssertion](#41-collectionassertion)
- [4.2 CollectionAgentRole](#42-collectionagentrole)
- [4.3 CollectionMedia](#43-collectionmedia)<br>

[5. Reference](#5-reference)
- [5.1 ProtocolReference](#51-protocolreference)<br>

[6. Event](#6-event)
- [6.1 EventAssertion](#61-eventassertion)
- [6.2 EventIdentifier](#62-eventidentifier)
- [6.3 EventAgentRole](#63-eventagentrole)
- [6.4 EventMedia](#64-eventmedia)
- [6.5 EventProtocol](#65-eventprotocol)
- [6.6 EventReference](#66-eventreference)
- [6.7 ChronometricAge](#67-chronometricage)
  - [6.7.1 ChronometricAgeAssertion](#671-chronometricageassertion)
  - [6.7.2 ChronometricAgeAgentRole](#672-chronometricageagentrole)
  - [6.7.3 ChronometricAgeMedia](#673-chronometricagemedia)
  - [6.7.4 ChronometricAgeProtocol](#674-chronometricageprotocol)
  - [6.7.5 ChronometricAgeReference](#675-chronometricagereference)
- [6.8 GeologicalContext](#68-geologicalcontext)
  - [6.8.1 GeologicalContextMedia](#681-geologicalcontextmedia)
- [6.9 Survey](#69-survey)
  - [6.9.1 SurveyTarget](#691-surveytarget)
  - [6.9.2 SurveyAssertion](#692-surveyassertion)
  - [6.9.3 SurveyIdentifier](#693-surveyidentifier)
  - [6.9.4 SurveyAgentRole](#694-surveyagentrole)
  - [6.9.5 SurveyProtocol](#695-surveyprotocol)
  - [6.9.6 SurveyReference](#696-surveyreference)
- [6.10 Occurrence](#610-occurrence)
  - [6.10.1 OccurrenceAssertion](#6101-occurrenceassertion)
  - [6.10.2 OccurrenceIdentifier](#6102-occurrenceidentifier)
  - [6.10.3 OccurrenceAgentRole](#6103-occurrenceagentrole)
  - [6.10.4 OccurrenceMedia](#6104-occurrencemedia)
  - [6.10.5 OccurrenceProtocol](#6105-occurrenceprotocol)
  - [6.10.6 OccurrenceReference](#6106-occurrencereference)
  - [6.10.7 OrganismInteraction](#6107-organisminteraction)
    - [6.10.7.1 OrganismInteractionAssertion](#61071-organisminteractionassertion)
    - [6.10.7.2 OrganismInteractionAgentRole](#61072-organisminteractionagentrole)
    - [6.10.7.3 OrganismInteractionMedia](#61073-organisminteractionmedia)
    - [6.10.7.4 OrganismInteractionReference](#61074-organisminteractionreference)<br>
    
[7. Material](#7-material)
- [7.1 MaterialAssertion](#71-materialassertion)
- [7.2 MaterialIdentifier](#72-materialidentifier)
- [7.3 MaterialAgentRole](#73-materialagentrole)
- [7.4 MaterialMedia](#74-materialmedia)
- [7.5 MaterialProtocol](#75-materialprotocol)
- [7.6 MaterialReference](#76-materialreference)<br>

[8. NucleotideSequence](#8-nucleotidesequence)<br>

[9. MolecularProtocol](#9-molecularprotocol)
- [9.1 MolecularProtocolAssertion](#91-molecularprotocolassertion)
- [9.2 MolecularProtocolAgentRole](#92-molecularprotocolagentrole)
- [9.3 MolecularProtocolReference](#93-molecularprotocolreference)<br>

[10. NucleotideAnalysis](#10-nucleotideanalysis)
- [10.1 NucleotideAnalysisAssertion](#101-nucleotideanalysisassertion)<br>

[11. Identification](#11-identification)
- [11.1 IdentificationAgentRole](#111-identificationagentrole)
- [11.2 IdentificationTaxon](#112-identificationtaxon)

[12. PhylogeneticTree](#12-phylogenetictree)
- [12.1 PhylogeneticTreeAssertion](#121-phylogenetictreeassertion)
- [12.2 PhylogeneticTreeIdentifier](#122-phylogenetictreeidentifier)
- [12.3 PhylogeneticTreeMedia](#123-phylogenetictreemedia)
- [12.4 PhylogeneticTreeProtocol](#124-phylogenetictreeprotocol)
- [12.5 PhylogeneticTreeReference](#125-phylogenetictreereference)
- [12.6 PhylogeneticTreeTip](#126-phylogenetictreetip)
- [12.6.1 PhylogeneticTreeTipAssertion](#1261-phylogenetictreetipassertion)<br>

[13. Relationship](#13-relationship)

## 1. Protocol
## 2. Agent
### 2.1 AgentIdentifier
### 2.2 AgentAgentRole
## 3. Media
### 3.1 MediaAssertion
### 3.2 MediaIdentifier
### 3.3 MediaAgentRole
### 3.4 AgentMedia
## 4. Collection
### 4.1 CollectionAssertion
### 4.2 CollectionAgentRole
### 4.3 CollectionMedia
## 5. Reference
### 5.1 ProtocolReference
## 6. Event
### 6.1 EventAssertion
### 6.2 EventIdentifier
### 6.3 EventAgentRole
### 6.4 EventMedia
### 6.5 EventProtocol
### 6.6 EventReference
### 6.7 ChronometricAge
#### 6.7.1 ChronometricAgeAssertion
#### 6.7.2 ChronometricAgeAgentRole
#### 6.7.3 ChronometricAgeMedia
#### 6.7.4 ChronometricAgeProtocol
#### 6.7.5 ChronometricAgeReference
### 6.8 GeologicalContext
#### 6.8.1 GeologicalContextMedia
### 6.9 Survey
#### 6.9.1 SurveyTarget
#### 6.9.2 SurveyAssertion
#### 6.9.3 SurveyIdentifier
#### 6.9.4 SurveyAgentRole
#### 6.9.5 SurveyProtocol
#### 6.9.6 SurveyReference
### 6.10 Occurrence
#### 6.10.1 OccurrenceAssertion
#### 6.10.2 OccurrenceIdentifier
#### 6.10.3 OccurrenceAgentRole
#### 6.10.4 OccurrenceMedia
#### 6.10.5 OccurrenceProtocol
#### 6.10.6 OccurrenceReference
#### 6.10.7 OrganismInteraction
##### 6.10.7.1 OrganismInteractionAssertion
##### 6.10.7.2 OrganismInteractionAgentRole
##### 6.10.7.3 OrganismInteractionMedia
##### 6.10.7.4 OrganismInteractionReference
## 7. Material
### 7.1 MaterialAssertion
### 7.2 MaterialIdentifier
### 7.3 MaterialAgentRole
### 7.4 MaterialMedia
### 7.5 MaterialProtocol
### 7.6 MaterialReference
## 8. NucleotideSequence
## 9. MolecularProtocol
### 9.1 MolecularProtocolAssertion
### 9.2 MolecularProtocolAgentRole
### 9.3 MolecularProtocolReference
## 10. NucleotideAnalysis
### 10.1 NucleotideAnalysisAssertion
## 11. Identification
### 11.1 IdentificationAgentRole
### 11.2 IdentificationTaxon
## 12. PhylogeneticTree
### 12.1 PhylogeneticTreeAssertion
### 12.2 PhylogeneticTreeIdentifier
### 12.3 PhylogeneticTreeMedia
### 12.4 PhylogeneticTreeProtocol
### 12.5 PhylogeneticTreeReference
### 12.6 PhylogeneticTreeTip
#### 12.6.1 PhylogeneticTreeTipAssertion
## 13. Relationship
