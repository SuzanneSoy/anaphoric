#lang racket

(require anaphoric/when-let
         rackunit)

(define lst '(x y z a b c))
(define seen 0)

(check-equal? (when-let [x (member 'absent lst)]
                (fail "awhen should not have executed body")
                'seen)
              (void))

(check-equal? (when-let [x (member 'a lst)]
                x)
              '(a b c))

(check-equal? (let ([x 'outer])
                (list (when-let [x (member 'a lst)]
                        x)
                      x))
              '((a b c) outer))

(check-equal? (when-let [x (member 'a lst)]
                (set! seen (add1 seen))
                (check-equal? x '(a b c))
                'seen)
              'seen)
(check-equal? seen 1) ;; Multiple body statements