%QUESTION 3
%%
%section A
clear; close all; %i
fileData=dnf_getfile; %ii
lineProp={'ro','bo'}; %iii %array or a cell?  CONTRADICTION
fig1=figure;
dnf_plotPop(fileData,lineProp); %iv
dnf_Annotate(fileData) %v
%%
%section E
[pop1Params,error1Params]=dnf_calcSepParams(fileData.Pop1,0.8);%what is p? %i
[pop2Params,error2Params]=dnf_calcSepParams(fileData.Pop2,0.8);%what is p? %ii
K1=pop1Params.K; K2=pop2Params.K; %k values (i+ii); 
sepPopParams=[pop1Params, pop2Params]; %estimated paramaters for both population (given separate populations)
sepPopCI=[error1Params,error2Params]; %error calues for both populations, given separate populations. 
K_idx=max([K1 K2]); %max K index  %%%% we need de index????



