% Load CSV data
filename = 'chiwoza_soc20240218-22.csv';
data = readtable(filename);%, 'Format','%{yyyy-MM-dd HH:mm:ss}D %f');
ts = data.ts;
soc = data.soc;

% Convert timestamps to seconds relative to the first timestamp
ts_seconds = seconds(ts - ts(1));

% Generate new timestamp series at one-second intervals
new_ts_seconds = (0:max(ts_seconds))';

% Perform linear interpolation
new_soc = interp1(ts_seconds, soc/100, new_ts_seconds, 'linear');

% If you need to create a new table with the interpolated values
interpolated_data = table(new_ts_seconds, new_soc, 'VariableNames', {'tsec', 'soc'});

% Optionally, save the interpolated data to a new CSV file
writetable(interpolated_data, './Application profiles/interpolated_data.csv');

% Display the first few rows of the interpolated data
head(interpolated_data)
