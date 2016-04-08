#lang racket

(provide aif it)
(require anaphoric/it
         racket/stxparam)

(define-syntax-rule (aif condition true-branch false-branch)
  (let ([tmp condition])
    (if tmp
        (syntax-parameterize ([it (make-rename-transformer #'tmp)])
          true-branch)
        false-branch)))