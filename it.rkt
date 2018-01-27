#lang racket/base

(provide it)
(require racket/stxparam
         (for-syntax racket/base))

(define-syntax-parameter it
  (λ (stx)
    (raise-syntax-error
     'it
     "Use of the \"it\" identifier is only allowed within anaphoric macros."
     stx)))