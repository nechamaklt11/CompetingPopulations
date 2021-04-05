%QUESTION 3

%section A
clear; close all; %i
fileData=dnf_getfile; %ii 
lineProp={'ro','bo'}; %iii 
fig1=figure;
dnf_plotPop(fileData,lineProp); %iv
dnf_Annotate(fileData) %v

%section E
[pop1Params,error1Params,cIdx1]=dnf_calcSepParams(fileData.Pop1,0.7); %i
[pop2Params,error2Params,cIdx2]=dnf_calcSepParams(fileData.Pop2,0.7); %ii
K1=pop1Params.K; K2=pop2Params.K; %k values (i+ii); 
sepPopParams=[pop1Params, pop2Params]; %estimated paramaters for both populations (given separate populations)
sepPopCI=[error1Params,error2Params]; %error values for both populations, given separate populations. 
S_idx=max([cIdx1 cIdx2]); %max stabilization index  

%section H
twoCompPops=fileData.Comp; %i Calculated according to estimated paramters
[compPop1Params, compPop1Error] = dnf_calcCompParams(pop1Params,error1Params,twoCompPops(:,2),...
    twoCompPops(:,3),twoCompPops(:,1),S_idx);%ii
[compPop2Params, compPop2Error] = dnf_calcCompParams(pop2Params,error2Params,twoCompPops(:,3),...
    twoCompPops(:,2),twoCompPops(:,1),S_idx);%iii
estCompParams=[compPop1Params,compPop2Params]; %iv
estCompErrors=[compPop1Error,compPop2Error]; %v

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
simResults=dnf_knownSim(estCompParams,compSimParams);
simCompResults=[simResults.Times,simResults.Pop1,simResults.Pop2];
calcEstParam.Comp=simCompResults;

%section J
param2Txt = @(T,N,V) [T,' ','=',' ',num2str(N),' ','[',num2str(V),']'];

%section K
fig1; %i
hold all
line_prop={'r-','b-'}; %ii
dnf_plotPop(calcEstParam,line_prop); %iii
%iv
lamda_txt1=param2Txt('lamda',estCompParams(1).lamda,estCompErrors(1).lamda); %(1)
lamda_txt2=param2Txt('lamda',estCompParams(2).lamda,estCompErrors(2).lamda); %(1)
K_txt1=param2Txt('K',estCompParams(1).K,estCompErrors(1).K); %(2)
K_txt2=param2Txt('K',estCompParams(2).K,estCompErrors(2).K); %(2)
all_txt=[lamda_txt1,'  ',lamda_txt2,'  ',K_txt1,'  ',K_txt2]; %(3)
subplot(2,1,2)
title(all_txt);
%v
sepN0_txt1=param2Txt('N0',sepPopParams(1).N0,sepPopCI(1).N0);
sepN0_txt2=param2Txt('N0',sepPopParams(2).N0,sepPopCI(2).N0);
lgnd_upper={fileData.Sp1,fileData.Sp2,sepN0_txt1,sepN0_txt2};
subplot(2,1,1)
legend(lgnd_upper)
%vi
compN0_txt1=param2Txt('N0',estCompParams(1).N0,estCompErrors(1).N0);
compN0_txt2=param2Txt('N0',estCompParams(2).N0,estCompErrors(2).N0);
compA_txt1=param2Txt('alpha',estCompParams(1).alpha,estCompErrors(1).alpha);
compA_txt2= param2Txt('alpha',estCompParams(2).alpha,estCompErrors(2).alpha);
lgnd_bottom={fileData.Sp1,fileData.Sp2,[compN0_txt1,compA_txt1],...
    [compN0_txt2,compA_txt2]};
subplot(2,1,2)
legend(lgnd_bottom)
 
%QUESTION 4
%section A
fig2=figure; %i
userSimParams=dnf_getdata_new(compSimParams); %ii %simulation parameters as received by the user
% sectionB
while all(userSimParams.N0~=0) %the loop continues as long as both N0 values are positive
    userPopParams=estCompParams; %i %default population parameters, as estimated in 3i
    lenN0=length(userSimParams.N0); %ii - update N0 
    if lenN0>1 %if there is only one value for N0, we copy the value to both populations
        userPopParams(1).N0=userSimParams.N0(1); %update N0 value for 1st pop
        userPopParams(2).N0=userSimParams.N0(2); %update N0 value for 2nd pop
    else %if both N0 values are given
        userPopParams(1).N0=userSimParams.N0;  %update N0 value for 1st pop
        userPopParams(2).N0=userSimParams.N0;%update N0 value for 2nd pop
    end
    userPopParams(1).K=userPopParams(1).K*userSimParams.Fk;%iii - update K 1st pop
    userPopParams(2).K=userPopParams(2).K*userSimParams.Fk; %iii - 2nd pop
    userResults=dnf_knownSim(userPopParams,userSimParams); %iv - simulation based on user inputs
    clf %v - clean figure
    %vi
    sp1_txt=[fileData.Sp1,' N0=',num2str(userPopParams(1).N0),', K=',num2str(userPopParams(1).K)]; %1st pop parameters 
    sp2_txt=[fileData.Sp2,' N0=',num2str(userPopParams(2).N0),', K=',num2str(userPopParams(2).K)]; %2nd pop parameters 
    if userSimParams.numRepeats==1 %if only one realization done
        plot(userResults.Times,userResults.Pop1); %plot simulation results for 1st pop
        hold on
        plot(userResults.Times,userResults.Pop2); %plot simulation results for 2nd pop
        title(fileData.Title); %use excel title as the figure title
        legend({sp1_txt,sp2_txt}); %use parameter text as legend
        xlabel(fileData.Time) %time units 
    else %for more than one realization
        subplot(2,1,1) 
        plot(userResults.Times,userResults.Pop1) %1st pop simulation results
        ylabel(sp1_txt) %use parameter text as y label
        xlabel(fileData.Time) %time unites
        title(fileData.Title); %excel title
        subplot(2,1,2)
        plot(userResults.Times,userResults.Pop2) %2nd pop simulation results
        ylabel(sp2_txt) %use parameter text as y label
        xlabel(fileData.Time)  %time units
    end
    userSimParams=dnf_getdata_new(compSimParams); %viic prepare for another simulation
end

%section C
if size(userResults.Pop1,2)>1 %for more than one realization
    fig3=figure;%i 
    hold all
    %ii calculate mean and std for each population for every time point
    mPop1=mean(userResults.Pop1,2); %1st species mean
    sPop1=std(userResults.Pop1,0,2);%1st species std
    mPop2=mean(userResults.Pop2,2); %2nd species mean
    sPop2=std(userResults.Pop2,0,2);%2nd species std
    N=size(userResults.Pop1,1);
    if N<=50 %iii for less than 50 time points
        errorbar(userResults.Times,mPop1,sPop1); %plot error bar - 1st pop
        errorbar(userResults.Times,mPop2,sPop2); %plot error bar - 2nd pop
    else %iv
        plot(userResults.Times,mPop1) %(1) averaged 1st population size 
        plot(userResults.Times,mPop2) %averaged 2nd population size
        mPop1_P=mPop1(1:5:end); %(2) choose every 5th data point
        sPop1_P=sPop1(1:5:end);
        mPop2_P=mPop2(1:5:end);
        sPop2_P=sPop2(1:5:end);   
        t_P=userResults.Times(1:5:end);
        errorbar(t_P,mPop1_P,sPop1_P);
        errorbar(t_P,mPop2_P,sPop2_P);
        legend({sp1_txt,sp2_txt}); %(3)
        title(fileData.Title) %(4) graph title
    end
end
