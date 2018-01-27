#lang racket/base

(provide when-let)

(require (for-syntax racket/base))

(define-syntax-rule (when-let [variable condition] . body)
  (let ([variable condition])
    (when variable
      . body)))