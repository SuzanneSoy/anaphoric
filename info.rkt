#lang info
(define collection "anaphoric")
(define deps '("base"
               "rackunit-lib"))
(define build-deps '("scribble-lib" "racket-doc"))
(define scribblings '(("scribblings/anaphoric.scrbl" ())))
(define compile-omit-paths '("test/"))
(define pkg-desc "Anaphoric versions of `if`, `when` and `cond`. They bind the value of the condition expression to `it`.")
(define version "0.0")
(define pkg-authors '(|Georges Dupéron|))
