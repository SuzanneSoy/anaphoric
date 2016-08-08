#lang racket

(require anaphoric/awhen
         rackunit)

(define lst '(x y z a b c))
(define seen 0)

(check-equal? (awhen (member 'absent lst)
                (fail "awhen should not have executed body")
                'seen)
              (void))

(check-equal? (awhen (member 'a lst)
                it)
              '(a b c))


(check-equal? (awhen (member 'a lst)
                (set! seen (add1 seen))
                (check-equal? it '(a b c))
                'seen)
              'seen)
(check-equal? seen 1) ;; Multiple body statements