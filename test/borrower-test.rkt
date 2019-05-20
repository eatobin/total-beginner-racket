(module borrower-test racket
  (require rackunit
         "../src/borrower.rkt")
  
  (define br1 (make-borrower "borrower1" 1))
  
  (check-equal? (get-name br1) "borrower1")
  
  (check-equal? (set-name br1 "joey") (borrower "joey" 1)))
