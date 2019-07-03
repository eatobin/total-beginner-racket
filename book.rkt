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
  (hash-set book 'borrower borrower))

;; (define (borrower-to-string borrower)
;;   (string-append (get-name borrower) " (" (number->string (get-max-books borrower)) " books)"))

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
     (check-equal? (get-borrower bk2) br2)))

  (run-tests file-tests))
