#lang racket/base

(require anaphoric/amap
         rackunit)

(check-equal?
 '(2 3)
 (amap (add1 it) '(1 2))
 "Sanity check.")

(check-equal?
 '("2" "4")
 (amap (number->string (+ it it)) '(1 2))
 "Multiple 'it' in a nested expression.")

(define (f lst)
  (amap (/ it 0) lst))

(check-equal?
 '()
 (f '())
 "Empty list.")

(check-exn
   exn:fail?
   (lambda () (f '(1)))
   "To get 100% code coverage for the f function.")
