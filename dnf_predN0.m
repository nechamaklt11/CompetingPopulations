function [N0,CI]=dnf_predN0(inMat,T,lamda)
%question 3 section F
%the function estimates the N0 values given a known lamda
%INPUTS: %inMat: two columns array, one for times and one for population. 
         %T: threhold value - if population size is smaller than this
         %value, we assume that the population grows logarithmically
         %lamda
%OUTPUTS: %N0 (predicted N0), CI (confidence interval)
pop=inMat(:,2); times=inMat(:,1); %assigining variables for population size and time points
logIdx=pop<T; logPop=pop(logIdx); logTimes=times(logIdx); %population and times under the required threshold. 
calcArr=logPop./(lamda.^logTimes);
N0=mean(calcArr); %prediction for N0
CI=[N0-2*std(calcArr), N0+2*std(calcArr)]; %calculating the CI for N0
