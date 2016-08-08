#lang racket

(require anaphoric/if-let
         rackunit)

(define lst '(x y z a b c))

(check-equal? (if-let [x (member 'a lst)]
                (begin (check-equal? x '(a b c))
                       'seen)
                (fail "aif selected wrong branch"))
              'seen)

(check-equal? (let ([x 'outer])
                (if-let [x (member 'a lst)]
                  (begin (check-equal? x '(a b c))
                         'seen)
                  (fail "aif selected wrong branch")))
              'seen)

(check-equal? (let ([x 'outer])
                (if-let [x (member 'absent lst)]
                  (fail "aif selected wrong branch")
                  'outer))
              'outer)
