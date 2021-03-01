function [popParams,errorParams]=dnf_calcSepParams(inMat,p)
%QUESTION 2 SECTION D
%calculate system parameters for separate populations. 
%inputs: inMat: mat with two columns: time and population.
         %p: value represents the percentage that behind it the population
         %grows logarithmically. 
%ouputs: popParams: one population params, errorParams: Confidence
%intervals
[convVal,CI_K,convIdx]=dnf_asympt(inMat,0.01); %convVal-convergence constant,CI_K-K confidence interval,convIdx-convergence index
tsd=p*convVal; %logarithmic threshold 
[lamda,N0,CI_lamda,CI_N0]=dnf_evalLogParams(inMat,tsd);%estimate No and lamda values
popParams=struct('N0',N0,'K',convVal,'lamda',lamda,'alpha',0); %struct as described in 1)E)ii
errorParams=struct('N0',CI_N0,'K',CI_K,'lamda',CI_lamda,'alpha',0);



         
