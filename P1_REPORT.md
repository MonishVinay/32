# P1 Report — Department Assignment Puzzle

## Number of Solutions

Using `count_solutions([1,2,3,4,5,6,7,8], N)`, we obtained:

**N = 3**

This means the original eight clues do not uniquely determine the assignments. There are three different solutions satisfying all the given constraints.

We added the following clue as clue 9 to make our solution unique:

"The person who prefers AI projects works in the testing department."

After including this clue, `count_solutions([1,2,3,4,5,6,7,8,9], N)` gives:

**N = 1**

Therefore, the additional clue eliminates the other two possibilities and makes the puzzle have exactly one solution.