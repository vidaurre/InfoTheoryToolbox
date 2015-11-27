function [PSequences, Sequences] = getTransDistr(ViterbiPath,T,states,L,ordering,Sequences)
% Computes histograms of transition between states.
% This does something limilar to getWordsDistr, with the difference that it
% does not care about how long a state visit takes. 
%
% INPUTS:
% ViterbiPath: state time courses, in the form of Viterbi path
% T: length of the trials
% L: the length of the sequence (<1)
% order: if 1, the histogram and probabilities will be ordered from highest
%           to lowest occurrence (default 1)
% Sequences: matrix of sequences, with one row per sequence
%       (words not present in Words will be appended at the end)
%           
% OUTPUTS:
% PSequences: Probability of each sequences
% Sequences: matrix of sequences, with one row per word
%
% Author: Diego Vidaurre, OHBA, University of Oxford

if nargin<5, 
    Sequences = []; 
    PSequences = [];
else
    PSequences = zeros(1,size(Sequences,1));
end

if L==2 % quicker 
    K = length(states);
    for in=1:length(T)
        Gam = zeros(T(in),K);
        tt = sum(T(1:in-1))+1:sum(T(1:in));
        for st = states, Gam(ViterbiPath(tt)==st,st) = 1; end
        Xi = Gam(1:end-1,:)' *  Gam(2:end,:);
        for k=1:K, Xi(k,k) = 0; end
        if all(Xi(:)==0), continue; end
        Xi = Xi / sum(Xi(:));
        for k1=1:K
            for k2=1:K
                if Xi(k1,k2)==0, continue; end
                pos = findSeq([k1 k2],Sequences);
                if pos<0
                    Sequences = [Sequences; [k1 k2] ];
                    PSequences = [PSequences 1];
                else
                    PSequences(pos) = PSequences(pos) + 1;
                end
            end
        end
    end
            
else
    error('Not yet implemented for L>2')
end

if ~isempty(PSequences)
    if ordering==1
        [PSequences,I] = sort(PSequences,'descend');
        Sequences = Sequences(I,:);
    end
    PSequences = PSequences / sum(PSequences);
elseif ~isempty(Sequences)
    PSequences = zeros(1,size(Sequences,1));
else
    Sequences = [1 2]; 
    PSequences = 0;
end

end


function pos = findSeq(Seq,Sequences)
    pos = -1;
    if isempty(Sequences)
        return;
    end
    Eq = sum( repmat(Seq,size(Sequences,1),1)==Sequences,2 ) / size(Sequences,2);
    if any(Eq==1)
        pos = find(Eq==1);
    end
end

