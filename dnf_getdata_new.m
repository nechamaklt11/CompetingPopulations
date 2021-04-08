function Outstruct = dnf_getdata_new(Instruct)
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
    C=struct2cell(Outstruct); %arrange the struct data as a cell
    if all(~cellfun(@isempty, C)) && all([C{:}]>=0) %if all the inputs were inserted properly
        break
    else % if the user inserted a negative/not numeric input
        Defaults=Ans; % in case the user corrected only one of a few illegal fields
        idx=[find(cellfun(@isempty, C));findNeg(C)]; %find illegal inputs
        [Defaults(idx)]={'error: please insert positive numbers only'}; %display an error message
    end
end

function ind=findNeg(x)
%internal function to find negative indices. 
C=cellfun(@(y)(any(y < 0)),x,'Uni',0); %a logical array, with 1 for negative numbers and 0 for positive. we use any because part of the cell is logical and part is not. 
C=cell2mat(C);
ind=find(C==1);


