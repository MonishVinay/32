
#lang racket/base

(require rackunit
         rackunit/text-ui
         racket/port
         racket/list
         "../code/32_q4.rkt")

(define q4-tests
  (test-suite
   "Q4 Nested List Insertion"

   ; ---- my-length ----

   (test-case "length of flat list"
     (check-equal? (my-length '(1 2 3)) 3))

   (test-case "length of nested list"
     (check-equal? (my-length '((1 2) (3) 4)) 3))

   (test-case "length of empty list"
     (check-equal? (my-length '()) 0))

   ; ---- my-map ----

   (test-case "map doubles numbers"
     (check-equal?
      (my-map (lambda (x) (* x 2)) '(1 2 3))
      '(2 4 6)))

   (test-case "map empty list"
     (check-equal?
      (my-map (lambda (x) (+ x 1)) '())
      '()))

   (test-case "map nested elements"
     (check-equal?
      (my-map (lambda (x) (cons 0 x))
              '((1 2) (3)))
      '((0 1 2) (0 3))))

   ; ---- Assignment examples ----

   (test-case "example 1"
     (check-equal?
      (insert-if-short 42
                       '((1 2) (3 4 5) (6) ())
                       3)
      '((42 1 2) (3 4 5) (42 6) (42))))

   (test-case "example 2"
     (check-equal?
      (insert-if-short 0
                       '(((1) 2) (3) ((4 5 6) ()))
                       3)
      '((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))))

   (test-case "empty list positive threshold"
     (check-equal?
      (insert-if-short 7 '() 3)
      '(7)))

   (test-case "empty list zero threshold"
     (check-equal?
      (insert-if-short 7 '() 0)
      '()))

   ; ---- Edge cases ----

   (test-case "length equals threshold"
     (check-equal?
      (insert-if-short 9 '(1 2 3) 3)
      '(1 2 3)))

   (test-case "top level insertion"
     (check-equal?
      (insert-if-short 9 '(1 2) 3)
      '(9 1 2)))

   (test-case "nested empty lists"
     (check-equal?
      (insert-if-short 5 '(() ()) 2)
      '((5) (5))))

   (test-case "zero threshold changes nothing"
     (check-equal?
      (insert-if-short 9 '((1) () (2 3)) 0)
      '((1) () (2 3))))

   (test-case "original lengths used"
     (check-equal?
      (insert-if-short 9 '((1) (2)) 2)
      '((9 1) (9 2))))

   ; ---- Higher-order make-inserter ----

   (test-case "make-inserter less than three"
  (define insert-42
    (make-inserter 42
                   (lambda (len) (< len 3))))
  (check-equal?
   (insert-42 '((1 2) (3 4 5) (6)))
   '((42 1 2) (3 4 5) (42 6))))

   (test-case "make-inserter custom condition"
     (define insert-8
       (make-inserter 8 (lambda (len) (= len 2))))
     (check-equal?
      (insert-8 '((1 2) (3) (4 5)))
      '((8 1 2) (3) (8 4 5))))

   ; ---- Input and output ----

   (test-case "print-insert-result example"
     (define output
       (parameterize
           ([current-input-port
             (open-input-string
              "42\n((1 2) (3 4 5) (6) ())\n3\n")])
         (with-output-to-string
           (lambda ()
             (print-insert-result)))))
     (check-equal?
      output
      "((42 1 2) (3 4 5) (42 6) (42))\n"))

   ; ---- Stress tests ----

   (test-case "nesting depth 100"
     (define deep
       (for/fold ([v '()])
                 ([i (in-range 100)])
         (list v)))
     (define expected
       (for/fold ([v '(9)])
                 ([i (in-range 100)])
         (list 9 v)))
     (check-equal?
      (insert-if-short 9 deep 2)
      expected))

   (test-case "list with 10000 elements"
     (define large-list (make-list 10000 1))
     (check-equal?
      (insert-if-short 9 large-list 1)
      large-list))))

; Return a nonzero exit code if any test fails.
(exit (if (= (run-tests q4-tests) 0) 0 1))
