---
title: Response Analysis Upload
permalink: /interface/responseAnalysis
sidebar:
  nav: "interface"
toc: true
toc_label: "Sections"
toc_icon: "cog"
toc_sticky: true
---

Once dynamic simulations or tank testing is completed from the surface elevation time series downloaded through the DLC Generator, the final step in the workflow is uploading a file to perform extreme value response analysis on.

See the [theory documentation]({{site.url}}/theory/responseAnalysis) for more information on the analysis itself.

# File Formats

There are two accepted file formats:
1. [NetCDF](https://en.wikipedia.org/wiki/NetCDF)
2. CSV

## NetCDF

NetCDF is the most robust file format.  Using the netCDF file format allows for multiple cases to be analyzed in one run, units to be given to the response time series, and is a common file format in the scientific computing industry.

### Data Structure

The data structure for the netCDF has the coordinates or **time** and **case**, and the variables are the response value arrays that are indexed by **time** and **case**.

Printing [`xarray`](https://docs.xarray.dev/en/stable/) dataset from netCDF file in python should produce an output with the same coordinates, and the same indexing pattern on the data variables:

```
<xarray.Dataset>
Dimensions:           (case: 2, time: 216000)
Coordinates:
  * time              (time) float64 0.0 0.05 0.1 ... 1.08e+04 1.08e+04 1.08e+04
  * case              (case) object 'DLC 6.2 Hm0: 11.92 Tp: 10.2' 'DLC 6.2 Hm...
Data variables:
    pto_displacement  (case, time) float64 0.0 -0.0002085 ... -1.745 -1.757
    pto_force         (case, time) float64 0.0 -8.202 ... -1.304e+03 -1.286e+03
```

#### Requirements

1. Sample rate (time variable) needs to be consistent across all cases and response variables. These names are case sensitive.
2. Data Variables (device response arrays) need to exist across all cases. IE Case 1 having 4 response variables and Case 2 having 5 is invalid.
3. Time array is in seconds (simulation/ tank time), NOT a datetime or string.
4. No NaN's/ nulls can be present in the response data variables or time coordinate.

### Example NetCDF Scripts

There are two example scripts, one written for MATLAB, and another for python.  

#### Python 
The python example is a Jupyter Notebook with two related CSV's (of the surface elevation downloaded through the DLC Generator). The notebook performs a simple simulation of a mock device in order to create mock response variables. 

View the python notebook in a browser <a href="{{ site.url }}/download/example-notebook.html" target="_blank">here</a>.

Or, [Download the python example notebook][1] and download [first][2] and [second][3] CSV's to use as a starting point.


#### MATLAB

The MATLAB example creates the sample surface elevation time series randomly in the file and performs a simple simulation of a mock device to create mock response variables.

**The matlab example assumes MATLAB version r2021b or newer** - the `NC_STRING` datatype support was added in this release.

MATLAB documentation for netCDF files can be found [here](https://www.mathworks.com/help/matlab/import_export/exporting-to-network-common-data-form-netcdf-files.html#bsxb70y-1).  Lower-level functions are required in order to have the `cmode` to `NETCDF4` for use through the DLC Generator tool.

[Download the example MATLAB file][4], or copy and paste pieces from the following code.

```m
%%=========================================================================
% Create a netCDF-4/HDF5 file
% DLC system expects the NETCDF4/HDF5 file format
cmode = 'NETCDF4';

ncid = netcdf.create('example.nc', cmode);

%% Create Dimensions ======================================================
% cases and time are the dimensions for the NETCDF file
cases = ["RM3 WEC Response Hs 5 Tp 10", "RM3 WEC Response Hs 6 Tp 11"];
time = linspace(0, 3600, 3600*20);

% create dimensions and return ids
% case and time dimensions are case sensitive
caseId = netcdf.defDim(ncid, 'case', length(cases));
timeId = netcdf.defDim(ncid, 'time', length(time));

% create the variables that are the dimemsions
% case and time variables for the dims are case sensitive
caseVarId = netcdf.defVar(ncid, 'case', 'NC_STRING', caseId);
timeVarId = netcdf.defVar(ncid, 'time', 'NC_DOUBLE', timeId);

% create list of dimension id's - used to indicate how the data variables
% are indexed
dims = [caseVarId, timeVarId];

% add the dimension data of case and time
netcdf.putVar(ncid, caseVarId, cases);
netcdf.putVar(ncid, timeVarId, time);


%% Create Data Variables ==================================================

% The data used here is going to be random, this data would be stored in a
% .mat file, csv, or other variables from running your various simulations
% Important limitations on the data that can be combined into one netCDF
% file:
% 1. All cases must be of the same time length
% 2. All cases must have the same response variables

% create a PTO Displacement variable - where the shape is (number of cases,
% number of time steps), and the dimensions are by "case" then "time"
ptoDispId = netcdf.defVar(ncid, 'pto_displacement', 'NC_DOUBLE', ...
    dims);

% create frequency vector, as well as random amplitude and phases
f = 0.1:1/(time(end)):0.5;
A1 = 1./f; % make amplitude inversely propotional to frequency
A2 = 1./f;
p1 = 2*pi*rand(size(f));
p2 = 2*pi*rand(size(f));

% an example PTO displacement
ptoDispA1 = 0.5;
ptoDispA2 = 1.25;
ptoDisp1 = zeros(size(time));
ptoDisp2 = zeros(size(time));
for n=1:length(f)
    ptoDisp1 = ptoDisp1 + A1(n)*sin(2*pi*f(n)*time + p1(n));
    ptoDisp2 = ptoDisp2 + A2(n)*sin(2*pi*f(n)*time + p2(n)); 
end
ptoDisp1 = ptoDispA1* ptoDisp1 / max(abs(ptoDisp1)); % normalize
ptoDisp2 = ptoDispA2* ptoDisp2 / max(abs(ptoDisp2)); % normalize

netcdf.putVar(ncid, ptoDispId, [ptoDisp1; ptoDisp2]);

% add attributes to the variable (OPTIONAL - name and units)
% name and unit keys are case sensitive
netcdf.putAtt(ncid, ptoDispId, 'units', 'm', 'NC_STRING');
netcdf.putAtt(ncid, ptoDispId, 'name', 'PTO Displacement', 'NC_STRING');

% create a PTO Force variable
ptoForceId = netcdf.defVar(ncid, 'pto_force', 'NC_DOUBLE', ...
    dims);

% an example PTO force time series
ptoForceA1 = 0.5e4;
ptoForceA2 = 1.25e4;
ptoForce1 = zeros(size(time));
ptoForce2 = zeros(size(time));
for n=1:length(f)
    ptoForce1 = ptoForce1 + A1(n)*sin(2*pi*f(n)*time + p1(n));
    ptoForce2 = ptoForce2 + A2(n)*sin(2*pi*f(n)*time + p2(n)); 
end
ptoForce1 = ptoForceA1* ptoForce1 / max(abs(ptoForce1)); % normalize
ptoForce2 = ptoForceA2* ptoForce2 / max(abs(ptoForce2)); % normalize

netcdf.putVar(ncid, ptoForceId, [ptoForce1; ptoForce2]);

netcdf.putAtt(ncid, ptoForceId, 'units', 'N', 'NC_STRING');
netcdf.putAtt(ncid, ptoForceId, 'name', 'PTO Force', 'NC_STRING');

% Close the file
netcdf.close(ncid);

%% Display the file format =================================================
ncdisp('example.nc')
  
```


Please be sure to run the `netcdf.close(ncid)` line. If this line isn't executed then you may receive a permission denied error as the file handle was left open.

## CSV

In addition to netCDF files, one case can be uploaded and processed at time by uploading CSV files.

### Data Structure

The data structure of the CSV file contains a `time` column and at least 1 response variable column. The `time` column header is not case sensitive.  The headers for the rest of the columns will be reported as the Response Name in the tool's UI and downloaded reports.

The following csv would be valid (truncated):

```
time,pitch_angle,slider_position,pto_force
0.0,0.0,0.0,0.0
0.1,-0.149,-0.003,-0.651
0.2,-0.440,-0.043,-3.141
```

The [python](#python) example above optionally outputs valid CSV's for each case as well as the netCDF format.

#### Requirements

1. The `time` column must be in seconds (simulation/ tank time), NOT a datetime or string.
2. No NaN's/ nulls can be present in the response data columns and they must be numeric values.


# File Organization

{{site.doc-name}} Section 7.3 has detailed requirements for testing a WEC.

With repeated tests across many parameters, there are many ways a developer can choose to organize their response files for uploading to the DLC generator.  As long as the organization follows the requirements for the file types above, then the system will produce a result.

**The following examples assume the developer is testing each DLC in Table 7 of {{site.doc-name}} with 6 different, 3-hour simulations.**  

This could be assisted through the DLC Generator by changing the random seed of the generated surface elevation for example.

## Organization Examples

A developer can choose how to organize their files, the following examples are not the only way to organize the uploaded files.

### With netCDF

One file per DLC in Table 7 of {{site.doc-name}}: 

1. Organize the response data for a given DLC and upload a netCDF with 6 cases, where each case would be the results from one of the 6 simulations.
2. Upload a separate netCDF file for each DLC in Table 7 and get an associated report for each of the DLC's.
3. Every report would have a table for each of the six 3-hour simulations.


### With CSV

One file for each simulation run for a specific DLC in Table 7 of {{site.doc-name}}:

1. Each CSV would follow the above requirements, capturing the response data for a single 3-hour simulation. 
2. Upload a separate CSV for all six 3-hour simulations for every DLC in Table 7 and get an associated report from the tool.
3. The report would then contain one table, where each column in the CSV had extreme value analysis performed on it. 
4. This would require many uploads by the developer, however it might work well to analyze one result while the next 3-hour simulation is running.


One File per DLC in Table 7 of {{site.doc-name}}:

1. The CSV would follow the above requirements, where the response columns could have a `_random_seed_N` (`pto_force_random_seed_1` for example) suffix to distinguish which of the six simulations it's associated with. 
2. Upload a CSV for each DLC in table 7 and get an associated report from the tool.
3. The report would then contain one table, where each column in the CSV had extreme value analysis performed on it. This table could be quite long depending on how many response variables there are in the WEC simulation.


# Data Storage

Neither the file(s) uploaded, nor the data contained in the output/ report of the response analysis are saved by the tool. 

Download the report to keep a personal record of the response analysis done. If returning later, data will need to be  re-upload and analysis re-ran to view the results.



[1]:{{ site.url }}/download/example.ipynb
[2]:{{ site.url }}/download/Hm0-11p92_Period-10p20.csv
[3]:{{ site.url }}/download/Hm0-21p33_Period-17p70.csv
[4]:{{ site.url }}/download/matlabNetcdfExample.m