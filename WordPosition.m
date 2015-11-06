function pos = WordPosition(Words,word)
% get the position of word in Words
%
% Author: Diego Vidaurre, OHBA, University of Oxford

pos = [];
if ~isempty(Words)
    pos = find(sum(abs(bsxfun(@minus, Words, word)),2) == 0);
end
end