#lang racket

(provide awhen it)
(require anaphoric/it
         racket/stxparam)

(define-syntax-rule (awhen condition . body)
  (let ([tmp condition])
    (when tmp
      (syntax-parameterize ([it (make-rename-transformer #'tmp)])
        . body))))