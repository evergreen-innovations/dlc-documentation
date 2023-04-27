---
title: Response Analysis
permalink: /theory/responseAnalysis
sidebar:
  nav: "theory"
---

[{{site.doc-name}}]({{site.doc-link}}) culminates in a response analysis for the simulations or tank testing done for the WEC. 

The developer uses the downloaded surface elevation time series, performs tests while collecting response variables (motions of or forces exerted on the WEC device), then performs an extreme value analysis on each of the response variables captured.

See the [tool usage docs](/documentation/responseAnalysis) for information on creating the file in the proper format for uploading to the DLC Generator.

{{site.doc-name}} Section 7.3 has detailed requirements for the testing.

## Extreme Value Analysis

MHKiT is used to calculate the extreme value with [`mhkit.loads.extreme.short_term_extreme`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.loads.html#mhkit.loads.extreme.short_term_extreme)

The extreme value analysis is performed to align with the {{site.doc-name}} Section 7.3 specifications, using a 3-hour sea state as the short-term period.

#### Extreme Value Statistical Method

The model selection uses the same univariate distributions as described in [Statistics](/theory/stats#univariate-methods). 

##### Peaks Over Threshold

Currently, the Peaks Over Threshold implementation for the `short_term_extreme` function uses 1.4 standard deviations above the mean as the Threshold value.  Sometimes this implementation leaves too few values to be able to approximate the extreme characteristic.  

**Come back for a future release where the threshold is automatically optimized using methods defined [here](https://www.mdpi.com/2077-1312/8/4/289).**

## Partial Safety Factors

{{site.doc-name}} specifies safety factors that should be applied to achieve a target safety level of SL2.  The DLC generator automatically reports the extreme characteristic with the ULS (Ultimate Limit State, see {{site.doc-name}} Section 7.3.4.2) applied. Since these are environmental loads being tested, the environmental values are used in the tool.

See {{site.doc-name}} Section 7.3.5 Table 6 for details and caveats on the partial safety factors.









