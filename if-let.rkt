#lang racket/base

(provide if-let)

(require (for-syntax racket/base))

(define-syntax-rule (if-let [variable condition] true-branch false-branch)
  (let ([tmp condition])
    (if tmp
        (let ([variable tmp])
          true-branch)
        false-branch)))