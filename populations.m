%QUESTION 3

%section A
clear; close all; %i
fileData=dnf_getfile; %ii
lineProp={'ro','bo'}; %iii
fig1=figure;
dnf_plotPop(fileData,lineProp); %iv
dnf_Annotate(fileData) %v



