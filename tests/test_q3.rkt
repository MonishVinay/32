#lang racket/base

(require rackunit
         rackunit/text-ui
         racket/port
         "../code/32_q3.rkt")

; Trees from the assignment.
(define t1
  '(4
    (2 (1 () ()) (3 () ()))
    (6 (5 () ()) (7 () ()))))

(define t2
  '(1 () (2 () (3 () ()))))

(define t3
  '(a (b () ()) (c () ())))

; Additional edge cases.
(define empty-tree '())
(define single-tree '(5 () ()))

; Capture printed output for comparison.
(define (capture-output fn tree)
  (with-output-to-string
    (lambda ()
      (fn tree))))

(define q3-tests
  (test-suite
   "Q3 Binary Tree Traversals"

   ; ---- Inorder traversal ----

   (test-case "inorder balanced tree"
     (check-equal?
      (capture-output print-inorder t1)
      "(1 2 3 4 5 6 7)\n"))

   (test-case "inorder right skewed tree"
     (check-equal?
      (capture-output print-inorder t2)
      "(1 2 3)\n"))

   (test-case "inorder symbols"
     (check-equal?
      (capture-output print-inorder t3)
      "(b a c)\n"))

   (test-case "inorder empty tree"
     (check-equal?
      (capture-output print-inorder empty-tree)
      "()\n"))

   (test-case "inorder single node"
     (check-equal?
      (capture-output print-inorder single-tree)
      "(5)\n"))

   ; ---- All traversals ----

   (test-case "all traversals balanced tree"
     (check-equal?
      (capture-output print-all-traversals t1)
      "(1 2 3 4 5 6 7)\n(4 2 1 3 6 5 7)\n(1 3 2 5 7 6 4)\n"))

   (test-case "all traversals right skewed"
     (check-equal?
      (capture-output print-all-traversals t2)
      "(1 2 3)\n(1 2 3)\n(3 2 1)\n"))

   (test-case "all traversals symbols"
     (check-equal?
      (capture-output print-all-traversals t3)
      "(b a c)\n(a b c)\n(b c a)\n"))

   (test-case "all traversals empty tree"
     (check-equal?
      (capture-output print-all-traversals empty-tree)
      "()\n()\n()\n"))

   (test-case "all traversals single node"
     (check-equal?
      (capture-output print-all-traversals single-tree)
      "(5)\n(5)\n(5)\n"))

   ; ---- Height and leaf count ----

   (test-case "height and leaves balanced"
     (check-equal?
      (capture-output print-height-and-leaves t1)
      "(3 4)\n"))

   (test-case "height and leaves skewed"
     (check-equal?
      (capture-output print-height-and-leaves t2)
      "(3 1)\n"))

   (test-case "height and leaves symbols"
     (check-equal?
      (capture-output print-height-and-leaves t3)
      "(2 2)\n"))

   (test-case "height and leaves empty"
     (check-equal?
      (capture-output print-height-and-leaves empty-tree)
      "(0 0)\n"))

   (test-case "height and leaves single node"
     (check-equal?
      (capture-output print-height-and-leaves single-tree)
      "(1 1)\n"))

   (test-case "left skewed tree"
     (check-equal?
      (capture-output print-all-traversals
                      '(3 (2 (1 () ()) ()) ()))
      "(1 2 3)\n(3 2 1)\n(1 2 3)\n"))

   (test-case "left skewed height and leaves"
     (check-equal?
      (capture-output print-height-and-leaves
                      '(3 (2 (1 () ()) ()) ()))
      "(3 1)\n"))

   (test-case "unequal subtree heights"
     (check-equal?
      (capture-output print-height-and-leaves
                      '(5 (3 (2 () ()) ()) (8 () ())))
      "(3 2)\n"))

   (test-case "single symbol node"
     (check-equal?
      (capture-output print-all-traversals
                      '(a () ()))
      "(a)\n(a)\n(a)\n"))))
   
(run-tests q3-tests)
