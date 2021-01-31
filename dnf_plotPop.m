function dnf_plotPop(inStruct,plotParams)
%QUESTION 2 SECTION C
%The function plots population data for two competing populations.
%Inputs: inStruct & plotParams. 
%Outpus: None. 
%inStruct: struct as described in 1)E)iV), contains data of two populations. The struct contains the following fiels:
%    Title - general title, Time- title for x axis, Sp1-Title for 1st y axis, Sp2-Title for 2nd y axis,
%    Pop1-data about the 1st population, Pop2-data about the 2nd population, Comp-data for both competing populations. 
%plotParams:cell array with plot parameters. 

%plot for two seperate systems
subplot(2,1,1)
x_1=inStruct.Pop1(:,1);
y_1=inStruct.Pop1(:,2);
x_2=inStruct.Pop2(:,1);
y_2=inStruct.Pop2(:,2);
p_1=plotParams{1};
p_2=plotParams{2};
plot(x_1,y_1,p_1)
hold on
plot(x_2,y_2,p_2)


%plot for shared system
subplot(2,1,2)
x_s=inStruct.Comp(:,1);
y_s1=inStruct.Comp(:,2);
y_s2=inStruct.Comp(:,3);
plot(x_s,y_s1,p_1)
hold on
plot(x_s,y_s2,p_2)

