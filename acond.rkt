#lang racket

(provide acond it)
(require anaphoric/it
         racket/stxparam)

(define-syntax (acond stx)
  (syntax-case stx (else)
    [(_ [else . else-body])
     #'(begin . else-body)]
    [(_)
     #'(void)]
    [(_ [condition . body] . rest)
     #'(let ([tmp condition])
         (if tmp
             (syntax-parameterize ([it (make-rename-transformer #'tmp)])
               . body)
             (acond . rest)))]))