%QUESTION 2 SECTION B
close all; clear; 
popData=dnf_getfile;

%QUESTION 2 SECTION E
figure
dnf_plotPop(popData,{'ro','go'})
dnf_Annotate(popData)
%%
%QUESTION 2 SECTION G
defParams=struct('maxSteps',50,'numRepeats',10,'minSize',2,...
    'N0',[4.9,5.1],'Fk',1); %assigning defaults simulation parameters
simParams=dnf_getdata(defParams);
%%
%QUESTION 2 SECTION I i
Times=linspace(0,5,201); 

popParams=[struct('N0',5.1,'K',10.2,'lamda',1.11,'alpha',1.03),...
    struct('N0',4.7,'K',10.5,'lamda',1.04,'alpha',1.4)]; %parameters for the two populations 
%section 1 iii
popParams(1).N0=simParams.N0(1); popParams(2).N0=simParams.N0(2); 
%section i iv
popSize1=dnf_calcLogGrowth(popParams(1),Times);
%section I v
f2=figure;
subplot(2,1,1)
%section I vi
plot(popSize1,'k')
hold on
%section I vii
popSize2=dnf_calcLogGrowth(popParams(2),Times);
plot(popSize2,'k') 
%%
%SECTION K
%i
dtr_sim=dnf_knownSim(popParams,simParams); %determinstic simulation
figure
subplot(2,1,1)
plot(dtr_sim.Pop1)
subplot(2,1,2)
plot(dtr_sim.Pop2)

popParams(1).alpha=0; popParams(2).alpha=0; 
simParams.minSize=0; simParams.numRepeats=1;
stc_sim=dnf_knownSim(popParams,simParams); %stochastic simulation

figure(f2)
subplot(2,1,2)
hold on
plot(stc_sim.Pop1,'b:')
plot(stc_sim.Pop2,'b:')
