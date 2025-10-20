function output_struct = getOutputControl(input_fname, saveTF, NameValueArgs)
%GETOUTPUTCONTROL Read a vertical ASCII file of output values generated 
% by outputControl.c and convert to a Matlab struct object
% allardlab.com
%
%   output_struct= GETOUTPUTCONTROL(input_fname) generates Matlab 
%   struct based on input file (in current directory)
%
%   output_struct= GETOUTPUTCONTROL(input_fname,saveTF) generates 
%   Matlab struct based on input file (in current directory) and saves 
%   a .mat file with the struct if saveTF is true
%
%   output_struct= GETOUTPUTCONTROL(input_fname,Value) generates Matlab 
%   struct based on input file (in current directory) with specified 
%   parameters set using one or more name-value pair arguments
%
%   output_struct= GETOUTPUTCONTROL(input_fname,saveTF,Value) generates 
%   Matlab struct based on input file (in current directory) with 
%   specified parameters set using one or more name-value pair 
%   arguments and saves a .mat file with the struct if saveTF is true
%
%   Inputs:
%         input_fname : (string) .txt output file to parse
%         saveTF      : [optional] (bool) determines whether a .mat 
%                       file with the output struct object is saved 
%                       (default=0)
%         Value       : [optional] name-value pairs; specificed as
%                       ValueName=argument
%                     input_file_path : (string) path to input file (if
%                                       not in current directory)
%                     output_file_path: (string) path to output file 
%                                       (if not in current directory)
%                     output_fname    : (string) name of output file,
%                                       must be .mat 
%                                       (default = 'input_fname'.mat)
%                     tempdir         : (string) (unused, legacy)
%   note: it is assumed that nt is the first entry
%   Output is the struct object
%
%   See also MAKELOOKUPMAT

arguments
    input_fname string
    saveTF {mustBeNumericOrLogical} = 0
    NameValueArgs.input_file_path string = ""
    NameValueArgs.output_file_path string = ""
    NameValueArgs.output_fname string = strcat(input_fname,".mat")
    NameValueArgs.tempdir string = "/tmp/"
end

    % --- Read all lines once ---
    full_input_file = strcat(NameValueArgs.input_file_path, input_fname);
    fid = fopen(full_input_file, 'r');
    if fid == -1
        error('Cannot open file: %s', full_input_file);
    end
    lines = textscan(fid, '%s', 'Delimiter', '\n', 'Whitespace', '');
    fclose(fid);
    lines = lines{1};

    % --- Keep only lines after last "nt " ---
    ntIdx = find(contains(lines, 'nt '));
    if ~isempty(ntIdx)
        lines = lines(ntIdx(end)+1:end);
    end

    % --- Sort lines ---
    lines = sort(lines);

    % --- Remove [...] blocks ---
    lines = regexprep(lines, '\[[^]]*\]', '');
    lines = erase(lines,  "[" + wildcardPattern + "]");

    % --- Setup parser ---
    MAXDIM = 1000; % preallocation size
    matrix_during_filling = zeros(MAXDIM, MAXDIM);

    % Line pointer
    lineIdx = 1;
    getNextLine = @() getLineHelper();

    function t = getLineHelper()
        if lineIdx <= numel(lines)
            t = strtrim(lines{lineIdx});
            lineIdx = lineIdx + 1;
        else
            t = -1; % end marker
        end
    end

    % --- Parse lines ---
    tline = getNextLine();
    while ischar(tline) || (isstring(tline) && tline ~= -1)
        is_unread_line = 1;
        lineData = strsplit(tline);
        lineData = lineData(~cellfun('isempty', lineData));
        key = lineData{1};

        if (numel(lineData) == 2 && ~isempty(lineData{2}))
            % Case: simple single value
            value = str2double(lineData{2});

        elseif (numel(lineData) == 3 && ~isempty(lineData{3}) && is_unread_line == 1)
            % Case: 1D array
            coordinate1 = str2double(lineData{2})+1;
            matrix_during_filling(coordinate1) = str2double(lineData{3});
            maxCoordinate1 = coordinate1;

            while is_unread_line == 1
                tline = getNextLine();
                if ischar(tline) || (isstring(tline) && tline ~= -1)
                    lineData = strsplit(tline);
                    if strcmp(lineData{1}, key)
                        coordinate1 = str2double(lineData{2})+1;
                        if coordinate1 > maxCoordinate1
                            maxCoordinate1 = coordinate1;
                        end
                        matrix_during_filling(1,coordinate1) = str2double(lineData{3});
                    else
                        is_unread_line = 0;
                    end
                else
                    break
                end
            end
            value = matrix_during_filling(1,1:maxCoordinate1);

        elseif (numel(lineData) == 4 && ~isempty(lineData{4}) && is_unread_line == 1)
            % Case: 2D array
            coordinate1 = str2double(lineData{2})+1;
            coordinate2 = str2double(lineData{3})+1;
            matrix_during_filling(coordinate1,coordinate2) = str2double(lineData{4});
            maxCoordinate1 = coordinate1;
            maxCoordinate2 = coordinate2;

            while is_unread_line == 1
                tline = getNextLine();
                if ischar(tline) || (isstring(tline) && tline ~= -1)
                    lineData = strsplit(tline);
                    if strcmp(lineData{1}, key)
                        coordinate1 = str2double(lineData{2})+1;
                        coordinate2 = str2double(lineData{3})+1;
                        if coordinate1 > maxCoordinate1
                            maxCoordinate1 = coordinate1;
                        end
                        if coordinate2 > maxCoordinate2
                            maxCoordinate2 = coordinate2;
                        end
                        matrix_during_filling(coordinate1,coordinate2) = str2double(lineData{4});
                    else
                        is_unread_line = 0;
                    end
                else
                    break
                end
            end
            value = matrix_during_filling(1:maxCoordinate1,1:maxCoordinate2);
        else
            value = [];
        end

        % --- Store in output struct ---
        key = strrep(key, '.', '_');
        if ~contains(key, "-")
            if ~exist("output_struct", "var")
                output_struct = struct(key, value);
            else
                output_struct.(key) = value;
            end
        end

        if (is_unread_line && (ischar(tline) || (isstring(tline) && tline ~= -1)))
            tline = getNextLine();
        end
    end

    % --- Annotate type field ---
    if output_struct.NFil == 1
        output_struct.type = "single";
    elseif output_struct.NFil == 2
        if output_struct.kdimer == 0
            output_struct.type = "double";
        else
            output_struct.type = "dimer";
        end
    end

    % --- Optionally save .mat file ---
    if saveTF
        save(fullfile(NameValueArgs.output_file_path, NameValueArgs.output_fname), "output_struct", "-mat")
    end

end
