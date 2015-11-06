function [KL,Words,P] = getKLdiv(P1,Words1,P2,Words2)
% Computes the KL divergence of the word distributions.
%
% INPUT
% P1 and P2 are vectors with the probabilities of each word
% Words1 and Words2 are matrices with the words used in each of the distributions 
%           (No of words by no. of letters)
% (typically P1 will be the distribution while stimulus 
% and P2 will be the baseline distribution)
%
% OUTPUT
% KL: Kullback leibler divergence for each word - you need to sum(KL)
% Words: Joint list of words, ordered by contribution to KL
% P: probability distribution for Words. 
% 
% Author: Diego Vidaurre, OHBA, University of Oxford

N1 = length(P1); N2 = length(P2); p = size(Words1,2);
Words = zeros(N1,p);
P = zeros(N1,2); % 2 columns, p(w in 1), p(w in 2)  

seen = false(N2,1);

for j = 1:N1
    w1 = Words1(j,:);
    Words(j,:) = w1;
    P(j,1) = P1(j);
    found = false;
    for i = find(~seen)'
        w2 = Words2(i,:);
        if all(w1==w2)
            seen(i) = true;
            P(j,2) = P2(i);
            found = true;
            break
        end
    end
    if ~found
        P(j,2) = eps;
    end
end

for i = find(~seen)'
    Words = [Words; Words2(i,:)];
    P = [P; [realmin P2(i)]];
end

KL = P(:,1) .* log(P(:,1) ./ P(:,2));
[KL,I] = sort(KL,'descend');
Words = Words(I,:);
P = P(I,:);

end