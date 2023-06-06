---
title: "Tool Disclaimers"
permalink: /disclaimers/
classes: wide2
toc: true
toc_label: "Sections"
toc_icon: "cog"
toc_sticky: true
breadcrumbs: false
---

# {{site.doc-name}}

The DLC Generator aims to help a WEC developer through generating wave conditions for WEC DLC's following [{{site.doc-name}}]({{site.doc-link}}) specifications.  This tool is not created by the authors of {{site.doc-name}} and assumes all users have a valid copy of the technical specification. 

{{site.doc-name}} has caveats, special cases, and allows for the developers specific scenarios to outweigh particular requirements.  The tool can not, and does not, attempt to decide if a given developer choice follows the technical specifications. 

This tool does not:
1. Provide any sort of certification in relation to {{site.doc-name}}.
2. Guarantee that results generated through the tool follow all {{site.doc-name}} guidelines.
3. Guarantee the results of any analysis accurately represent the conditions at a given geospatial coordinate.


# Data Disclaimers

None of the source data is collected/ measured/ modeled/ owned by DOE, Sandia, or Evergreen Innovations. The following disclaimers apply:
1. [CDIP](https://cdip.ucsd.edu/m/documents/data_access.html#data-use-and-acknowledgements) - Costal Data Information Program
2. [NDBC](https://www.weather.gov/disclaimer) - NOAA (National Oceanic and Atmospheric Administration) National Data Buoy Center
3. [DOE WPTO](https://github.com/openEDI/documentation/blob/main/US_Wave.md#disclaimer-and-attribution) - DOE Water Power Technology Office


# Response Analysis

{{site.doc-name}} specifies safety factors to be applied to achieve a target safety level of SL2.  The DLC generator automatically reports the extreme characteristic with the ULS (Ultimate Limit State, see {{site.doc-name}} Section 7.3.4.2) applied. The environmental load category ULS values are used in the tool.

The tool doesn't have any knowledge of what DLC the uploaded response is associated with, nor does it consider the type of response being uploaded.  The tool will apply partial safety factors to a calculated extreme characteristic regardless of the response variable type uploaded.  For instance, the tool will apply the ULS to both loads and motions of the WEC device if included in the uploaded file.

Use {{site.doc-name}} Table 7 and Section 7.3.5 Table 6 to determine if the applied safety factors are applicable for your DLC.  

# Reports and Output

All content downloaded from the tool is provided for reference. No downloaded content from the tool is meant to be used in certification processes, financial planing, or any other legal purposes. 


