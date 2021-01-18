function popSize=dnf_calcLogGrowth(params,t)
%QUESTION 2 SECTION H

%the function calculates population size to a given population in during
%different time points. The data for each population is given in the
%"params" struct. 
%Inputs: params - contains the data for each population. The struct has
%          contains fields as described in section 1Eii: N0 (inital population), K (carrying capacity), lamda (growth factor), alpha (other species effect) 
%        t - given time points for which population size will be
%        calculated.
%Output: popSize - the population size for any given time point. 
popSize=((params.N0).*((params.lamda).^t))./(1+((params.N0).*((params.lamda).^t-1))./(params.K));


