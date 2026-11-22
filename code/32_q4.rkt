

#lang racket/base

; Count the number of top-level elements in a list.
(define (my-length lst)
  (let loop ((remaining lst) (count 0))
    (if (null? remaining)
        count
        (loop (cdr remaining) (+ count 1)))))

(provide my-length)
