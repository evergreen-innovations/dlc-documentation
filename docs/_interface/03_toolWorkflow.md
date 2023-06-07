---
title: Tool Workflow
permalink: /interface/toolWorkflow
sidebar:
  nav: "interface"
toc: true
toc_label: "Sections"
toc_icon: "cog"
toc_sticky: true
---

The DLC Generator tool was built to facilitate and streamline generating marine design conditions and analysis required as part of [{{site.doc-name}}]({{site.doc-link}}) Technical Specifications.

The tool aims to partially guide the user through the process of:
1. Generating design conditions and by performing statistical analysis from metocean site data. 
2. Creating surface elevation time series from the sea state parameters for use in tank testing or dynamic simulations.
3. Perform response analysis on the results of the tank testing or dynamic simulations to quantify the extreme characteristic.

# Projects 

Multiple projects can be created.  They could be for entirely different WEC devices, or the same WEC device with different potential locations of interest being set for each project.

Each project has one saved project location.  

**Deleting a project deletes all related data and cannot be undone.**

## Navigation & Progression

The left hand side of the web tool is a navigation pane, as well as a progress indication.  As certain steps are completed, more items in the navigation pane become available.

Across the top of many of the pages are a set of tabs.  Each project will have it's own tab.  The projects shown in the tabs for each step in the navigation pane depends on if a given project has progressed to that step. 

# Site Location

## Location Selection

Drag and drop the red marker or edit the coordinates and radius to change the project's location.

Selecting a data location or clicking "Save Changes" sets the project location.  This project location can be changed at any time.

At least one data location must be manually selected for each project to proceed.  The data location provides the source data for statistical analysis of the surrounding waters to obtain design load conditions.

5 data locations can be selected at a time.  Deleting locations in the table will allow for more to be selected.

**Deleting the data location being used for statistics also deletes all related data to that location and cannot be undone.**

## Raw Data Review

Get a visual representation of data available at the project site location before proceeding to data quality tests. 

Data only needs to be collected by any user once.  The entire available date range is always collected. Once the data is collected, all subsequent uses of the data no longer require gathering from external sources. The dropdown indicates if the given source has been collected yet or not.

A maximum of 10 years can be displayed on the chart to avoid delays in rendering the data.

Gathering data can take time, more so if coming from hindcast sources.  Changing tabs or moving to different pages will not stop the process. When returning the message will continue to say 10 minutes if it hasn't completed, but it has been progressing the entire time. 


# Data Selection and Quality Control

## Data Quality Tests

The [theory documentation]({{site.url}}/theory/qualityControl) describes the data quality tests and the required inputs.

Checking "Disregard" on a column, row, or cell indicates that the selected tests will not be performed for the given parameters.  For example if "Disregard" was selected for the Delta Lower Bound, checks for the minimum delta across the rolling windows would not be performed. 

### Re-cleaning Statistic Data Source

Each project has one cleaned data set saved. Re-cleaning data will replace the original data and necessitates the re-running of any statistics computed in later stages of the workflow.  The tool guides users through the process of re-saving statistics via warning messages displayed on the screen if you fall into this scenario.

## Cleaned Data Review

Visually review the results of the data cleaning process.  

Data points with the same timestamp are removed from all datasets if one of the cleaning thresholds is exceeded. For example, if a point in the {% raw %}$$H_{m0}$${% endraw %} dataset exceeds the respective range bound, the same point will be removed from the {% raw %}$$T_p$${% endraw %} and {% raw %}$$T_e$${% endraw %} datasets.


### Setting Statistical Data Source

Continuing from data cleaning to statistics sets the **single** data source for a project. 

**Changing the statistical data source will delete any saved data related to the previously selected source. The data is permanently deleted and cannot be undone.**

# Statistics

See the [theory docs]({{site.url}}/theory/stats) for details on the implementation of the statistics.

The statistics estimate the Significant Wave Height with return periods of 1 and 50 years ({% raw %}$$H_{m1}$${% endraw %} and {% raw %}$$H_{m50}$${% endraw %}), and associated Periods ({% raw %}$$T_e$${% endraw %} or {% raw %}$$T_p$${% endraw %}) to quantify the spectral parameters of different sea states.

The spectral parameters are then used to generate surface elevation time series for use in numerical modeling or tank testing.  The 1 and 50 year periods are chosen to satisfy the wave condition requirements for [{{site.doc-name}}]({{site.doc-link}}) Design Load Cases (Table 7).

# Design Load Cases

[{{site.doc-name}}]({{site.doc-link}}) Table 7 specifies wave conditions as part of the full set of Design Load Cases for each design condition. 

The tool allows for using the statistic results to realize sea states with 3 categories of wave conditions:

1. {% raw %} $$H_{m50}$$ {% endraw %}
2. {% raw %} $$H_{m1}$$ {% endraw %}
3. {% raw %} $$H_{rated}$$ {% endraw %}

It's up to the developer to read Table 7 and use the proper category of wave condition when assessing the DLC testing requirements.

Sea states are realized by generating surface elevation time series.  The spectral parameters can be re-selected, and the time series re-generated, if required.

See the [theory docs]({{site.url}}/theory/surfaceElevation) for more information on the sea state realization.

# Device Response Analysis

The device response analysis aims to help developers quantify the extreme characteristic of the loads and motions of a WEC device.

Currently, [{{site.doc-name}}]({{site.doc-link}}) specifies that the ULS (ultimate limit state) partial safety factor shall be applied to loads on the WEC. The tool performs the same analysis regardless of the type of variables being assessed, for example motions or pressures.  Judgement, alongside the {{site.doc-name}}, is required in order to determine how to use the results of the response analysis.

See the [theory docs]({{site.url}}/theory/responseAnalysis) for more information on the implementation of the response analysis.