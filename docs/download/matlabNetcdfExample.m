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
