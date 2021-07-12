#lang racket/base

(provide afilter it)
(require anaphoric/it
         racket/stxparam
         (for-syntax racket/base))

(define-syntax-rule (afilter body lst)
  (let ([func
         (λ (var)
           (syntax-parameterize ([it (make-rename-transformer #'var)])
             body))])
    (filter func lst)))
