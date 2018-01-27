#lang racket/base

(provide aand it)
(require anaphoric/it
         anaphoric/aif
         syntax/parse/define
         (for-syntax racket/base))

(define-syntax aand
  (syntax-parser
    [(_) #'#true]
    [(_ body:expr) #'body]
    [(_ [variable:id condition:expr] rest ...+)
     #'(aif condition (and-let rest ...) #false)]))
