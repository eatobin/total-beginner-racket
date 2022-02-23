;; ,cd "~/lisp_projects/scheme/total-racket"
;; ,enter "borrower.rkt"
;; [eric@linux-x2vq total-racket](master)$ raco test "borrower.rkt"

#lang racket

(module+ test)

(require fmt
         rackunit
         struct-update)

(provide (struct+updaters-out borrower)
         borrower-to-string)

(struct borrower (name max-books) #:transparent)
(define-struct-updaters borrower)

(define (borrower-to-string br)
  (string-append (borrower-name br) " (" (number->string (borrower-max-books br)) " books)"))

(module+ test
  (define br1 (borrower "Borrower1" 1))
  (define br-str "Borrower1 (1 books)")
  (define bad-name (borrower "Jack" 1))
  (define bad-mb (borrower "Borrower1" 11))
  (check-equal? (borrower-to-string br1) br-str)
  (check-equal? (borrower-to-string (borrower-name-set bad-name "Borrower1")) br-str)
  (check-equal? (borrower-to-string (borrower-max-books-set bad-mb 1)) br-str))
