#lang racket

(provide it)
(require racket/stxparam)

(define-syntax-parameter it
  (λ (stx)
    (raise-syntax-error
     'it
     "Use of the \"it\" identifier is only allowd within anaphoric macros."
     stx)))