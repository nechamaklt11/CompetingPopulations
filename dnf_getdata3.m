function Outstruct = dnf_getdata3(Instruct)
%Section 2F
%The function receieves a structure containing the defualt parameters for the simulation, and allows the user to replace them with new ones that will be inserted into the output structure.
%Input: A structure as described in 1)E)i,containing the default parameters of the simulation. The structure contains the following fields:
%   maxSteps - Maximal number of timepoints, numRepeats - number of realizations for the simulation, minSize - minimal population size serving as a threshold below which the simulation will stop
%   N0 - the initial population size for both species, Fk - carrying capacity for both species

Titles = {'Maximal number of timepoints', 'Number of numRepeats','Minimal population size', 'N0', 'Fk'};
Defaults = {num2str(Instruct.maxSteps), num2str(Instruct.numRepeats), num2str(Instruct.minSize), num2str(Instruct.N0), num2str(Instruct.Fk)};
Dims = [1, 30];
while true
    Ans = inputdlg(Titles,'Simulations Data', Dims, Defaults); %display a dialog box where the user inserts values for the different fields
    Outstruct = struct('maxSteps', str2num(Ans{1}), 'numRepeats', str2num(Ans{2}),...
        'minSize', str2num(Ans{3}), 'N0', str2num(Ans{4}), 'Fk', str2num(Ans{5}));
    error_ind=[];
    if all(Outstruct.maxSteps<=0) || isempty(Outstruct.maxSteps)
        error_ind=[error_ind 1];
    end
    if all(Outstruct.numRepeats<=0) || isempty(Outstruct.numRepeats)
        error_ind=[error_ind 2];
    end
    if all(Outstruct.minSize<0) || isempty(Outstruct.minSize)
        error_ind=[error_ind 3];
    end
    if all(Outstruct.N0<=0) || any(Outstruct.N0<0) || isempty(Outstruct.N0)
        error_ind=[error_ind 4];
    end
    if all(Outstruct.Fk<0) || isempty(Outstruct.Fk)
        error_ind=[error_ind 5];
    end
    if isempty(error_ind)
        break
    else % if the user inserted a negative/not numeric input
        Defaults=Ans; % in case the user corrected only one of a few illegal fields
        [Defaults(error_ind)]={'error:illegal input'}; %display an error message
    end
end



