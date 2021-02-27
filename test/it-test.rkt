#lang racket

(require anaphoric/it
         rackunit
         syntax/macro-testing)

(check-exn #rx"Use of the \"it\" identifier is only allowed within anaphoric macros\\."
           (lambda () (convert-compile-time-error it)))
