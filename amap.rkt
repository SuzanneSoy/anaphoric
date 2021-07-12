#lang racket/base

(provide amap it)
(require anaphoric/it
         racket/stxparam
         (for-syntax racket/base))

(define-syntax-rule (amap body lst)
  (let ([func
         (λ (var)
           (syntax-parameterize ([it (make-rename-transformer #'var)])
             body))])
    (map func lst)))
