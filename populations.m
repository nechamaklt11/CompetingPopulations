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
maxTimePop1=max(calcEstParam.Pop1(:,1)); %ii
maxTimePop2=max(calcEstParam.Pop2(:,1)); %ii
maxTimeComp=max(calcEstParam.Comp(:,1)); %ii
maxTimeSep=max(maxTimePop1,maxTimePop2);
maxTimePoint=max(maxTimeSep,maxTimeComp);
times=linspace(0,maxTimePoint,maxTimePoint); %iii
pop1Size=dnf_calcLogGrowth(pop1Params,times); %iv - Pop 1
calcEstParam.Pop1=[times;pop1Size]';
pop2Size=dnf_calcLogGrowth(pop2Params,times); %Pop 2
calcEstParam.Pop2=[times;pop2Size]'; 
compSimParams=struct('maxSteps',maxTimeComp,'numRepeats',1,'minSize',0,'N0',[estCompParams.N0],'Fk',1); %v
%%
%section J
param2Txt = @(T,N,V) ['T',' ','=',' ',num2str(N),' ','[',num2str(V),']'];



