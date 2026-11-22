
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

% Clue 3: The person working in testing likes Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% Clue 4: Ben prefers web projects and does not work in testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

% Clue 5: The person who prefers Java works in design.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% Clue 6: Carla does not prefer embedded projects or work in development.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Dept \= development,
    Project \= embedded.

% Clue 7: Dana does not prefer Java and works in research or testing.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    (Dept = research ; Dept = testing).

% Clue 8: The person who prefers data works in research and does not use JavaScript.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.


