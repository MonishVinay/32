
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


% Operator precedence: + and - are lower than * and /.
op_priority('+', 1).
op_priority('-', 1).
op_priority('*', 2).
op_priority('/', 2).

% Convert an expression tree into its canonical string.
format_expr(Tree, String) :-
    format_expr_context(Tree, 0, root, String).

% A number needs no parentheses.
format_expr_context(num(N), _, _, String) :-
    format(string(String), '~d', [N]).

% Format a compound expression recursively.

format_expr_context(tree(Op, Left, Right),
                    ParentPriority, Side, String) :-
    op_priority(Op, Priority),
    format_expr_context(Left, Priority, left, LeftString),
    format_expr_context(Right, Priority, right, RightString),
    format(string(Body), '~s~w~s',
           [LeftString, Op, RightString]),
    (   (   Side == left,
            Priority < ParentPriority
        ;   Side == right,
            Priority =< ParentPriority
        )
    ->  format(string(String), '(~s)', [Body])
    ;   String = Body
    ).


% Generate a valid arithmetic equation from the given numbers.
generate_equation(Numbers, Equation) :-
    % Split into two nonempty sides.
    append(LeftNums, RightNums, Numbers),
    LeftNums = [_|_],
    RightNums = [_|_],

    % Generate expression trees for both sides.
    expression_tree(LeftNums, LeftExpr),
    expression_tree(RightNums, RightExpr),

    % Evaluate both expressions.
    evaluate_expr(LeftExpr, LeftValue),
    evaluate_expr(RightExpr, RightValue),

    % Both sides must have equal values.
    LeftValue =:= RightValue,

    % Convert trees to canonical strings.
    format_expr(LeftExpr, LeftString),
    format_expr(RightExpr, RightString),

    % Combine them into one equation string.
    format(string(Equation), '~s=~s',
           [LeftString, RightString]).


% Find all valid equations, remove duplicates and sort them.
all_equations(Numbers, Equations) :-
    findall(Equation,
            generate_equation(Numbers, Equation),
            All),
    sort(All, Equations).

% Count the number of unique valid equations.
count_equations(Numbers, N) :-
    all_equations(Numbers, Equations),
    length(Equations, N).

