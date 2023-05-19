---
title: Tool Workflow
permalink: /documentation/toolWorkflow
sidebar:
  nav: "documentation"
toc: true
toc_label: "Sections"
toc_icon: "cog"
toc_sticky: true
---

The DLC Generator tool was built to facilitate and streamline generating marine design conditions and analysis required as part of [{{site.doc-name}}]({{site.doc-link}}) technical specifications.

The tool aims to partially guide the user through the process of:
1. Generating design conditions and by performing statistical analysis from met-ocean site data 
2. Creating surface elevation time series from the site data for use in tank testing or dynamic simulations
3. Perform response analysis on the results of the tank testing or dynamic simulations to quantify the extreme characteristic

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

Setting a project location allows you to select data locations for the given project.  This project location can be changed at any time.

At least one data location must be manually selected for each project to proceed.  The data location provides the source data for statistical analysis of the surrounding waters to obtain design load conditions.

5 data locations can be selected at a time.  Deleting locations in the table will allow for more to be selected.

**Deleting the data location being used for statistics also deletes all related data to that location and cannot be undone.**

## Raw Data Review

Get a visual representation of data available for your site before proceeding to data quality tests.  

The entire date range available is always collected from external sources. The date selection only effects what is rendered on the time series chart. The 10 year limitation is related to the amount of data transferred to display > 10 years of data at potentially 30 minute temporal resolution.

Gathering data can take time, more so if coming from hindcast sources.  You can change tabs or move to different pages without stopping the process. When returning the message will continue to say 10 minutes if it hasn't completed, but it has been progressing the entire time. 

# Data Selection and Quality Control

## Data Quality Tests

See the [theory docs]({{site.url}}/theory/qualityControl) for descriptions of what the tests do and how the inputs effect them.

Checking null on a column, row, or cell indicates that the selected tests will not be performed for the given parameters.  For example, selecting null for the Delta Lower Bound row would make it so the tests don't look for a minimum delta across the rolling windows. 

### Re-cleaning Statistic Data Source

Each project has one cleaned data set saved. Re-cleaning data will replace this and require you to re-run statistics or what the tool reports may appear to be off.

If stats aren't re-calculated, the data in the background of any contour chart may be incorrect. The contour lines are saved when you select them, and until you re-run and re-save your statistics you'll see the newly cleaned data with the old contour line drawn across it. 

Sometimes the tool reports your saved univariate spectral parameters, but needs to re-calculate the data for the Q-Q plot.  These may not align if you don't re-calculate your statistics after re-cleaning a data set.

The tool guides you through the process of re-saving statistics via warning messages displayed on the screen if you fall into this scenario.

## Cleaned Data Review

Visually Review the results of the data cleaning process.  

When a data point is dropped due to a particular cleaning reason ({% raw %}$$H_{m0}$${% endraw %} range bound for example), {% raw %}$$T_p$${% endraw %} and {% raw %}$$T_e$${% endraw %} for that given time step are also dropped.

### Setting Statistical Data Source

Continuing from data cleaning to statistics sets the **single** data source for a project. 

**Changing the statistical data source will delete any saved data related to the previously selected source. The data is permanently deleted and cannot be undone.**

# Statistics

See the [theory docs]({{site.url}}/theory/stats) for details on the implementation of the statistics.

The statistics estimate the Significant Wave Height with return periods of 1 and 50 years ({% raw %}$$H_{m1}$${% endraw %} and {% raw %}$$H_{m50}$${% endraw %}), and associated Periods ({% raw %}$$T_e$${% endraw %} or {% raw %}$$T_p$${% endraw %}) to quantify the spectral parameters of different sea states.

The spectral parameters are then used to generate surface elevation time series for use in numerical modeling or tank testing to satisfy the wave condition requirements for [{{site.doc-name}}]({{site.doc-link}}) Design Load Cases (Table 7).

If the resulting sea states available from statistics aren't desireable, you can always go back and select a different data location.

# Design Load Cases

[{{site.doc-name}}]({{site.doc-link}}) Table 7 specifies wave conditions as part of the full set of Design Load Cases for each design condition. 

The tool allows for using the statistic results to realize sea states with 3 categories of wave conditions:

1. {% raw %} $$H_{m50}$$ {% endraw %}
2. {% raw %} $$H_{m1}$$ {% endraw %}
3. {% raw %} $$H_{rated}$$ {% endraw %}

It's up to the developer to read Table 7 and use the proper category of wave condition when assessing the DLC testing requirements.

Sea states are realized by generating surface elevation time series.  While generating the time series, if you're not happy with the spectral parameters available from the selected statistic analysis, you can always go back and edit the stat selections.  

See the [theory docs]({{site.url}}/theory/surfaceElevation) for more information on the sea state realization.

# Device Response Analysis

The device response analysis aims to help developers quantify the extreme characteristic of the loads and motions of a WEC device.

Currently, [{{site.doc-name}}]({{site.doc-link}}) specifies that the ULS (ultimate limit state) partial safety factor shall be applied to loads on the WEC. The tool performs the same analysis regardless of the type of variables being assessed.  Use your best judgement and {{site.doc-name}} in order to determine how to use the results of the response analysis.

See the [theory docs]({{site.url}}/theory/responseAnalysis) for more information on the implementation of the response analysis.