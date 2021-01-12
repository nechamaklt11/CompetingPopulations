close all; clear; 
popData=dnf_getfile;
figure
dnf_plotPop(popData,{'ro','go'})
dnf_addAnnotation(popData)