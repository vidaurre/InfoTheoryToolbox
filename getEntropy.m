function Entropy = getEntropy (PWords)
% Computes the entropy of the word distribution 
% 
% Author: Diego Vidaurre, OHBA, University of Oxford

Entropy = -sum(PWords .* log(PWords));