; ,cd "/home/eric/lisp_projects/scheme/racket/total-racket"
; ,enter "borrower.rkt"
; [eric@linux-x2vq total-racket](master)$ raco test "borrower.rkt"

#lang racket

(provide (struct-out borrower)
         (all-defined-out))

(struct borrower (name max-books) #:transparent)

(define (make-borrower n mb)
  (borrower n mb))

(define (get-name br)
  (borrower-name br))

(define (set-name br n)
  (struct-copy borrower br [name n]))

(define get-max-books
  (lambda (br)
    (borrower-max-books br)))
  
(define set-max-books
  (lambda (br mb)
    (struct-copy borrower br [max-books mb])))
  
(define (borrower-to-string br)
  (string-append "do this" " and this " (+ 7 7) br)

(module* test #f
  (require rackunit
           rackunit/text-ui)
  
  (define br1 (make-borrower "borrower1" 1))
        
  (define file-tests
    (test-suite
      "Tests for borrower.rkt"
 
      (check-equal? (get-name br1) "borrower1")
      (check-equal? (set-name br1 "joey") (borrower "joey" 1))
      (check-equal? (get-max-books br1) 1)
      (check-equal? (set-max-books br1 11) (borrower "borrower1" 11))
  
      (test-case
        "List has length 4 and all elements even"
          (let ([lst (list 2 4 6 8)])
            (check = (length lst) 4)
            (for-each
              (lambda (elt)
                (check-pred even? elt))
            lst)))))
  
  (run-tests file-tests))
