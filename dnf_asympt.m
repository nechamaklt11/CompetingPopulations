function [const,CI,Idx]=dnf_asympt(arr,eps)
%QUESTION 3 SECTION B
%the function recgonizes the index and value of a graph's convergence point.
%INPUTS: arr - one dimensional array. eps - stabilization criterion.
%OUTPUTS: const - estimated constant. CI - confidence interval. Idx - the
%index of the convergence point.

%subsection iii
last5=arr(end-4:end); %(1). selecting the 5 last values of the array.
est_const=mean(last5);%(2). calculate estimated convergence constant.
est_noise=mean(last5);%(3). calculate estimated noise value.
while true
    dist=abs(arr-est_const); %(4a). calculate the distance between the array values and the estimated constant.
    %ERROR IN THE QUESTION - the estimated constant i est_const, and not eps
    Idx=find(dist<est_noise); %(4b)
    const=mean(arr(Idx:end)); %(4c)
    noise=std(arr(Idx:end)); %(4d)
    conv=abs(est_const-const)/noise; %(4e)
    if conv<eps %(4f)
        break
    else
        est_const=const; %(4g)
        est_noise=noise; %(5)
    end
end

CI_low=const-2*noise; CI_high=const+2*noise; %(6)
%NOT CLEAR FROM THE QUESTION: is the CI should be 2 values array?
CI=[CI_low,CI_high];



