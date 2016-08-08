#lang racket

(provide if-let)

(define-syntax-rule (if-let [variable condition] true-branch false-branch)
  (let ([tmp condition])
    (if tmp
        (let ([variable tmp])
          true-branch)
        false-branch)))