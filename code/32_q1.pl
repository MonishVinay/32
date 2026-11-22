
% Clue 1: The person who prefers AI is not in research and is not Dana.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \= research,
    Name \= 'Dana'.

% Clue 2: Alex is not in development and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.
