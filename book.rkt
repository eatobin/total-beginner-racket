;; ,cd "/home/eric/lisp_projects/scheme/racket/total-racket"
;; ,enter "book.rkt"
;; [eric@linux-x2vq total-racket](master)$ raco test "book.rkt"

#lang racket

(require "borrower.rkt")

(provide make-book
         get-title)

(define (make-book title author [m-borrower #f])
  (hasheq 'title title 'author author 'm-borrower m-borrower))

(define (get-title book)
  (hash-ref book 'title))

(define (get-author book)
  (hash-ref book 'author))

(define (get-borrower book)
  (hash-ref book 'm-borrower))

(define (set-title book title)
  (hash-set book 'title title))

(define (set-author book author)
  (hash-set book 'author author))

(define (set-borrower book borrower)
  (hash-set book 'm-borrower borrower))

(define (available-string book)
  (let ([borrower (get-borrower book)])
    (if (false? borrower)
        "Available"
        (string-append
         "Checked out to "
         (get-name borrower)))))

(define (book-to-string book)
  (string-append
   (get-title book)
   " by "
   (get-author book)
   "; "
   (available-string book)))

;; Tests
(module* test #f
  (require rackunit
           rackunit/text-ui)

  (define br2 (make-borrower "Borrower2" 2))
  (define bk1 (make-book "Title1" "Author1"))
  (define bk2 (make-book "Title2" "Author2" br2))

  (define file-tests
    (test-suite
     "Tests for borrower.rkt"

     (check-equal? (get-title bk1) "Title1")
     (check-equal? (get-author bk1) "Author1")
     (check-equal? (get-borrower bk1) #f)
     (check-equal? (get-borrower bk2) br2)
     (check-equal? (set-title bk1 "Norman") (make-book "Norman" "Author1"))
     (check-equal? (set-author bk1 "Wow") (make-book "Title1" "Wow"))
     (check-equal? (set-borrower bk1 (make-borrower "Borrower99" 99)) (make-book "Title1" "Author1" (make-borrower "Borrower99" 99)))
     (check-equal? (book-to-string bk1) "Title1 by Author1; Available")))

  (run-tests file-tests))
