#lang racket

(require anaphoric/acond
         rackunit)

(define lst '(x y z a b c))
(define seen 0)

;; With else branch
(check-equal? (acond
                [(member 'a lst) (set! seen (add1 seen))
                                 (check-equal? it '(a b c))
                                 'seen-01]
                [(member 'b lst) (fail "acond selected wrong branch")]
                [else (fail "acond selected wrong branch")])
              'seen-01)
(check-equal? seen 1) ;; multiple body statements

(check-equal? (acond
                [(member 'absent lst) (fail "acond selected wrong branch")]
                [(member 'b lst) (begin (check-equal? it '(b c))
                                        'seen-02)]
                [else (fail "acond selected wrong branch")])
              'seen-02)

(check-equal? (acond
                [(member 'absent lst) (fail "acond selected wrong branch")]
                [(member 'absent2 lst) (fail "acond selected wrong branch")]
                [else 'seen-03])
              'seen-03)

;; Just else branch
(check-equal? (acond
                [else 'seen-04])
              'seen-04)

;; Multiple body statements

(check-equal? (acond
                [(member 'absent lst) (fail "acond selected wrong branch")]
                [(member 'absent2 lst) (fail "acond selected wrong branch")]
                [else (set! seen (add1 seen))
                      'seen-05])
              'seen-05)
(check-equal? seen 2)

;; Without else branch
(check-equal? (acond
                [(member 'a lst) (set! seen (add1 seen))
                                 (check-equal? it '(a b c))
                                 'seen-06]
                [(member 'b lst) (fail "acond selected wrong branch")])
              'seen-06)
(check-equal? seen 3)

(check-equal? (acond
                [(member 'absent lst) (fail "acond selected wrong branch")]
                [(member 'b lst) (begin (check-equal? it '(b c))
                                        'seen-07)])
              'seen-07)

(check-equal? (acond
                [(member 'absent lst) (fail "acond selected wrong branch")]
                [(member 'absent2 lst) (fail "acond selected wrong branch")])
              (void))

;; No branch
(check-equal? (acond)
              (void))

;; Single branch
(check-equal? (acond
                [(member 'a lst) (begin (check-equal? it '(a b c))
                                        'seen-09)])
              'seen-09)

(check-equal? (acond
                [(member 'absent lst) (fail "acond selected wrong branch")])
              (void))