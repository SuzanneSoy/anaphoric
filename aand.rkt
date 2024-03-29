#lang racket/base

(provide aand it)
(require anaphoric/it
         anaphoric/aif
         (for-syntax racket/base
                     syntax/parse))

(define-syntax aand
  (syntax-parser
    [(_) #'#true]
    [(_ body:expr) #'body]
    [(_ condition:expr rest ...+)
     #'(aif condition (aand rest ...) #false)]))
