function idx = regexpcell(c,pat,inv)

% idx = regexpcell(c,pat,inv)
%
% Return indices idx of cells in c that match pattern(s) pat (regular expression).
% return indexes that do not match the pattern if inv is true (optional).
% Pattern pat can be char or cellstr, in which case regexpcell returns
% indexes of cells that match any pattern in pat.
% 
% v1 Maximilien Chaumon 01/05/09

error(nargchk(2,3,nargin))
if not(iscellstr(c))
    error('input c must be a cell array of strings');
end

if ischar(pat)
    pat = cellstr(pat);
end

idx = [];
for i_pat = 1:length(pat)
    trouv = regexp(c,pat{i_pat}); % apply regexp on each pattern
    for i = 1:numel(trouv)
        if not(isempty(trouv{i}))% if there is a match, store index
            idx(end+1) = i;
        end
    end
end
if exist('inv','var') && inv % if we want to invert result, then do so.
    others = 1:numel(trouv);
    others(idx) = [];
    idx = others;
end