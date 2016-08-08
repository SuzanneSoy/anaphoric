#lang racket

(provide when-let)

(define-syntax-rule (when-let [variable condition] . body)
  (let ([variable condition])
    (when variable
      . body)))