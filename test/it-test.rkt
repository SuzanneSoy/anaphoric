#lang racket

(require (for-syntax racket))
(define-syntax (when-≥-6.3 stx)
  (syntax-case stx ()
    [(_ . body)
     (if (let ([v (map string->number (string-split (version) "."))])
           (and (>= (first v) 6) (>= (second v) 3)))
         (syntax/loc stx (begin . body))
         (syntax/loc stx (begin)))]))

(when-≥-6.3
 (require anaphoric/it
          rackunit
          syntax/macro-testing)

 (check-exn #rx"Use of the \"it\" identifier is only allowed within anaphoric macros\\."
            (lambda () (convert-compile-time-error it))))