; ,cd "/home/eric/lisp_projects/scheme/racket/total-racket"
; ,enter "test/borrower-test.rkt"

(module borrower-test racket
  
  (require rackunit
         "../src/borrower.rkt")
  
  (define br1 (make-borrower "borrower1" 1))
  
  (check-equal? (get-name br1) "borrower1")
  
  (check-equal? (set-name br1 "joey") (borrower "joey" 1))
  
  (check-equal? (get-max-books br1) 1)
  
  (check-equal? (set-max-books br1 11) (borrower "borrower1" 11)))
