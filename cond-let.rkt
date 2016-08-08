#lang racket

(provide cond-let)

(define-syntax (cond-let stx)
  (syntax-case stx (else)
    [(cond-let [[identifierᵢ conditionᵢ] . bodyᵢ] ... [else . else-body])
     #'(cond [conditionᵢ => (λ (identifierᵢ) . bodyᵢ)] ...
             [else . else-body])]
    [(cond-let [[identifierᵢ conditionᵢ] . bodyᵢ] ...)
     #'(cond [conditionᵢ => (λ (identifierᵢ) . bodyᵢ)] ...)]
    
    [(cond-let identifier [conditionᵢ . bodyᵢ] ... [else . else-body])
     #'(cond [conditionᵢ => (λ (identifier) . bodyᵢ)] ...
             [else . else-body])]
    [(cond-let [[identifierᵢ conditionᵢ] . bodyᵢ] ...)
     #'(cond [conditionᵢ => (λ (identifierᵢ) . bodyᵢ)] ...)]))