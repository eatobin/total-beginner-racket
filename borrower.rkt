;; ,cd "/home/eric/lisp_projects/scheme/total-racket"
;; ,enter "borrower.rkt"
;; [eric@linux-x2vq total-racket](master)$ raco test "borrower.rkt"

#lang racket

;; (provide make-borrower
;;          get-name
;;          set-name
;;          get-max-books
;;          set-max-books
;;          borrower-to-string)

(struct borrower (name max-books) #:transparent)

(define (set-name br n)
  (struct-copy borrower br
               [name n]))

;; (define (make-borrower name max-books)
;;   (hasheq 'name name 'max-books max-books))

;; (define (get-name borrower)
;;   (hash-ref borrower 'name))

;; (define (set-name borrower name)
;;   (hash-set borrower 'name name))

;; (define (get-max-books borrower)
;;   (hash-ref borrower 'max-books))

;; (define (set-max-books borrower max-books)
;;   (hash-set borrower 'max-books max-books))

;; (define (borrower-to-string borrower)
;;   (string-append (get-name borrower) " (" (number->string (get-max-books borrower)) " books)"))

;; Tests
(module* test #f
  (require rackunit
           rackunit/text-ui)

  (define br1 (borrower "Borrower1" 1))

  (define file-tests
    (test-suite
     "Tests for borrower.rkt"

     (test-case
      "Borrower has the correct name"
      (check-equal? (borrower-name br1) "Borrower1")
      (check-equal? (set-name br1 "Joey") (borrower "Joey" 1))
      (check-equal? (borrower-max-books br1) 1))))
     ; (check-equal? (set-max-books br1 10) (make-borrower "Borrower1" 10))
     ; (check-equal? (borrower-to-string br1) "Borrower1 (1 books)")))

  (run-tests file-tests))
