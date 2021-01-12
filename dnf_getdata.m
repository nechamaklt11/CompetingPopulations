function Outstruct = dnf_getdata(Instruct) 
%Section 2F
Titles = {'Maximal number of timepoints', 'Number of numSteps','Minimal population size', 'N0', 'Fk'};
Defaults = {num2str(Instruct.maxSteps), num2str(Instruct.maxSteps), num2str(Instruct.minSize), num2str(Instruct.N0), num2str(Instruct.Fk)};
Dims = [1, 30];
while true
    A = inputdlg(Titles,'Simulations Data', Dims, Defaults);
    Outstruct = struct('maxSteps', str2double(A{1}), 'numSteps', str2double(A{2}), 'minSize', str2double(A{3}), 'N0', str2double(A{4}), 'Fk', str2double(A{5}));
    C=struct2cell(Outstruct);
    if all(~isnan([C{:}])) && all([C{:}]>0)
        break
    else
        Defaults=A; % in case the user corrected only one of a few illegal fields
        idx=[find(isnan([C{:}])),find([C{:}]<0)];
        [Defaults(idx)]={'error message'};
    end
end

