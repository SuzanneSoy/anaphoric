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

(check-equal?
 '()
 (afilter (= it 42) '())
 "Empty list.")
