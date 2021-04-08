function [compPopParams, compPopError] = dnf_calcCompParams(inPopParams,inPopError,Nr,Nc,times,stable_Idx)
%QUESTION 3 SECTION G
%The function estimates the parameters of a set population in a competitive
%system, based upon the known parameters of said population in a
%none-competitive system.
%Inputs: inPopParams - an array contaiing the population's parameters when
%        on its own. 
%        inPopError - an array containing potential errors in the
%        parameters for the population on its own.
%        Nr - population size of said population
%        Nc - population size of competing population
%        Times - an array of time points
%        Stable_Idx - the stabilization index in an experiment without
%        competition
%Outputs: compPopParams, compPopError

compPopParams = inPopParams; %(1) %copying the input arguments into the output arguments
compPopError = inPopError; %(1)
[calc_Constant, ~, calc_Idx] = dnf_asympt(Nr,0.01); %(2) finding the stable value and stabilization index
combined_Idx = max(calc_Idx, stable_Idx); %(3a) finding the maximal value between the two stablization indices
Nr_stable = Nr(combined_Idx:end); %(3b) saving the elements from the stablization index onward 
Nc_stable = Nc(combined_Idx:end); %(3b)
alpha_array = (inPopParams.K-Nr_stable)./Nc_stable; %(3c) calculating the alpha array
alpha = mean(alpha_array); %(3d) calculating alpha
compPopParams.alpha = alpha; %(3d) copying the calculated alpha into the output struct
CI_low = alpha - 2*std(alpha_array); %(3e) calculating the CI for alpha
CI_high = alpha + 2*std(alpha_array); %(3e)
compPopError.alpha = [CI_low, CI_high]; %(3f) copying alpha's CI into the output struct
pop_array = [times, Nr]; %(4a) creating an array containing both the time points and population size
thr = 0.7*calc_Constant; %(4b), calculating threshold value
[N0,N0_CI]= dnf_predN0(pop_array, thr, inPopParams.lamda); %(4c) finding N0 and its CI
compPopParams.N0=N0; compPopError.N0=N0_CI; %copying the calculated N0 and its CI into the relevant output structs
