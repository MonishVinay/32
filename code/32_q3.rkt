
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
(provide print-inorder)