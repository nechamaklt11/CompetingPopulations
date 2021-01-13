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
%%
%QUESTION 2 section I ii 
S1=struct('N0',5.1,'K',10.2,'lamda',1.11,'alpha',1.03);% create parameters struct for the 1st species
S2=struct('N0',4.7,'K',10.5,'lamda',1.04,'alpha',1.09); %creates parameters struct for the 2nd species
S=[S1,S2]; %combine the two structs into one array. %%check if it is changed
%%%% to do section iii
popSize1=dnf_calcLogGrowth(S1,Times);
popSize2=dnf_calcLogGrowth(S2,Times);
%section I v
subplot(2,1,1)
plot(popSize1,'k')
hold on
plot(popSize2,'k') %ask the metarglim if they mixed upper and lower subplots
subplot(2,1,2)


