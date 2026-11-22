
:- use_module(library(plunit)).
:- consult('../code/32_q2.pl').

:- begin_tests(q2).

% ---- Expression generation ----

test(generate_single_number) :-
    once(expression_tree([4], num(4))).

test(generate_two_numbers) :-
    once(expression_tree(
        [4, 2],
        tree('+', num(4), num(2))
    )).

test(generate_empty, [fail]) :-
    expression_tree([], _).

test(generate_preserves_order) :-
    once(expression_tree(
        [4, 2, 3],
        tree('*', num(4),
            tree('+', num(2), num(3)))
    )).

% ---- Arithmetic evaluation ----

test(addition) :-
    evaluate_expr(
        tree('+', num(4), num(2)), 6).

test(subtraction) :-
    evaluate_expr(
        tree('-', num(4), num(7)), -3).

test(multiplication) :-
    evaluate_expr(
        tree('*', num(4), num(3)), 12).

test(exact_division) :-
    evaluate_expr(
        tree('/', num(8), num(4)), 2).

test(non_exact_division, [fail]) :-
    evaluate_expr(
        tree('/', num(5), num(2)), _).

test(division_by_zero, [fail]) :-
    evaluate_expr(
        tree('/', num(5), num(0)), _).

test(nested_expression) :-
    evaluate_expr(
        tree('*', num(4),
            tree('+', num(2), num(3))),
        20).

test(nested_invalid_division, [fail]) :-
    evaluate_expr(
        tree('+',
            tree('/', num(5), num(2)),
            num(3)),
        _).

test(negative_result) :-
    evaluate_expr(
        tree('-', num(3), num(5)), -2).

% ---- Expression formatting ----

test(format_number) :-
    format_expr(num(4), "4").

test(format_addition) :-
    format_expr(
        tree('+', num(4), num(2)),
        "4+2").

test(format_left_parentheses) :-
    format_expr(
        tree('*',
            tree('+', num(4), num(2)),
            num(3)),
        "(4+2)*3").

test(format_right_parentheses) :-
    format_expr(
        tree('*', num(4),
            tree('+', num(2), num(3))),
        "4*(2+3)").

test(format_operator_precedence) :-
    format_expr(
        tree('+', num(4),
            tree('*', num(2), num(3))),
        "4+2*3").

test(format_left_associative) :-
    format_expr(
        tree('-',
            tree('-', num(1), num(2)),
            num(3)),
        "1-2-3").

test(format_right_associative) :-
    format_expr(
        tree('-', num(1),
            tree('-', num(2), num(3))),
        "1-(2-3)").

test(format_equal_precedence_right) :-
    format_expr(
        tree('+', num(1),
            tree('+', num(2), num(3))),
        "1+(2+3)").

test(format_division_parentheses) :-
    format_expr(
        tree('/', num(8),
            tree('*', num(4), num(2))),
        "8/(4*2)").

% ---- Equation generation ----

test(generate_valid_equation) :-
    once(generate_equation(
        [4,2,5,3], _)).

test(generate_expected_equation) :-
    once(generate_equation(
        [2,4,8], "2*4=8")).

test(generate_returns_string) :-
    once((
        generate_equation([4,2,5,3], E),
        string(E)
    )).

test(generate_no_solution, [fail]) :-
    generate_equation([2,3,4], _).

test(generate_equation_empty, [fail]) :-
    generate_equation([], _).

test(generate_one_number, [fail]) :-
    generate_equation([4], _).

% ---- All equations ----

test(all_equations_main_example) :-
    all_equations([4,2,5,3], Es),
    Es == [
        "4*2-5=3",
        "4*2=5+3",
        "4-2=5-3",
        "4/2=5-3",
        "4=2*(5-3)",
        "4=2+(5-3)",
        "4=2+5-3"
    ].

test(all_equations_no_solution) :-
    all_equations([2,3,4], []).

test(all_equations_single_solution) :-
    all_equations([2,4,8], ["2*4=8"]).

test(all_equations_empty) :-
    all_equations([], []).

test(all_equations_one_number) :-
    all_equations([4], []).

% ---- Equation counting ----

test(count_main_example) :-
    count_equations([4,2,5,3], 7).

test(count_no_solution) :-
    count_equations([2,3,4], 0).

test(count_single_solution) :-
    count_equations([2,4,8], 1).

test(count_empty) :-
    count_equations([], 0).

% ---- Sorting and uniqueness ----

test(equations_are_sorted) :-
    all_equations([4,2,5,3], Es),
    sort(Es, Sorted),
    Es == Sorted.

test(no_duplicate_equations) :-
    all_equations([4,2,5,3], Es),
    length(Es, N),
    sort(Es, Unique),
    length(Unique, N).

% Repeated input values must remain separate.
test(repeated_numbers) :-
    all_equations([2,2,4], Es),
    member("2+2=4", Es),
    sort(Es, Es).

% Zero should be supported in valid equations.
test(zero_input) :-
    all_equations([0,0], Es),
    Es == ["0=0"].

% Division by zero must be rejected.
test(zero_divisor, [fail]) :-
    evaluate_expr(
        tree('/', num(8), num(0)), _).

% Negative intermediate results are permitted.
test(negative_intermediate) :-
    evaluate_expr(
        tree('*',
             tree('-', num(2), num(5)),
             num(3)),
        -9).

% Different parenthesized trees must retain distinct strings.
test(distinct_parentheses) :-
    format_expr(
        tree('+', num(1),
             tree('+', num(2), num(3))), A),
    format_expr(
        tree('+',
             tree('+', num(1), num(2)),
             num(3)), B),
    A == "1+(2+3)",
    B == "1+2+3",
    A \== B.

% A single number cannot form an equation.
test(single_number_no_equation) :-
    all_equations([7], Es),
    Es == [].

:- end_tests(q2).
