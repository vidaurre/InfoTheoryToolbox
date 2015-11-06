function word = getWord(gamma,bins,tau)
% Obtains the word encoded in the provided state time courses (gamma),
% using the specified vector of bins (bins indicates the beginning of each
% bin) and the duration of the bins (tau, by default, indicates the difference
% between starting bin points) 
%
% The word has letters that are discrete - each letter is assigned as the state 
% with maximal fractional occupancy in the corresponding interval
% 
%
% Author: Diego Vidaurre, OHBA, University of Oxford


if nargin<3, 
    if length(bins)==1, error('You need to specify tau if there is only one bin')
    else tau = bins(2) - bins(1);
    end
end
word = zeros(1,length(bins));
for j = 1:length(bins)
    if size(gamma,1)==1, 
        w = gamma;
    else
        w = sum(gamma(bins(j):bins(j)+tau-1,:));
    end
    [~,k] = max(w);
    word(j) = k;
end
end
