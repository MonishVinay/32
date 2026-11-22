

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


; Insert x into all lists whose original length is less than n.
(define (insert-if-short x lst n)
  ((make-inserter x
                  (lambda (len) (< len n)))
   lst))


; Read x, lst and n, then print the transformed list.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read))
         (result (insert-if-short x lst n)))
    (display result)
    (newline)))

