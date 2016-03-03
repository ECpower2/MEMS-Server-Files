function testlibraryheader(cHeader)
% Generates a dummy C file that includes the passed header file and tries
% to compile it. If the header file does not comply to the C standard or
% contains errors, it will fail and show the message.
% Updated: 2010-03-17.

% Generate random string to use as the temp file name to avoid collisions.
tempFileName = getrandomstring(10);
cFileTemp = ['temp_' tempFileName '.c'];
objectFile = ['temp_' tempFileName '.o'];
outputFile = ['temp_' tempFileName '.exe'];

% Generate test C file that includes the passed header.
disp(['Generating temporary C file that includes the header file "' cHeader '" ...']);
disp(' ');

fid = fopen(cFileTemp, 'wt');

fprintf(fid, ['#include "' cHeader '"\n\n']);
fprintf(fid, 'int main() {\nreturn 0;\n}\n');

fclose(fid);

% Try to compile.
disp('Compiling C file ...');
disp(' ');
try
    % MBUILD exists.
    if ~isempty(which('mbuild'))
        mbuild(cFileTemp, '-output', outputFile);
    else
        % Try to use LCC, only available on 32-bit Windows.
        if strcmp(computer, 'PCWIN')
            lccFolder = fullfile(matlabroot, 'sys', 'lcc', 'bin');
            lccCommand = [lccFolder '\lcc -c -I"' lccFolder '" -noregistrylookup ' cFileTemp];

            if system(lccCommand) ~= 0 % Compilation failed.
                error('Error: Unable to complete successfully.')
            end %if
        else % No compiler.
            error('Error: A compiler could not be found.')
        end %if

        % Delete object file.
        if exist(objectFile, 'file') % ".o".
            delete(objectFile);
        end %if
        if exist([objectFile 'bj'], 'file') % ".obj".
            delete([objectFile 'bj']);
        end
    end %if

    disp(['Success: C-Header file "' cHeader '" contains no errors.']);

    % Delete temp EXE file.
    if exist(outputFile, 'file')
        delete(outputFile);
    end
catch err
    disp(err.message);
end

% Delete temp C file.
delete(cFileTemp);

function y = getrandomstring(stringLength)
alphabet = 'abcdefghijklmnopqrstuvwxyz';

y = '';
for i=1:stringLength
    y = [y alphabet(randfun(1, length(alphabet)))]; %#ok<AGROW>
end %i

function y = randfun(minBound, maxBound)
y = floor((maxBound - minBound + 1) * rand(1) + minBound);