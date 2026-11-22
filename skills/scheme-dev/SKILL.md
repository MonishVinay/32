
---
name: scheme-dev
description: Develop, test, and review the Scheme solutions for CS F301 Assignment 2 using Racket 8.x and racket/base.
---

# Scheme Development Skill

## Environment
- Language: Scheme using Racket
- Version: Racket 8.x
- Required first line: #lang racket/base
- Problems: S1 (Binary Tree Traversals) and S2 (Nested List Insertion)
- Files: id_q3.rkt and id_q4.rkt, with id replaced by the actual group ID.

## Coding Conventions
- Use lowercase hyphen-separated function names.
- Use meaningful parameter and helper names.
- Explain recursive functions by stating their base case and recursive case.
- Prefer structural recursion for trees and lists.
- Prefer tail recursion when natural.
- Pass state through function arguments.
- Avoid mutation, global state, and unnecessary intermediate lists.
- Keep output exactly as required.

## Allowed Built-ins
Use only:
- define, lambda
- let, let*, letrec, named let
- if, cond (including else)
- and, or, not, begin
- quote (')
- cons, car, cdr, list
- Compositions of car and cdr up to four levels
- null?, pair?, eq?, assq, assoc
- +, -, *, <, >, <=, >=, =
- display, newline

S2 additionally permits:
- read

## Forbidden Built-ins and Features
Do not use:
- set! or related mutation operations
- vectors, hash tables, strings
- do, for, or any other loop construct
- length, append, reverse
- map, filter
- member, memq
- list-ref, list-tail
- Other built-ins not explicitly allowed

Write recursive helpers when the functionality of a forbidden built-in is required.

## S1 Requirements
- Represent empty trees using '().
- Represent nonempty trees as (value left right).
- Visit the left subtree before the right subtree.
- Inorder: left, node, right.
- Preorder: node, left, right.
- Postorder: left, right, node.
- Height of an empty tree is zero.
- Height of a node is one plus the greater subtree height.
- A leaf has two empty children.
- Empty trees have zero leaves.
- print-inorder outputs one list and a newline.
- print-all-traversals outputs three lists on separate lines.
- print-height-and-leaves outputs (height leaf-count) and a newline.
- Preserve the provided template and required calls.

## S2 Requirements
- Read x, lst, and n in that order.
- Print only the final list followed by a newline.
- Check every list at every nesting level, including the outer list.
- Measure each list's original top-level length before insertion.
- Treat empty lists as length zero.
- Do not mistake atoms for lists.
- Define recursive my-length and my-map helpers.
- Define make-inserter as a higher-order function.
- make-inserter accepts x and a length predicate len-ok?.
- The returned function transforms a nested list recursively.
- Define insert-if-short using make-inserter.
- Keep exactly one final definition of insert-if-short.
- Support deeply nested lists and large input lists.
- Avoid unnecessary quadratic-time list operations.

## Running and Testing
Check Racket:

    racket --version

Run S1:

    racket code/id_q3.rkt

Run S2:

    racket code/id_q4.rkt

For S2, provide the three input expressions through standard input.

Replace id with the actual group ID.

## AI Decomposition Rule
- Each AI prompt requests one function, one test file, or one review.
- Never request the full solution to an assignment problem.
- Develop helpers and required functions incrementally.
- Verify each logical unit before proceeding.
- Record all AI prompts verbatim in the relevant prompt-history file.
- Commit genuine incremental changes.
- Never fabricate test results or execution output.

## Self-Review Checklist
Before answering or delivering code:
1. Is the first line #lang racket/base?
2. Does the response cover only the requested unit?
3. Are all used built-ins explicitly permitted?
4. Are forbidden functions replaced with recursive helpers?
5. Are the empty-list base cases correct?
6. Does every recursive call make progress?
7. Is list traversal order preserved?
8. Does the algorithm avoid accidental mutation?
9. Does printing match the exact required format?
10. Are large and deeply nested inputs considered?
11. Can the function be explained clearly in a viva?

## Common AI Failure Modes
- Using forbidden convenience functions such as map or append.
- Forgetting that racket/base exposes functions forbidden here.
- Mixing atoms and nested lists incorrectly.
- Incorrectly handling the empty list.
- Reversing traversal results.
- Incorrect height or leaf-count calculations.
- Measuring list length after insertion rather than before.
- Failing to process the outermost list.
- Repeatedly inserting an atom into already transformed lists.
- Defining insert-if-short more than once in the final file.
- Using inefficient recursion on long lists.
- Printing debug messages or prompts.
- Using a missing or incorrect #lang declaration.
