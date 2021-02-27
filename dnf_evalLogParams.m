function [lamda,N0,CI_lamda,CI_N0]=dnf_evalLogParams(mat,t)
%QUESTION 3 SECTION C
%the function evaluates the parameters for a logaritmic formula.
%INPUTS: mat - matrice with 2 columns, one for times and one for population
%              size
%        t - threshold value (maximal population size allowed to use the
%            formula)
%OUTPUTS: lamda, N0, CI_lamda, CI_N0.
t_Idx=find(mat(:,2)<t); %find which elements meat the required criterion (t).
times=mat(t_Idx,1); pop=mat(t_Idx,2); %choose the corresponding elements from the orginal matrice.
C=[times ones(size(times))]; %create the "C" matrice
[ab,ci] = regress(log(pop),C); %logarithmic linear regression 
c=exp(ab); CI=exp(ci); 
lamda=c(1); N0=c(2); CI_N0=CI(2,:); CI_lamda=CI(1,:); %function outputs

