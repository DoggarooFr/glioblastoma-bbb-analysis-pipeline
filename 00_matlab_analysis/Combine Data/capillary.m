% Determine the path of the currently running script
scriptPath = mfilename('fullpath');
[scriptDir,~,~] = fileparts(scriptPath);

% Change the current folder to the script's folder
cd(scriptDir);

% Specify the current folder where the CSV files are stored
folderPath = scriptDir;

% Get a list of all files in the folder with the .csv 
files = dir(fullfile(folderPath, '*.csv'));

% Initialize an cell array 
combinedData = {};
maxRows = 0;

% Determine the maximum number of rows among all files
for i = 1:length(files)
    filePath = fullfile(files(i).folder, files(i).name);
    dataTable = readtable(filePath, 'Range', 'B:L', 'ReadVariableNames', true);
    selectedData = dataTable(:, {'time', 'velocity', 'absVelocity'});
    maxRows = max(maxRows, height(selectedData));
end

% Loop over the files again to process data
for i = 1:length(files)
    filePath = fullfile(files(i).folder, files(i).name);
    dataTable = readtable(filePath, 'Range', 'B:L', 'ReadVariableNames', true);
    selectedData = dataTable(:, {'time', 'velocity', 'absVelocity'});
    selectedDataCells = table2cell(selectedData);
    
    % Check if the current file has fewer rows than maxRows and pad if necessary
    numRowsCurrentFile = size(selectedDataCells, 1);
    if numRowsCurrentFile < maxRows
        padding = cell(maxRows - numRowsCurrentFile, size(selectedDataCells, 2));
        selectedDataCells = [selectedDataCells; padding]; 
    end

    thisHeader = [['capillary ', num2str(i)]; repmat({''}, maxRows-1, 1)];
    combinedData = [combinedData, thisHeader, selectedDataCells]; % Add the header and data

    % Add an empty column (space) after each file's data 
    if i < length(files)
        combinedData = [combinedData, cell(maxRows, 1)];
    end
end

% Convert the combinedData cell array to a table for easy CSV writing
finalDataTable = cell2table(combinedData);

% Writing the table to a new CSV file in the same folder
newFilePath = fullfile(folderPath, 'combined.csv');
writetable(finalDataTable, newFilePath, 'WriteVariableNames', false);

disp(['Combined selected columns written to: ', newFilePath]);
