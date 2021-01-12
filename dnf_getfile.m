function Outstruct = dnf_getfile %Section 2A, Outstruct=output structure, dnf=Dor,Nechama,Final
%The function imports the data from an Excel file chosen by the user into a
%structure
%Input: none
%Output: struct as described in 1)E)iV), contains data of two populations. The struct contains the following fields:
%    Title - general title, Time- title for x axis, Sp1-Title for 1st y axis, Sp2-Title for 2nd y axis,
%    Pop1-data about the 1st population, Pop2-data about the 2nd population, Comp-data for both competing populations.

[file,path] = uigetfile({'*.xls; *xlsx'}, 'population'); %Get file name and path of file chosen by user, filtered by name and type
Filename = fullfile(path,file); %Putting together the full path
[numbers, txt] = xlsread(Filename);
Outstruct = struct('Title',file,'Time',txt(1),'Sp1',txt(2),'Sp2',txt(5),'Pop1',NaNremover(numbers(:,1:2)), ...
    'Pop2',NaNremover(numbers(:,4:5)),'Comp', NaNremover(numbers(:,7:9))); %NaNremover removes all rows with NaN in the field
function Out1 = NaNremover(Inp1) %Function to remove rows with NaN from the input
A = ~isnan(Inp1); %Find what isn't NaN
B = Inp1(A);
N=length(B)/size(Inp1,2); %Find the size of the target matrix
Out1 = reshape(B,[N,size(Inp1,2)]); %Organize the results found as not NaN to fit the original matrix