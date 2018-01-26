#lang racket/base

;; Notice
;; To install (from within the package directory):
;;   $ raco pkg install
;; To install (once uploaded to pkgs.racket-lang.org):
;;   $ raco pkg install <<name>>
;; To uninstall:
;;   $ raco pkg remove <<name>>
;; To view documentation:
;;   $ raco docs <<name>>

(provide (all-from-out anaphoric/it
                       anaphoric/aif
                       anaphoric/awhen
                       anaphoric/acond
                       anaphoric/if-let
                       anaphoric/when-let
                       anaphoric/cond-let
                       anaphoric/and-let))

(require anaphoric/it
         anaphoric/aif
         anaphoric/awhen
         anaphoric/acond
         anaphoric/if-let
         anaphoric/when-let
         anaphoric/cond-let
         anaphoric/and-let)
