anaphoric
=========

Anaphoric conditionnal forms for `racket`:

```
(aif (member 'a lst)
  (displayln it)
  (displayln "not found"))

(awhen (member 'a lst)
  (displayln it))

(acond
  [(member 'a lst) (displayln it)]
  [(member 'b lst) (displayln it)]
  [else (displayln "not found")]) ;; Can't use "it" in the else clause.
```