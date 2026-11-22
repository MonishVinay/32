
---
name: prolog-dev
description: Develop, test, and review the Prolog solutions for CS F301 Assignment 2 using SWI-Prolog 9.x.
---

# Prolog Development Skill

## Environment
- Language: Prolog
- Interpreter: SWI-Prolog 9.x
- Problems: P1 (Department Assignment Puzzle) and P2 (Arithmetic Equation)
- Files: id_q1.pl and id_q2.pl, with id replaced by the actual group ID.

## Coding Conventions
- Use lowercase snake_case for predicate names.
- Use meaningful uppercase variable names.
- Write declarative predicates with clearly specified argument roles.
- Prefer pure logical relations and explicit recursion.
- Keep predicates small and focused.
- Add comments for non-obvious constraints and algorithms.
- Avoid unnecessary cuts and nontermination.
- Do not hard-code puzzle solutions or equation results.
- Keep generated outputs exactly as specified.

## Assignment Restrictions
- Never use assert/1, retract/1, or global variables such as b_setval/2 and nb_setval/2.
- Only these libraries are permitted: lists, apply, yall, aggregate.
- Do not use halt/0.
- Do not use initialization(main, main).
- Do not introduce extra printed output.

## P1 Requirements
- Represent each person as p(Name, Dept, Lang, Project).
- Preserve the order Alex, Ben, Carla, Dana.
- Use exactly the atoms specified in the assignment.
- Every attribute category is a permutation of its four values.
- Implement each numbered clue as clue(N, Solution).
- Each clue must work on a fully instantiated solution.
- main/0 prints one derived solution in the required four-line format.
- count_solutions(Active, N) must apply exactly the listed clues.
- Use findall/3 or aggregate_all/3 for counting.
- Clue 9 must make the solution unique.
- The comment immediately preceding clue 9 must start with "% CLUE 9:".
- Clue 9 must not mention a person by name.
- Record the full-clue count and interpretation in P1_REPORT.md.

## P2 Requirements
- Preserve every input number exactly once and in order.
- Allow exactly one equality sign between the numbers.
- Enumerate valid binary expression trees.
- Allow +, -, *, and / operators.
- Do not use unary minus or concatenate numbers.
- Every division must have a nonzero divisor and exact integer result.
- Never evaluate an expression by parsing its formatted string.
- Return equations as strings, without spaces.
- Follow the assignment's precedence, associativity, and parentheses rules.
- Keep structurally distinct expression trees distinguishable.
- all_equations/2 must use sort/2 to remove duplicates and sort results.
- generate_equation/2 must fail for unsatisfiable or too-short input.
- No predicate in P2 may print output.

## Running and Testing
Check the interpreter:

    swipl --version

Run P1:

    swipl -q -f code/id_q1.pl

Run a particular Prolog goal:

    swipl -q -f code/id_q1.pl -g "goal" -t halt

Run P2 goals through the same command structure using id_q2.pl.

Use the actual group ID in filenames.

## AI Decomposition Rule
- One AI prompt may request only one predicate, one test file, or one review.
- Never generate an entire problem solution in one prompt.
- Implement one logical unit at a time.
- Review and test the unit before proceeding.
- Make granular commits reflecting genuine progress.
- Preserve every AI prompt verbatim in the relevant prompt-history file.
- Do not invent test results or claim tests passed without running them.

## Self-Review Checklist
Before answering or delivering code:
1. Does this response address only the requested unit?
2. Does the predicate match the required interface?
3. Are all assignment restrictions respected?
4. Are all variables correctly instantiated before arithmetic?
5. Can the predicate terminate on the required inputs?
6. Is backtracking complete where needed?
7. Are duplicate solutions handled correctly?
8. Are output types and formatting correct?
9. Are edge cases covered?
10. Is the code sufficiently clear for an individual viva?

## Common AI Failure Modes
- Hallucinating Prolog predicate names or library availability.
- Confusing unification (=) with arithmetic evaluation (is).
- Using arithmetic comparisons on uninstantiated variables.
- Accidentally pruning valid solutions with cuts.
- Creating unintended duplicate solutions through backtracking.
- Hard-coding a puzzle solution instead of enforcing the clues.
- Ignoring inactive clues during solution counting.
- Returning atoms instead of strings.
- Incorrect parentheses around equal-precedence operators.
- Allowing non-integral or zero-divisor division.
- Nontermination on impossible inputs.
- Adding prohibited printing or initialization behavior.
