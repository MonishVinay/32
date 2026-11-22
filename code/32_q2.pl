
% Generate arithmetic expression trees while keeping numbers in order.

% A single number is an expression.
expression_tree([N], num(N)) :-
    integer(N),
    N >= 0.

% Split the list into two nonempty parts and join their expressions.
expression_tree(Numbers, tree(Op, LeftExpr, RightExpr)) :-
    append(Left, Right, Numbers),
    Left = [_|_],
    Right = [_|_],
    expression_tree(Left, LeftExpr),
    expression_tree(Right, RightExpr),
    member(Op, ['+', '-', '*', '/']).


% Evaluate an arithmetic expression tree.

% Base case: a number evaluates to itself.
evaluate_expr(num(N), N) :-
    integer(N).

% Addition.
evaluate_expr(tree('+', Left, Right), Value) :-
    evaluate_expr(Left, A),
    evaluate_expr(Right, B),
    Value is A + B.

% Subtraction.
evaluate_expr(tree('-', Left, Right), Value) :-
    evaluate_expr(Left, A),
    evaluate_expr(Right, B),
    Value is A - B.

% Multiplication.
evaluate_expr(tree('*', Left, Right), Value) :-
    evaluate_expr(Left, A),
    evaluate_expr(Right, B),
    Value is A * B.

% Exact division only.
evaluate_expr(tree('/', Left, Right), Value) :-
    evaluate_expr(Left, A),
    evaluate_expr(Right, B),
    B =\= 0,
    0 is A mod B,
    Value is A // B.

