
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
