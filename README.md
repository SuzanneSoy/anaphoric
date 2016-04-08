[![Build Status,](https://img.shields.io/travis/jsmaniac/anaphoric/master.svg)](https://travis-ci.org/jsmaniac/anaphoric)
[![Coverage Status,](https://img.shields.io/coveralls/jsmaniac/anaphoric/master.svg)](https://coveralls.io/github/jsmaniac/anaphoric)
[![Build Stats,](https://img.shields.io/badge/build-stats-blue.svg)](http://jsmaniac.github.io/travis-stats/#jsmaniac/anaphoric)

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