
:- use_module(library(plunit)).
:- consult('../code/32_q1.pl').

:- begin_tests(q1).

% A valid assignment satisfying clues 1 to 8.
valid_solution([
    p('Alex', design, java, 'AI'),
    p('Ben', development, javascript, web),
    p('Carla', research, 'c++', data),
    p('Dana', testing, python, embedded)
]).

% Another valid assignment satisfying clue 9 as well.
repaired_solution(S) :-
    generate_solution(S),
    forall(between(1, 9, N), clue(N, S)).

% ---- Clue 1 ----
test(clue1_valid, [nondet]) :-
    valid_solution(S),
    clue(1, S).

test(clue1_invalid, [fail]) :-
    clue(1, [
        p('Alex', design, java, web),
        p('Ben', development, javascript, embedded),
        p('Carla', testing, python, data),
        p('Dana', research, 'c++', 'AI')
    ]).

% ---- Clue 2 ----
test(clue2_valid, [nondet]) :-
    valid_solution(S),
    clue(2, S).

test(clue2_invalid, [fail]) :-
    clue(2, [
        p('Alex', research, 'c++', data),
        p('Ben', development, javascript, web),
        p('Carla', design, java, 'AI'),
        p('Dana', testing, python, embedded)
    ]).

% ---- Clue 3 ----
test(clue3_valid) :-
    valid_solution(S),
    clue(3, S).

test(clue3_invalid, [fail]) :-
    clue(3, [
        p('Alex', research, python, data),
        p('Ben', development, javascript, web),
        p('Carla', testing, java, 'AI'),
        p('Dana', design, 'c++', embedded)
    ]).

% ---- Clue 4 ----
test(clue4_valid, [nondet]) :-
    valid_solution(S),
    clue(4, S).

test(clue4_invalid, [fail]) :-
    clue(4, [
        p('Alex', research, java, data),
        p('Ben', testing, python, web),
        p('Carla', design, 'c++', 'AI'),
        p('Dana', development, javascript, embedded)
    ]).

% ---- Clue 5 ----
test(clue5_valid, [nondet]) :-
    valid_solution(S),
    clue(5, S).

test(clue5_invalid, [fail]) :-
    clue(5, [
        p('Alex', research, java, data),
        p('Ben', development, javascript, web),
        p('Carla', design, 'c++', 'AI'),
        p('Dana', testing, python, embedded)
    ]).

% ---- Clue 6 ----
test(clue6_valid, [nondet]) :-
    valid_solution(S),
    clue(6, S).

test(clue6_invalid, [fail]) :-
    clue(6, [
        p('Alex', research, java, data),
        p('Ben', design, javascript, web),
        p('Carla', development, python, 'AI'),
        p('Dana', testing, 'c++', embedded)
    ]).

% ---- Clue 7 ----
test(clue7_valid) :-
    valid_solution(S),
    clue(7, S).

test(clue7_invalid, [fail]) :-
    clue(7, [
        p('Alex', research, python, data),
        p('Ben', development, javascript, web),
        p('Carla', testing, 'c++', 'AI'),
        p('Dana', design, java, embedded)
    ]).

% ---- Clue 8 ----
test(clue8_valid, [nondet]) :-
    valid_solution(S),
    clue(8, S).

test(clue8_invalid, [fail]) :-
    clue(8, [
        p('Alex', research, javascript, data),
        p('Ben', development, 'c++', web),
        p('Carla', design, java, 'AI'),
        p('Dana', testing, python, embedded)
    ]).

% ---- Clue 9 ----
test(clue9_valid, [nondet]) :-
    repaired_solution(S),
    clue(9, S).

test(clue9_invalid, [fail]) :-
    valid_solution(S),
    clue(9, S).

% ---- Solution counting ----
test(original_count) :-
    count_solutions([1,2,3,4,5,6,7,8], 3).

test(repaired_count) :-
    count_solutions([1,2,3,4,5,6,7,8,9], 1).

test(empty_clue_list) :-
    count_solutions([], 13824).

test(single_clue) :-
    count_solutions([1], 7776).

% ---- Assignment generation ----
test(generator_produces_assignments, [nondet]) :-
    generate_solution(_).

test(generator_has_unique_attributes, [nondet]) :-
    generate_solution([
        p('Alex', D1, L1, P1),
        p('Ben', D2, L2, P2),
        p('Carla', D3, L3, P3),
        p('Dana', D4, L4, P4)
    ]),
    sort([D1,D2,D3,D4], Departments),
    sort([L1,L2,L3,L4], Languages),
    sort([P1,P2,P3,P4], Projects),
    length(Departments, 4),
    length(Languages, 4),
    length(Projects, 4).

:- end_tests(q1).
