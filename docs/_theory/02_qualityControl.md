---
title: Quality Control
permalink: /theory/qualityControl
sidebar:
  nav: "theory"
---

To perform statistical analysis on the measured/ modeled data for your site location, it's important to make sure the data's has been cleaned and controlled for unrealistic abnormalities.

While the modeled data usually doesn't need much cleaning due to the hindcast model's extensive validation, the measured data sources from buoys are much more vulnerable to inconsistencies in the data.

1. [Inputs](#inputs)
2. [Results](#results)


## Inputs
### Corrupt Data

Drop equivalent values found in the data set.  The measured data sources both have known corrupt/ fill values and they are already dropped when the data is collected. 

For example, some [NDBC](https://www.ndbc.noaa.gov/) buoys fill corrupt data points with -999 so they're already dropped.

### Range Tests

Define the upper and lower bounds of the expected range of data.  Helpful if you are familiar with an area and know that there shouldn't be Significant Wave Height values > 10 m for example. 

Values outside of the range are dropped.

### Delta Tests

Checks for stagnant and/or abrupt changes across a rolling window of the time series data. Uses the max and min values to find the delta in the window.  

The entire rolling window where the delta is outside of the upper or lower bounds are dropped.

### Outlier

Remove outliers, calculated across a rolling window, from normalized data.  Data is normalized using:

$$ x:=\frac{x-\mu}{\sigma} $$

Specify outliers via the number of standard deviations.  


## Results

Other than the two listed below, the results simply show the number of points dropped and why (above/ below a bound) per test.

### Timestamp

1. Period of record - cleaning can potentially remove significant portions of the data. Make sure the cleaning process didn't reduce the years covered too much.
2. Gaps in data - top 5 (if existing) largest gaps in the data. Look at the number of days missing, combined with the start and end dates to see if the data set is potentially missing mostly winter months. The data could be a bad representation of the extreme wave conditions if winter is often missing.
3. Temporal Resolution - observed spacing between measurements.  The most frequently observed temporal resolution is used in statistic calculations.

### Water Depth

When water depth data is available from the data source, its displayed.

Some hindcast sources have 0 m, or negative water depth.  The hindcast points need to estimate the coast line, and therefore sometimes the grid of hindcast points end up outside of the water line.  

