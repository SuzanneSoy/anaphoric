#lang scribble/manual
@require[@for-label[anaphoric
                    racket/base]]

@title{anaphoric}
@author{georges}

@defmodule[anaphoric]

This package provides anaphoric versions of @racket[if], 
@racket[when] and @racket[cond]. These bind the syntax
parameter @racket[if] to the value produced by the
condition expression. 

@racketblock[(aif (member 'a lst)
               (displayln it)
               (displayln "not found"))]

@racketblock[(awhen (member 'a lst)
               (displayln it))]

@racketblock[(acond
               [(member 'a lst) (displayln it)]
               [(member 'b lst) (displayln it)]
               [else (displayln "not found")])]

In the @racket[else] clause of @racket[acond] and in the
else branch of @racket[aif], the @racket[it] syntax
parameter keeps its value. This meeans it keeps the value
bound by the surrounding conditionnal, if any. Otherwise it acts just
like when it is used at the top-level, and raises a syntax error.

@racketblock[(aif 'first
               (aif (eq? 'second 'no)
                 'not-executed
                 (displayln it))
               'not-executed)]

In the example above, @racket[(displayln it)] prints 
@racket['first]. In the example below, 
@racket[(displayln it)] will raises a syntax error, as it
appears in a sequence of else branches:

@racketblock[(aif (eq? 'first 'no)
               'not-executed
               (aif (eq? 'second 'no)
                 'not-executed
                 (displayln it)))]