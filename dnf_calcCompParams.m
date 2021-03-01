function [compPopParams, compPopError] = dnf_calcCompParams(inPopParams,inPopError,Nr,Nc,times,stable_Idx)
%QUESTION 3 SECTION G
%The function estimates the parameters of a set population in a competitive
%system, based upon the known parameters of said population in a
%none-competitive system.
%Inputs: inPopParams - an array contaiing the population's parameters when
%        on its own. 
%        inPopParams - an array containing potential errors in the
%        parameters for the population on its own.
%        Nr - population size of said population
%        Nc - population size of competing population
%        Times - an array of time points
%        Stable_Idx - index of stabilising in an experiment without
%        competition
%Outputs: compPopParams, compPopError

compPopParams = inPopParams; %(1)
compPopError = inPopError; %(1)
[calc_Constant, ~, calc_Idx] = dnf_asympt(inPopParams.N0,0.01); %(2)
combined_Idx = max(calc_Idx, stable_Idx); %(3a)
Nr_stable = Nr(combined_Idx:end); %(3b)
Nc_stable = Nc(combined_Idx:end); %(3b)
alpha_array = (inPopParams.K-Nr_stable)/Nc_stable; %(3c)
alpha = mean(alpha_array); %(3d)
compPopParams.alpha = alpha; %(3d)
CI_low = alpha - 2*std(alpha_array); %(3e)
CI_high = alpha + 2*std(alpha_array); %(3e)
compPopError.alpha = [CI_low, CI_high]; %(3f)
pop_array = [times, Nr]; %(4a)
thr = 0.7*calc_Constant; %(4b), calculating threshold value
[compPopParams.N0, compPopError] = dnf_predN0(pop_array, thr, inPopParam.lamda); %(4c)