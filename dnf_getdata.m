function Outstruct = dnf_getdata(Instruct) 
%Section 2F
%%%%%%%%%%%%  To DO   %%%%%%%%
Titles = {'Maximal number of timepoints', 'Number of numSteps','Minimal population size', 'N0', 'Fk'};
Defaults = {num2str(Instruct.maxSteps), num2str(Instruct.numRepeats), num2str(Instruct.minSize), num2str(Instruct.N0), num2str(Instruct.Fk)};
Dims = [1, 30];
while true
    Ans = inputdlg(Titles,'Simulations Data', Dims, Defaults); %display a dialog box where the user inserts values for the different fields
    Outstruct = struct('maxSteps', str2double(Ans{1}), 'numSteps', str2double(Ans{2}),...
        'minSize', str2double(Ans{3}), 'N0', str2double(Ans{4}), 'Fk', str2double(Ans{5}));
    C=struct2cell(Outstruct); %arrange the struct data as a cell
    if all(~isnan([C{:}])) && all([C{:}]>0) %if all the inputs were inserted properly
        break
    else % if the user inserted a negative/not numeric input
        Defaults=Ans; % in case the user corrected only one of a few illegal fields
        idx=[find(isnan([C{:}])),find([C{:}]<0)]; %find illegal inputs
        [Defaults(idx)]={'error: please insert positive numbers only'}; %display an error message
    end
end

