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
[pop1Params,error1Params,cIdx1]=dnf_calcSepParams(fileData.Pop1,0.7); %i
[pop2Params,error2Params,cIdx2]=dnf_calcSepParams(fileData.Pop2,0.7); %ii
K1=pop1Params.K; K2=pop2Params.K; %k values (i+ii); 
sepPopParams=[pop1Params, pop2Params]; %estimated paramaters for both populations (given separate populations)
sepPopCI=[error1Params,error2Params]; %error values for both populations, given separate populations. 
S_idx=max([cIdx1 cIdx2]); %max stabilization index  
%%
%section H
twoCompPops=fileData.Comp; %i
[compPop1Params, compPop1Error] = dnf_calcCompParams(pop1Params,error1Params,twoCompPops(:,3),...
    twoCompPops(:,1),twoCompPops(:,2),S_idx);%ii
[compPop2Params, compPop2Error] = dnf_calcCompParams(pop2Params,error2Params,twoCompPops(:,3),...
    twoCompPops(:,2),twoCompPops(:,1),S_idx);%iii
estCompParams=[compPop1Params,compPop2Params]; %iv
estCompErrors=[compPop1Error,compPop2Error]; %v





