

#lang racket/base

; Count the number of top-level elements in a list.
(define (my-length lst)
  (let loop ((remaining lst) (count 0))
    (if (null? remaining)
        count
        (loop (cdr remaining) (+ count 1)))))


; Apply a function to each element of a list.
(define (my-map fn lst)
  (if (null? lst)
      '()
      (cons (fn (car lst))
            (my-map fn (cdr lst)))))
(provide my-length my-map)