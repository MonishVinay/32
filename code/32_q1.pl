
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

% Generate all possible assignments without repeating attribute values.
generate_solution(Solution) :-
    permutation([research, development, design, testing],
                [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript],
                [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data],
                [P1, P2, P3, P4]),
    Solution = [
        p('Alex', D1, L1, P1),
        p('Ben', D2, L2, P2),
        p('Carla', D3, L3, P3),
        p('Dana', D4, L4, P4)
    ].

% Count assignments satisfying the selected clues.
count_solutions(Active, N) :-
    findall(Solution,
        (generate_solution(Solution),
         forall(member(C, Active), clue(C, Solution))),
        Solutions),
    length(Solutions, N).

% Print one solution satisfying clues 1 to 8.
main :-
    generate_solution(Solution),
    forall(between(1, 8, N), clue(N, Solution)),
    Solution = [
        p('Alex', D1, L1, P1),
        p('Ben', D2, L2, P2),
        p('Carla', D3, L3, P3),
        p('Dana', D4, L4, P4)
    ],
    format('Alex = [~w, ~w, ~w]~n', [D1, L1, P1]),
    format('Ben = [~w, ~w, ~w]~n', [D2, L2, P2]),
    format('Carla = [~w, ~w, ~w]~n', [D3, L3, P3]),
    format('Dana = [~w, ~w, ~w]~n', [D4, L4, P4]).




