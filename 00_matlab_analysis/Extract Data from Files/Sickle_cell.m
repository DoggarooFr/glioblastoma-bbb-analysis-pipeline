% Define the main folder name (change as needed) 
mainFolders = {'1170', '1278'};

for m = 1:length(mainFolders)
    mainFolder = mainFolders{m};
    fprintf('Processing main folder: %s\n', mainFolder);
    
    if ~isfolder(mainFolder)
        fprintf('Main folder %s does not exist\n', mainFolder);
        continue;
    end
    
    % Get the list of subfolders in the main folder
    subfolders = dir(fullfile(mainFolder, '*'));
    subfolders = subfolders([subfolders.isdir]);
    subfolders = subfolders(~ismember({subfolders.name}, {'.', '..'}));
    
    if isempty(subfolders)
        fprintf('No subfolders found in %s\n', mainFolder);
        continue;
    else
        fprintf('Found %d subfolders in %s\n', length(subfolders), mainFolder);
    end
    
    % Create a new Excel file in the main folders i.e 1170_Summary.xlsx
    excelFileName = fullfile(mainFolder, sprintf('%s_Summary.xlsx', mainFolder));
    
    for s = 1:length(subfolders)
        subfolderName = subfolders(s).name;
        subfolderPath = fullfile(mainFolder, subfolderName);
        fprintf('  Processing subfolder: %s\n', subfolderPath);
        
        if ~isfolder(subfolderPath)
            fprintf('    Subfolder %s does not exist\n', subfolderPath);
            continue;
        end
        
        % Find the "veemat files" folder 
        veematFolderPath = fullfile(subfolderPath, 'veemat files');
        if ~isfolder(veematFolderPath)
            fprintf('    No "veemat files" folder found in %s\n', subfolderPath);
            continue; % Skip if no "veemat files" folder is found
        end
        fprintf('    Found "veemat files" folder: %s\n', veematFolderPath);
        
        % Get the list of all Excel files containing "Summary" in their names
        summaryFiles = dir(fullfile(veematFolderPath, '*Summary*.xlsx'));
        if isempty(summaryFiles)
            fprintf('    No summary files found in %s\n', veematFolderPath);
            continue; % Skip
        end
        
        % Data array to hold data for the current sheet
        sheetData = {'Filename', 'Baseline Velocity (mm/s)', 'Peak Velocity (mm/s)', 'Velocity Change (%)'};
        
        for f = 1:length(summaryFiles)
            filePath = fullfile(veematFolderPath, summaryFiles(f).name);
            fprintf('    Reading file: %s\n', filePath);
            
            try
                % Read the values using indexing (change as needed) 
                filenameCell = readcell(filePath, 'Range', 'B1:B1');
                baselineVelocity = readmatrix(filePath, 'Range', 'B6:B6');
                peakVelocity = readmatrix(filePath, 'Range', 'B14:B14');
                velocityChange = readmatrix(filePath, 'Range', 'B15:B15');
                
                % Extract the filename as a string
                filename = filenameCell{1};
                
                % Append the data to the sheet data
                sheetData = [sheetData; {filename, baselineVelocity, peakVelocity, velocityChange}];
                fprintf('      Data read successfully from %s\n', filePath);
            catch ME
                warning('      Error reading file: %s\n      %s', filePath, ME.message);
            end
        end
        
        % Write the collected data to the Excel file, creating a new sheet for each subfolder
        if size(sheetData, 1) > 1 % Ensure there is data to write
            writecell(sheetData, excelFileName, 'Sheet', subfolderName);
            fprintf('    Data written to sheet: %s\n', subfolderName);
        else
            fprintf('    No data collected for subfolder: %s\n', subfolderName);
        end
    end
end

