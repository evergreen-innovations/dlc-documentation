---
title: Quality Control
permalink: /theory/qualityControl
sidebar:
  nav: "theory"
toc: true
toc_label: "Sections"
toc_icon: "cog"
toc_sticky: true
---

To perform statistical analysis on the measured or modeled data for your site location, it's important to make sure the data's has been cleaned and controlled for unrealistic abnormalities.

While the modeled data usually doesn't need much cleaning due to the hindcast's extensive validation, the measured data sources from buoys and stations are much more vulnerable to inconsistencies in the data.


All QA procedures are implemented using functions from [Pecos](https://pecos.readthedocs.io/en/latest/index.html), that are exposed through [MHKiT](https://mhkit-software.github.io/MHKiT/index.html) API.

Pecos reference:

* K.A. Klise and J.S. Stein (2016), Performance Monitoring using Pecos, Technical Report SAND2016-3583, Sandia National Laboratories, Albuquerque, NM.

# Quality Control Parameters

The Pecos documentation for the functions used can be found in the [pecos.monitoring module](https://pecos.readthedocs.io/en/latest/apidoc/pecos.monitoring.html).
## Corrupt Data

Uses the `check_corrupt` Pecos function.

Drop equivalent values found in the data set.  The measured data sources both have known corrupt/ fill values and they are already dropped when the data is collected. 

For example, some [NDBC](https://www.ndbc.noaa.gov/) buoys fill corrupt data points with -999 so they're already dropped.

## Range Tests

Uses the `check_range` Pecos function.

Define the upper and lower bounds of the expected range of data.  Helpful if you are familiar with an area and know that there shouldn't be Significant Wave Height values > 10 m for example. 

Values outside of the range are dropped.

## Delta Tests

Uses the `check_delta` Pecos function. 

Checks for stagnant and/or abrupt changes across a rolling window of the time series data. Uses the max and min values to find the delta (max - min) in the window.  

The entire window where the calculated delta is outside of the upper or lower bounds is dropped.

The `direction` argument is `None` for the Pecos function to catch both if the max occurs before the min or the min before the max in the rolling window.

## Outlier

Uses the `check_outlier` Pecos function.

Remove outliers, calculated across a rolling window, from normalized data.  Data is normalized using:

$$ x:=\frac{x-\mu}{\sigma} $$

Specify outliers via the number of standard deviations away from the mean.  

The tool only accepts the upper bound parameter, and passes `absolute_value=True` to the `check_outlier` function. This allows for using the same variance +/- from the mean in the rolling window.


# Results

Other than the two listed below, the results simply show the number of points dropped and why (above/ below a bound) per test.

## Timestamp

Timestamp checks are rooted in the `check_timestamp` function from Pecos.  With the following high-level flow:

1. Extract dominant temporal resolution in the time series data (measured data sources often aren't entirely evenly spaced)
2. Use the dominant temporal resolution and `check_timestamp` to locate the gaps in the data
3. Use dominant temporal resolution to calculate the percent of the data set that is missing
4. Parse the results of `check_timestamp` to report the largest gaps found in the data set

Giving results:

1. Period of record - cleaning can potentially remove significant portions of the data. Make sure the cleaning process didn't reduce the years covered too much.
2. Gaps in data - top 5 (if existing) largest gaps in the data. Look at the number of days missing, combined with the start and end dates to see if the data set is potentially missing mostly winter months. The data could be a bad representation of the extreme wave conditions if winter is often missing.
3. Temporal Resolution - observed spacing between measurements.  The most frequently observed temporal resolution is used in statistic calculations.

## Water Depth

When water depth data is available from the data source, its displayed.

Some hindcast sources have 0 m, or negative water depth.  The hindcast points need to estimate the coast line, and therefore sometimes the grid of hindcast points end up outside of the water line.  

