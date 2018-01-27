#lang racket/base

(provide and-let)

(require syntax/parse/define
         anaphoric/if-let
         (for-syntax racket/base))

(define-syntax and-let
  (syntax-parser
    [(_) #'#true]
    [(_ body:expr) #'body]
    [(_ [variable:id condition:expr] rest ...+)
     #'(if-let [variable condition] (and-let rest ...) #false)]))

