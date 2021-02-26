#lang scribble/manual
@require[@for-label[anaphoric
                    racket/base]]

@title{Anaphoric conditionals}
@author[@author+email["Suzanne Soy" "racket@suzanne.soy"]]

@defmodule[anaphoric]

@section{Overview}

This package provides anaphoric versions of @racket[if], 
@racket[when] and @racket[cond]. These bind the syntax
parameter @racket[it] to the value produced by the
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
parameter keeps its value. This means it keeps the value
bound by the surrounding conditional, if any. Otherwise it
acts exactly as when it is used at the top-level, and raises
a syntax error.

@racketblock[(aif 'first
               (aif (eq? 'second 'no)
                 'not-executed
                 (displayln it))
               'not-executed)]

In the example above, @racket[(displayln it)] prints 
@racket['first]. In the example below, 
@racket[(displayln it)] raises a syntax error, as it appears
in a sequence of else branches:

@racketblock[(aif (eq? 'first 'no)
               'not-executed
               (aif (eq? 'second 'no)
                 'not-executed
                 (displayln it)))]

This package also provides the hygienic versions 
@racket[if-let], @racket[when-let] and @racket[cond-let],
for which the user needs to specify an identifier instead of
using @racket[it].

@section{The anaphoric conditionals @racket[aif], 
 @racket[awhen] and @racket[acond]}

@defidform[it]{
 Syntax parameter which acts as a rename transformer for
 the result of the condition expression, when bound by 
 @racket[aif], @racket[awhen] or @racket[acond].

 Raises a syntax error when used outside of the 
 @racket[_true-branch] of an @racket[aif] or the body of an
 @racket[awhen] or the body of a non-@racket[else] case in 
 @racket[acond].}

@defform[(aif condition true-branch false-branch)]{
 Variant of @racket[if] which binds @racket[it] to the
 value of @racket[condition] in @racket[true-branch]. 
 @racket[condition] is only evaluated once. In the 
 @racket[false-branch], @racket[it] is left unchanged.}

@defform[(awhen condition body ...+)]{
 Variant of @racket[when] which binds @racket[it] to the
 value of @racket[condition] in @racket[body ...+]. 
 @racket[condition] is only evaluated once.}

@defform*[#:literals (else)
          [(acond [conditionᵢ bodyᵢ ...+] ...)
           (acond [conditionᵢ bodyᵢ ...+] ... [else body ...+])]]{
 Variant of @racket[cond] which binds @racket[it] to the
 corresponding @racket[conditionᵢ] in the non-@racket[else]
 cases. More precisely, in each @racket[bodyᵢ ...+], 
 @racket[it] is bound to the value of the corresponding 
 @racket[conditionᵢ]. Each @racket[conditionᵢ] is evaluated
 at most once (evaluation stops at the first successful 
 @racket[conditionᵢ]).}

@defform*[[(aand)
           (aand conditionᵢ ... body)]]{
 Variant of @racket[and] which binds @racket[it]
 to the value of each @racket[conditionᵢ], in scope within the
 next @racket[conditionᵢ] or @racket[body]. More precisely, the value
 of each @racket[conditionᵢ] can be referred to as @racket[it] in
 the following @racketvarfont{conditionᵢ₊₁}, and the value of the last
 @racket[conditionᵢ] can be referred to as @racket[it] in the
 @racket[body]. If there are no @racket[conditionᵢ], i.e. when
 writing, @racket[(aand body)], then @racket[it] retains its original
 binding (which means that @racket[it] could be unbound, e.g. if no
 other @racketmodname[anaphoric] form wraps this one).

 Each @racket[condition] is evaluated at most once, and
 evaluation stops at the first false condition. The
 @racket[body] is only evaluated when every
 @racket[conditionᵢ] is successful.
}

@section{The hygienic versions @racket[if-let], 
 @racket[when-let] and @racket[cond-let]}

@defform[(if-let [identifier condition] true-branch false-branch)]{
 Variant of @racket[if] which binds @racket[identifier] to
 the value of @racket[condition] in @racket[true-branch]. 
 @racket[condition] is only evaluated once. In the 
 @racket[false-branch], @racket[identifier] is left unchanged.}

@defform[(when-let [identifier condition] body ...+)]{
 Variant of @racket[when] which binds @racket[identifier] to
 the value of @racket[condition] in @racket[body ...+]. 
 @racket[condition] is only evaluated once.}

@defform*[#:literals (else)
          [(cond-let [[identifierᵢ conditionᵢ] bodyᵢ ...+] ...)
           (cond-let [[identifierᵢ conditionᵢ] bodyᵢ ...+] ... [else body ...+])
           (cond-let identifier [conditionᵢ bodyᵢ ...+] ...)
           (cond-let identifier [conditionᵢ bodyᵢ ...+] ... [else body ...+])]]{
 Variant of @racket[cond] which binds each 
 @racket[identifierᵢ] to the corresponding 
 @racket[conditionᵢ] in the non-@racket[else] cases. More
 precisely, in each @racket[bodyᵢ ...+], the corresponding 
 @racket[identifierᵢ] is bound to the value of the
 corresponding @racket[conditionᵢ].

 The last two variants are shorthands for using the same 
 @racket[identifier] in all cases (except the @racket[else]
 case).

 Each @racket[conditionᵢ] is evaluated at most once
 (evaluation stops at the first successful 
 @racket[conditionᵢ]).}

@defform*[[(and-let)
           (and-let [identifier conditionᵢ] ... body)]]{
 Variant of @racket[and] which binds each @racket[identifier]
 to the value of its @racket[conditionᵢ], in scope within every
 @racket[conditionᵢ] afterwards as well as in @racket[body].

 Each @racket[conditionᵢ] is evaluated at most once, and
 evaluation stops at the first false condition. The
 @racket[body] is only evaluated when every
 @racket[conditionᵢ] is successful.
}

