; ,cd "/home/eric/lisp_projects/scheme/racket/total-racket"
; ,enter "book.rkt"
; [eric@linux-x2vq total-racket](master)$ raco test "book.rkt"

#lang racket

(require "borrower.rkt")

(provide make-book
         get-title)

(define (make-book title author)
  (hasheq 'title title 'author author 'm-borrower #f))

(define (get-title book)
  (hash-ref book 'title))

;; (define (set-name borrower name)
;;   (hash-update borrower 'name (lambda (_) name)))

;; (define (get-max-books borrower)
;;   (hash-ref borrower 'max-books))

;; (define (set-max-books borrower max-books)
;;   (hash-update borrower 'max-books (lambda (_) max-books)))

;; (define (borrower-to-string borrower)
;;   (string-append (get-name borrower) " (" (number->string (get-max-books borrower)) " books)"))

; Tests
(module* test #f
  (require rackunit
           rackunit/text-ui)

  (define bk1 (make-book "Title1" "Author1"))

  (define file-tests
    (test-suite
      "Tests for borrower.rkt"

      (check-equal? (get-title bk1) "Title1")))
      ;; (check-equal? (set-name br1 "joey") (make-borrower "joey" 1))
      ;; (check-equal? (get-max-books br1) 1)
      ;; (check-equal? (set-max-books br1 10) (make-borrower "borrower1" 10))
      ;; (check-equal? (borrower-to-string br1) "borrower1 (1 books)")))

  (run-tests file-tests))
