function [MI,probr,probs,probsr] = getMI(r,s)
% Computes the mutual information of two sequences 
%
% INPUT
% r: sequence of discrete values for the response 
% s: sequence of discrete values for the stimulus
% maxCard: maximum number of values to be considered, so that the values
%   with the lowest probability will be ignored - not yet implemented
% 
% OUTPUT
% MI: mutual info
% probr: probability of each possible value of the response
% probr: probability of each possible value of the stimulus
% probsr: joint probability of response and stimulus
% 
% Author: Diego Vidaurre, OHBA, University of Oxford

N = length(r);
setr = unique(r); Cr = length(setr); Lr = length(setr);
sets = unique(s); Cs = length(sets); Ls = length(sets);

probr = zeros(Cr,1);
probs = zeros(Cs,1);
probsr = zeros(Cr,Cs);
MI = 0;

for i = 1:Lr
    x = setr(i);
    rx = (r==x);
    probr(i) = max(sum(rx) / N, realmin);
    for j = 1:Ls
        y = sets(j);
        sy = (s==y);
        probsr(i,j) = max(sum(sy & rx) / N, realmin);
        if i==1, probs(j) = max(sum(sy) / N, realmin); end
        MI = MI + probsr(i,j) * log( probsr(i,j) / probr(i) / probs(j) );
    end
end

end

