

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


; Create a function that inserts x into lists satisfying len-ok?.
(define (make-inserter x len-ok?)
  (letrec
      ((insert-list
        (lambda (lst)
          (let ((original-length (my-length lst)))
            (let ((processed
                   (my-map
                    (lambda (item)
                      (if (pair? item)
                          (insert-list item)
                          (if (null? item)
                              (insert-list item)
                              item)))
                    lst)))
              (if (len-ok? original-length)
                  (cons x processed)
                  processed))))))
    insert-list))

(provide my-length my-map make-inserter)