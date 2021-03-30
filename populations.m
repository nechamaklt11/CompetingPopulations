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
[compPop1Params, compPop1Error] = dnf_calcCompParams(pop1Params,error1Params,twoCompPops(:,2),...
    twoCompPops(:,3),twoCompPops(:,1),S_idx);%ii
[compPop2Params, compPop2Error] = dnf_calcCompParams(pop2Params,error2Params,twoCompPops(:,3),...
    twoCompPops(:,2),twoCompPops(:,1),S_idx);%iii
estCompParams=[compPop1Params,compPop2Params]; %iv
estCompErrors=[compPop1Error,compPop2Er%%
%section I
calcEstParam=fileData; %i
maxTimePop1=max(calcEstParam.Pop1(:,1)); %ii - Last timepoimt of experiment with pop 1
maxTimePop2=max(calcEstParam.Pop2(:,1)); %ii - Last timepoint of experiment with pop 2
maxTimeComp=max(calcEstParam.Comp(:,1)); %ii - Last timepoint of experiment with both populations
timesPop1=linspace(0,maxTimePop1,maxTimePop1); %iii
timesPop2=linspace(0,maxTimePop2,maxTimePop2); %iii
timesComp=linspace(0,maxTimeComp,maxTimeComp); %iii
pop1Size=dnf_calcLogGrowth(pop1Params,timesPop1); %iv - Pop 1
calcEstParam.Pop1=[timesPop1;pop1Size]';
pop2Size=dnf_calcLogGrowth(pop2Params,timesPop2); %Pop 2
calcEstParam.Pop2=[timesPop2;pop2Size]'; 
compSimParams=struct('maxSteps',maxTimeComp,'numRepeats',1,'minSize',0,'N0',[estCompParams.N0],'Fk',1); %v
%%
%section J
param2Txt = @(T,N,V) ['T',' ','=',' ',num2str(N),' ','[',num2str(V),']'];



