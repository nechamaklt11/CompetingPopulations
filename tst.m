%QUESTION 2 SECTION B
close all; clear; 
popData=dnf_getfile;

%QUESTION 2 SECTION E
f1=figure;
dnf_plotPop(popData,{'ro','go'}) %Subsection i
dnf_Annotate(popData) %Subsection ii

%QUESTION 2 SECTION G
defParams=struct('maxSteps',50,'numRepeats',10,'minSize',2,...
    'N0',[4.9,5.1],'Fk',1); %,Subsection i - assigning defaults simulation parameters
simParams=dnf_getdata(defParams); %Subsection ii
%
%QUESTION 2 SECTION I
Times=linspace(0,simParams.maxSteps,201); %Subsection i

popParams=[struct('N0',5.1,'K',10.2,'lamda',1.11,'alpha',1.03),...
    struct('N0',4.7,'K',10.5,'lamda',1.04,'alpha',1.4)]; %Subsection ii - parameters for the two populations 
popParams(1).N0=simParams.N0(1); popParams(2).N0=simParams.N0(2); %Subsection iii
popSize1=dnf_calcLogGrowth(popParams(1),Times); %Subsection iv
f2=figure; %Subsection v
subplot(2,1,1) 
plot(Times,popSize1,'k') %Subsection vi
hold on
popSize2=dnf_calcLogGrowth(popParams(2),Times); %Subsection vii
plot(Times,popSize2,'k') 
%
%SECTION K
dtr_sim=dnf_knownSim(popParams,simParams); %Subsection i - determinstic simulation
f3=figure; %Subsection ii
subplot(2,1,1)
plot(dtr_sim.Times,dtr_sim.Pop1)
subplot(2,1,2)
plot(dtr_sim.Times,dtr_sim.Pop2)

popParams(1).alpha=0; popParams(2).alpha=0; %Subsection iii
simParams.minSize=0; simParams.numRepeats=1; %Subsection iv
stc_sim=dnf_knownSim(popParams,simParams); %Subsection v - stochastic simulation

figure(f2) %Subsection vi
subplot(2,1,1)
hold on
plot(stc_sim.Times,stc_sim.Pop1,'b:')
plot(stc_sim.Times,stc_sim.Pop2,'b:')
