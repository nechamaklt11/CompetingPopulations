%QUESTION 3

%section A
clear; close all; %i clearing all variables and closing all graphical windows
fileData=dnf_getfile; %ii saving the data from the file into a variable
lineProp={'ro','bo'}; %iii creating an array for plot parameters
fig1=figure; %(iv) opening a new graphical window
dnf_plotPop(fileData,lineProp); %iv ploting the data from the file
dnf_Annotate(fileData) %v adding annotation to the plot creatied in iv

%section E
[pop1Params,error1Params,cIdx1]=dnf_calcSepParams(fileData.Pop1,0.7); %i calculating simulation parameters for population 1
[pop2Params,error2Params,cIdx2]=dnf_calcSepParams(fileData.Pop2,0.7); %ii calculating simulation parameters for population 2
K1=pop1Params.K; K2=pop2Params.K; %k values (i+ii); 
sepPopParams=[pop1Params, pop2Params]; %iii estimated paramaters for both populations (given separate populations)
sepPopCI=[error1Params,error2Params]; %iv error values for both populations, given separate populations. 
S_idx=max([cIdx1 cIdx2]); %v finding the maximal stabilization index  

%section H
twoCompPops=fileData.Comp; %i saving the competing populations data as a variable
[compPop1Params, compPop1Error] = dnf_calcCompParams(pop1Params,error1Params,twoCompPops(:,2),...
    twoCompPops(:,3),twoCompPops(:,1),S_idx);%ii calculating competition parameters for 1st popultation 
[compPop2Params, compPop2Error] = dnf_calcCompParams(pop2Params,error2Params,twoCompPops(:,3),...
    twoCompPops(:,2),twoCompPops(:,1),S_idx);%iii calculating competiting parameters for 2nd population
estCompParams=[compPop1Params,compPop2Params]; %iv creating a variable containing the parameters of both popultaions
estCompErrors=[compPop1Error,compPop2Error]; %v creating a variable containing the CI data for both populations

%section I
calcEstParam=fileData; %i %creating a variable for the struct contaiing the data from the original file
maxTimePop1=max(calcEstParam.Pop1(:,1)); %ii finding the last time point of the first experiment
maxTimePop2=max(calcEstParam.Pop2(:,1)); %ii finding the last time point of the second experiment
maxTimeComp=max(calcEstParam.Comp(:,1)); %ii finding the last time point of the third experimnet
maxTimeSep=max(maxTimePop1,maxTimePop2); %finding the last time point between the two single population experiments
maxTimePoint=max(maxTimeSep,maxTimeComp); %finding the last timepoint between all 3 experimnets
times=linspace(0,maxTimePoint,maxTimePoint); %iii creating a variable of time points from zero to the last time point
pop1Size=dnf_calcLogGrowth(pop1Params,times); %iv finding the population sizes of population 1
calcEstParam.Pop1=[times;pop1Size]'; %creating an array of time points and sizes for population 1
pop2Size=dnf_calcLogGrowth(pop2Params,times); % finding the population sizes of population 2
calcEstParam.Pop2=[times;pop2Size]';  %creating an array of time points and sizes for population 2
compSimParams=struct('maxSteps',maxTimeComp,'numRepeats',1,'minSize',0,'N0',[estCompParams.N0],'Fk',1); %v(1) creating a struct for simulation parameters
simResults=dnf_knownSim(estCompParams,compSimParams); %v(2) running the simulation
simCompResults=[simResults.Times,simResults.Pop1,simResults.Pop2]; %creating an array of time points and the size of each populatino in each
calcEstParam.Comp=simCompResults; %copying the array into the relevant field in the struct

%section J
param2Txt = @(T,N,V) [T,' ','=',' ',num2str(N),' ','[',num2str(V),']']; %an anonym function to present parameter value as text

%section K
fig1; %i returning to the graphical window presenting the original data
hold all
line_prop={'r-','b-'}; %ii creating a cell array with plot parameters
dnf_plotPop(calcEstParam,line_prop); %iii adding the simulation's results to the plot presenting the original data 
%iv
lamda_txt1=param2Txt('lamda',estCompParams(1).lamda,estCompErrors(1).lamda); %(1) creating a text showing lamda for population 1
lamda_txt2=param2Txt('lamda',estCompParams(2).lamda,estCompErrors(2).lamda); %(1) creating a text showing lamda for population 2
K_txt1=param2Txt('K',estCompParams(1).K,estCompErrors(1).K); %(2) creating a text showing the carrying capacity for population 1
K_txt2=param2Txt('K',estCompParams(2).K,estCompErrors(2).K); %(2) creating a text showing the carrying capacity for population 2
all_txt=[lamda_txt1,'  ',lamda_txt2,'  ',K_txt1,'  ',K_txt2]; %(3) uniting all 4 texts into a single variable
subplot(2,1,2) 
title(all_txt); %adding the combined text as title for the lower plot
%v
sepN0_txt1=param2Txt('N0',sepPopParams(1).N0,sepPopCI(1).N0); %creating a variable containing the N0 data of population 1 alone
sepN0_txt2=param2Txt('N0',sepPopParams(2).N0,sepPopCI(2).N0); %creating a variable containing the N0 data of population 2 alone
lgnd_upper={fileData.Sp1,fileData.Sp2,sepN0_txt1,sepN0_txt2}; %creating the final legend of the lower graph
subplot(2,1,1)
legend(lgnd_upper) %adding the legend to the graph
%vi
compN0_txt1=param2Txt('N0',estCompParams(1).N0,estCompErrors(1).N0); %creating a text containing the N0 data of population 1 in a competitive setting
compN0_txt2=param2Txt('N0',estCompParams(2).N0,estCompErrors(2).N0); %creating a text containing the N0 data of population 2 in a competitive setting
compA_txt1=param2Txt('alpha',estCompParams(1).alpha,estCompErrors(1).alpha); %creating a text containing the alpha data of population 1 in a competitive setting
compA_txt2= param2Txt('alpha',estCompParams(2).alpha,estCompErrors(2).alpha); %creating a text containing the alpha data of population 2 in a competitive setting
lgnd_bottom={fileData.Sp1,fileData.Sp2,[compN0_txt1,compA_txt1],...
    [compN0_txt2,compA_txt2]}; %uniting all 4 texts into a single legend
subplot(2,1,2)
legend(lgnd_bottom) %adding the legend to the lower plot
 
%QUESTION 4
%section A
fig2=figure; %i
userSimParams=dnf_getdata_new(compSimParams); %ii %simulation parameters as received by the user
% section B
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
    else %iv for more than 50 time points
        plot(userResults.Times,mPop1) %(1) average size of the 1st population 
        plot(userResults.Times,mPop2) %average size of the 2nd population 
        mPop1_P=mPop1(1:5:end); %(2) choose every 5th data point
        sPop1_P=sPop1(1:5:end);
        mPop2_P=mPop2(1:5:end);
        sPop2_P=sPop2(1:5:end);   
        t_P=userResults.Times(1:5:end);
        errorbar(t_P,mPop1_P,sPop1_P); %adding the error bars for population 1
        errorbar(t_P,mPop2_P,sPop2_P); %adding the error bars for population 2
        legend({sp1_txt,sp2_txt}); %(3) %adding the legend
        title(fileData.Title) %(4) adding the graph's title
    end
end
