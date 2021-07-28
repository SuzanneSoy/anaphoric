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

(check-equal?
 '()
 (amap (/ it 0) '())
 "Empty list.")
