function dnf_Annotate(inStruct)
%The function adds annotations to an existing graph.
%Input: inStruct
%Output: None
%inStruct: struct as described in 1)E)iV), contains data of two populations. The struct contains the following fields:
%    Title - general title, Time- title for x axis, Sp1-Title for 1st y axis, Sp2-Title for 2nd y axis,
%    Pop1-data about the 1st population, Pop2-data about the 2nd population, Comp-data for both competing populations. 

%upper subplot
subplot(2,1,1)
title(inStruct.Title);
xlabel(inStruct.Time); ylabel('seperate systems')
%lower subplot
subplot(2,1,2)
xlabel(inStruct.Time); ylabel('shared system')
legend({inStruct.Sp1,inStruct.Sp2});
