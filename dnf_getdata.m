function Outstruct = dnf_getdata(Instruct) %Section 2F
%

Titles = {'Maximal number of timepoints', 'Number of numSteps','Minimal population size', 'N0', 'Fk'};
Defaults = {num2str(Instruct.maxSteps), num2str(Instruct.numSteps), num2str(Instruct.minSize), num2str(Instruct.N0), num2str(Instruct.Fk)};
Dims = [1, 30];
while true
    A = inputdlg(Titles,'Simulations Data', Dims, Defaults);
    Outstruct = struct('maxSteps', str2double(A(1)), 'numSteps', str2double(A(3)), 'minSize', str2double(A(3)), 'N0', str2double(A(4)), 'Fk', str2double(A(5)));
    B = checkfield(Outstruct);
    if ischar(B)
        break ;
    else
        C = strfind(B, 'Error');
        B{C} = num2str(B{C});
        Defaults = B;
    end
end
function Test = checkfield(Instruct) %Ask if a loop can be used instead
if ~isnan(Instruct.maxSteps) && ~isempty(Instruct.maxSteps) && Instruct.maxSteps>0
    Test{1} = Instruct.maxSteps;
else
    Test{1} = -1;
end
if ~isnan(Instruct.numSteps) && ~isempty(Instruct.numSteps) && Instruct.numSteps>0
    Test{2} = Instruct.numSteps;
else
    Test{2} = -1;
end
if ~isnan(Instruct.minSize) && ~isempty(Instruct.minSize) && Instruct.minSize>0
    Test{3} = Instruct.minSize;
else
    Test{3} = -1;
end
if ~isnan(Instruct.N0) && ~isempty(Instruct.N0) && Instruct.N0>0
    Test{4} = Instruct.N0;
else
    Test{4} = -1;
end
if ~isnan(Instruct.Fk) && ~isempty(Instruct.Fk) && Instruct.Fk>0
    Test{5} = Instruct.Fk;
else
    Test{5} = -1;
end