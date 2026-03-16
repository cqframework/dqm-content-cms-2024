# dqm-content-cms-2024
Draft CMS dQM Measure Content (Using QICore 4.1.1, based on FHIR R4 v4.0.1)

> This repository is a focus repository created from ecqm-content-qicore-2024, but with only the following measures:

* Breast Cancer Screening
* Colon Cancer Screening
* Preventive Care and Screening: Depression Screening and Followup
* Controlling High Blood Pressure
* Diabetes: Glycemic Status Assessment

This repository is specifically in support of testing demonstrations to the CMS 2026 Quality Conference.

These draft FHIR-based measures and shared libraries are translated from the QDM-based versions of eCQMs that were published in May 2024 for the 2025 reporting year as they existed in MADiE as of June 2024 or later and may not reflect the current updates from the 2025 AU review cycle of the QDM measures, and have specific versions, especially for the shared libraries, appropriate to the content for that publication update.


Commits to this repository will automatically trigger a build of the continuous integration build, available here:

https://build.fhir.org/ig/cqframework/dqm-content-cms-2024

## Connectathon Scenarios

### Measure Testing

This repository is populated with FHIR-based measure specifications developed using the MADiE tool and based on published AU2024 QDM-based eCQMs. See the [Measure Content Index](https://docs.google.com/spreadsheets/d/1DocNOIX3ZYWCzOxSHw00sl21WHWx5SeazrlSCUcjqqs/edit#gid=1008487491) for a complete listing of available measure content for measure testing.

## Authoring

To author content in this implementation guide, you can use the VS Code CQL Plugin. This plugin will enable you to author, validate, and execute FHIR-based dQM content.

For instructions on setting up your environment to use the VS Code Plugin, see the [VS Code CQL Support Readme](https://github.com/cqframework/vscode-cql/blob/master/README.md)

Github Codespaces can also be used in this repository.

## Content Indexes

* [Libraries](https://build.fhir.org/ig/cqframework/dqm-content-cms-2024/libraries.html)
* [Measures](https://build.fhir.org/ig/cqframework/dqm-content-cms-2024/measures.html)
* [Artifact Summary](https://build.fhir.org/ig/cqframework/dqm-content-cms-2024/artifacts.html)

## Repository Structure

This repository is setup like any HL7 FHIR IG project but also includes the CQL files and test data which means the file structure will be as follows:

```
   |-- _genonce.bat
   |-- _genonce.sh
   |-- _refresh.bat
   |-- _refresh.sh
   |-- _updatePublisher.bat
   |-- _updatePublisher.sh
   |-- _updateCQFTooling.bat
   |-- _updateCQFTooling.sh
   |-- ig.ini
   |-- bundles
       |-- MAT
           |-- <bundle files>
       |-- measure
           |-- <bundles>
   |-- input
       |-- dqm-content-cms-2024.xml
       |-- cql
           |-- <library name>.cql
       |-- pagecontent
       |-- resources
           |-- library
               |-- <library name>.json
           |-- measure
               |-- <measure name>.json
       |-- tests
           |-- measure
               |-- <measure name>
                   |-- <test case patient id>
                       |-- <test case resource files>
                   |-- ...
       |-- vocabulary
           |-- valueset
```

## Extracting MAT Packages

The CQF Tooling provides support for extracting a MAT exported package into the
directories of this repository so that the measure is included in the published
implementation guide. To do this, place the MAT export files (unzipped) in a
directory in the `bundles\mat` directory, and then run the following tooling
command:

```
[tooling-jar] -ExtractMatBundle bundles\mat\[bundle-directory]\[bundle-file]
```

For example:

```
input-cache\tooling-cli-3.0.0.jar -ExtractMATBundle bundles\mat\CLONE124_v6_03-Artifacts\measure-json-bundle.json
```

## Refresh IG Processing

The CQF Tooling provides "refresh" tooling that performs the following functions:

* Translates and validates all CQL source files
* Packages CQL and ELM content in the corresponding FHIR resources
* Refreshes generated content for each knowledge artifact (Library, Measure, PlanDefinition, ActivityDefinition) including parameters, dependencies, and effective data requirements

Whenever changes are made to the CQL, Library, or Measure resources, run the `_refresh` command to refresh the implementation guide content with the new content, and then run `_genonce` to run the publication tooling on the implementation guide (the same process that the continuous integration build uses to publish the implementation guide when commits are made to this repository).
