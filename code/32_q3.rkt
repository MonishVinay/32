
#lang racket/base

; Build the inorder list using an accumulator.
(define (inorder-acc tree acc)
  (if (null? tree)
      acc
      (inorder-acc (cadr tree)
                   (cons (car tree)
                         (inorder-acc (caddr tree) acc)))))

; Print the inorder traversal.
(define (print-inorder tree)
  (display (inorder-acc tree '()))
  (newline))

; Build preorder traversal: root, left, right.
(define (preorder-acc tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder-acc (cadr tree)
                          (preorder-acc (caddr tree) acc)))))

; Build postorder traversal: left, right, root.
(define (postorder-acc tree acc)
  (if (null? tree)
      acc
      (postorder-acc (cadr tree)
                     (postorder-acc (caddr tree)
                                    (cons (car tree) acc)))))

; Print inorder, preorder and postorder on separate lines.
(define (print-all-traversals tree)
  (display (inorder-acc tree '()))
  (newline)
  (display (preorder-acc tree '()))
  (newline)
  (display (postorder-acc tree '()))
  (newline))


; Calculate the height of a binary tree.
(define (tree-height tree)
  (if (null? tree)
      0
      (+ 1
         (max (tree-height (cadr tree))
              (tree-height (caddr tree))))))

; Count the number of leaf nodes.
(define (leaf-count tree)
  (if (null? tree)
      0
      (if (and (null? (cadr tree))
               (null? (caddr tree)))
          1
          (+ (leaf-count (cadr tree))
             (leaf-count (caddr tree))))))

; Print height and leaf count as one list.
(define (print-height-and-leaves tree)
  (display (list (tree-height tree)
                 (leaf-count tree)))
  (newline))

