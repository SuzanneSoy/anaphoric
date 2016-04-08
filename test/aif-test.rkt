#lang racket

(require anaphoric/aif
         rackunit)

(define lst '(x y z a b c))

(check-equal? (aif (member 'a lst)
                (begin (check-equal? it '(a b c))
                       'seen)
                (fail "aif selected wrong branch"))
              'seen)

(check-equal? (aif (member 'absent lst)
                (fail "aif selected wrong branch")
                'seen)
              'seen)
