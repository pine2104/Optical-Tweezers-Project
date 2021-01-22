function [c,n]=binning(data,binsizeA,beginA,endA)

A=data;

edgeA=[beginA:binsizeA:endA];
nA= histcounts(A,edgeA);
nA=nA/sum(nA)/binsizeA;
cA=edgeA(1:length(nA))+binsizeA/2;
binA=cA(2)-cA(1);
c=cA;
n=nA;