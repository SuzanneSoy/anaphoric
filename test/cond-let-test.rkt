#lang racket

(require anaphoric/cond-let
         rackunit)

(define lst '(x y z a b c))
(define seen 0)

;; With else branch
(check-equal? (cond-let
               [[x (member 'a lst)] (set! seen (add1 seen))
                                    (check-equal? x '(a b c))
                                    'seen-01]
               [[x (member 'b lst)] (fail "cond-let chose wrong branch")]
               [else (fail "cond-let chose wrong branch")])
              'seen-01)
(check-equal? seen 1) ;; multiple body statements

(check-equal? (cond-let
               [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
               [[x (member 'b lst)] (begin (check-equal? x '(b c))
                                           'seen-02)]
               [else (fail "cond-let chose wrong branch")])
              'seen-02)

(check-equal? (cond-let
               [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
               [[x (member 'absent2 lst)] (fail "cond-let chose wrong branch")]
               [else 'seen-03])
              'seen-03)

;; Different variable names
(check-equal? (cond-let
               [[x (member 'a lst)] (begin (check-equal? x '(a b c))
                                           'seen-02)]
               [[y (member 'b lst)] (fail "cond-let chose wrong branch")]
               [else (fail "cond-let chose wrong branch")])
              'seen-02)

(check-equal? (cond-let
               [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
               [[y (member 'b lst)] (begin (check-equal? y '(b c))
                                           'seen-02)]
               [else (fail "cond-let chose wrong branch")])
              'seen-02)

;; Shadowing
(check-equal? (let ([x 'outerx] [y 'outery])
                (cond-let
                 [[x (member 'a lst)] (begin (check-equal? x '(a b c))
                                             'seen-02)]
                 [[y (member 'b lst)] (fail "cond-let chose wrong branch")]
                 [else (fail "cond-let chose wrong branch")]))
                'seen-02)

(check-equal? (let ([x 'outerx] [y 'outery])
                (cond-let
                 [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
                 [[y (member 'b lst)] (begin (check-equal? y '(b c))
                                             'seen-02)]
                 [else (fail "cond-let chose wrong branch")]))
              'seen-02)

(check-equal? (let ([x 'outerx] [y 'outery])
                (cond-let
                 [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
                 [[y (member 'absent lst)] (fail "cond-let chose wrong branch")]
                 [else (list x y)]))
              '(outerx outery))

;; Just else branch
(check-equal? (cond-let
               [else 'seen-04])
              'seen-04)

;; Multiple body statements

(check-equal? (cond-let
               [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
               [[x (member 'absent2 lst)] (fail "cond-let chose wrong branch")]
               [else (set! seen (add1 seen))
                     'seen-05])
              'seen-05)
(check-equal? seen 2)

;; Without else branch
(check-equal? (cond-let
               [[x (member 'a lst)] (set! seen (add1 seen))
                                    (check-equal? x '(a b c))
                                    'seen-06]
               [[x (member 'b lst)] (fail "cond-let chose wrong branch")])
              'seen-06)
(check-equal? seen 3)

(check-equal? (cond-let
               [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
               [[x (member 'b lst)] (begin (check-equal? x '(b c))
                                           'seen-07)])
              'seen-07)

(check-equal? (cond-let
               [[x (member 'absent lst)] (fail "cond-let chose wrong branch")]
               [[x (member 'absent2 lst)] (fail "cond-let chose wrong branch")])
              (void))

;; No branch
(check-equal? (cond-let)
              (void))

;; Single branch
(check-equal? (cond-let
               [[x (member 'a lst)] (begin (check-equal? x '(a b c))
                                           'seen-09)])
              'seen-09)

(check-equal? (cond-let
                [[x (member 'absent lst)] (fail "cond-let chose wrong branch")])
              (void))