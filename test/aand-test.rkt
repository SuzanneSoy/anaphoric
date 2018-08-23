#lang racket

(require anaphoric/aand
         rackunit)

(define lst '(x b 2 y z a b c 1 2 3))

(check-equal? (aand)
              #t)

(check-equal? (aand #f)
              #f)

(check-equal? (aand (member 'y lst))
              '(y z a b c 1 2 3))

(check-equal? (aand (member 'y lst)
                    (member 'b lst)
                    (member '2 lst))
              '(2 y z a b c 1 2 3))

(check-equal? (aand (member 'y lst)
                    (member 'b lst)
                    (member '2 it))
              '(2 y z a b c 1 2 3))

(check-equal? (aand (member 'y lst)
                    (member 'b it)
                    (member '2 it))
              '(2 3))

(check-equal? (aand (member 'absent lst)
                    (fail "aand selected wrong branch"))
              #f)
