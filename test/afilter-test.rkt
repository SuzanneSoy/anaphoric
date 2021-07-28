#lang racket/base

(require anaphoric/afilter
         rackunit)

(define lst '(5 6 7 8 9))

(check-equal?
 '(6 8)
 (afilter (odd? (add1 it)) lst)
 "Nested function call.")

(check-equal?
 '(8 9)
 (afilter ((* it it) . > . 50) lst)
 "Multiple 'it' in a nested expression.")

(define (f lst)
  (afilter (/ it 0) lst))

(check-equal?
 '()
 (f '())
 "Empty list.")

(check-exn
   exn:fail?
   (lambda () (f '(1)))
   "To get 100% code coverage for the f function.")
