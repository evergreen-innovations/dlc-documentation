---
title: External Data Sources
permalink: /interface/dataSources
sidebar:
  nav: "interface"
toc: true
toc_label: "Sections"
toc_icon: "cog"
toc_sticky: true
---

The DLC generator has two primary sources of data:

1. Measured data - sensor readings from buoys and stations throughout the ocean.
2. Modeled data - data modeled using hindcast techniques

Backend data collection leverages [MHKiT Wave IO Module](https://mhkit-software.github.io/MHKiT/mhkit-python/api.wave.html#io) for gathering measured data sources. 

# Measured Data Sources

## CDIP Buoys

Data courtesy of {% raw %}<a href="https://cdip.ucsd.edu/">CDIP</a>.{% endraw %} (Costal Data Information Program)

[CDIP](https://cdip.ucsd.edu/m/deployment/station_view/) offers data from a pubic [THREDDS](http://thredds.cdip.ucsd.edu/thredds/catalog/cdip/archive/catalog.html) server for their historic buoy data sets. 

The DLC Generator tool automates the process of:
1. Interacting with the THREDDS server and gathering all years of available data for a given buoy.
2. Takes the wave spectral density data ({% raw %}$$m^2/H_z$${% endraw %}) from the buoy and uses [MHKiT Wave Resource Module](https://mhkit-software.github.io/MHKiT/mhkit-python/api.wave.html#resource) to calculate spectral parameters {% raw %}$$H_{m0}$${% endraw %}, {% raw %}$$T_p$${% endraw %}, and {% raw %}$$T_e$${% endraw %}.
3. Removing duplicate timestamps, and invalid/ non-numeric values.

## NDBC Stations

[NDBC](https://www.ndbc.noaa.gov/) (NOAA National Data Buoy Center) provides many different historical data sets. See their [index](https://www.ndbc.noaa.gov/data/historical/) for more information.

The DLC generator currently utilizes the [`stdmet`](https://www.ndbc.noaa.gov/data/historical/stdmet/) and [`swden`](https://www.ndbc.noaa.gov/data/historical/swden/) data sets that are available from the index. 

- `stdmet` - Standard Meteorological Current Year Historical Data
- `swden` - Raw Spectral Wave Current Year Historical Data

The `stdmet` data provides {% raw %}$$H_{m0}$${% endraw %}, {% raw %}$$T_p$${% endraw %} directly, and the same basic quality assurance is performed as CDIP (Step 3 above).  These data sources don't have {% raw %}$$T_e$${% endraw %} available.

The `swden` parameter data undergoes the same process as CDIP (all steps above).

Due to the two parameters available from NDBC, there may be a few stations that appear to be duplicated.  The names may be the same, however one is from `stdmet` and one is from `swden`.  Using the **Has Te** filter in the mapping page would remove the `stdmet` option.

### Known Corrupt Values

NDBC has known corrupt values which are removed before presenting the data in the DLC tool:

- `stdmet` - `999.0`
- `swden` - `99.0`

# Modeled Data Sources

## DOE WPTO Hindcast

DOE's [Water Power Technology Office's](https://www.energy.gov/eere/water/water-power-technologies-office) (WPTO) US Wave Dataset.

The modeled data is [hosted publicly](https://registry.opendata.aws/wpto-pds-us-wave/) by DOE and WPTO.

The data is currently a 32-year data set (1979-2010) with plans to expand the date range in the future.

The tool refers to these data sets as:
1. Hindcast Virtual Buoys
2. Hindcast Grid Points

More general information available [here](https://www.nrel.gov/water/wave-hindcast-dataset.html).

### Virtual Buoys

1-hour temporal resolution where the hindcast was performed at select locations of interest.  

Virtual buoys are only available in the following regions:
1. Atlantic (East Coast)
2. West Coast
  
### Grid Points

3-hour temporal resolution grid of points down to 200m spatial resolution.  Typically the resolution becomes more fine-grained and dense as approaching the coast lines.

Grid points are available in all regions:
1. Atlantic (East Coast)
2. West Coast
3. Hawaii
4. Alaska

Only the 4 closest grid points are shown when selecting your site location.

### References for DOE WPTO Data
1. [Atlantic](https://doi.org/10.1016/j.renene.2021.03.037) (East Coast)
2. [West Coast](https://doi.org/10.1016/j.renene.2020.01.077)
3. [Alaska](https://doi.org/10.1016/j.renene.2021.02.005)
4. [Hawaii](https://doi.org/10.1016/j.renene.2021.03.116)




