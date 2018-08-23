#lang racket

(require anaphoric/and-let
         rackunit)

(define lst '(x b 2 y z a b c 1 2 3))

(check-equal? (and-let)
              #t)

(check-equal? (and-let 42)
              42)

(check-equal? (and-let #f)
              #f)

(check-equal? (and-let [v1 (member 'y lst)]
                v1)
              '(y z a b c 1 2 3))

(check-equal? (and-let [v1 (member 'y lst)]
                       [v2 (member 'b v1)]
                       [v3 (member '2 v2)]
                (list v1 v2 v3))
              '((y z a b c 1 2 3)
                (b c 1 2 3)
                (2 3)))

(check-equal? (let ([v1 'outer]
                    [v2 'outer]
                    [v3 'outer])
                (and-let [v1 (member 'y lst)]
                         [v2 (member 'b v1)]
                         [v3 (member '2 v2)]
                  (list v1 v2 v3)))
              '((y z a b c 1 2 3)
                (b c 1 2 3)
                (2 3)))

(check-equal? (let ([v1 'outer])
                (and-let [v1 (member 'absent lst)]
                  (fail "aand selected wrong branch")))
              #f)

(check-equal? (let ([v1 'outer]
                    [v2 'outer])
                (and-let [v1 (member 'y lst)]
                         [v2 (member 'x v1)]
                  (fail "aand selected wrong branch")))
              #f)
