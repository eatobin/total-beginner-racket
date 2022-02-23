;; C-c, C-a to enter file!!!
;; ,cd "~/lisp_projects/scheme/racket/total-racket"
;; ,enter "book.rkt"
;; [eric@linux-x2vq total-racket](master)$ raco test "book.rkt"

#lang racket

(require fmt
         struct-update
         "borrower.rkt")

(provide (struct+updaters-out book)
         book-to-string)

(struct book (title author maybe-borrower) #:transparent)
(define-struct-updaters book)

(define (available-string book)
  (let ([borrower (book-maybe-borrower book)])
    (if (eq? borrower 'null) "Available" (string-append "Checked out to " (borrower-name borrower)))))

(define (book-to-string book)
  (string-append (book-title book) " by " (book-author book) "; " (available-string book)))

;; Tests
(module* test #f
  (require rackunit
           rackunit/text-ui)

  (define br2 (borrower "Borrower2" 2))
  (define bk1 (book "Title2" "Author2" 'null))
  (define bk2 (book "Title2" "Author2" br2))
  (define bad-title (book "Nope" "Author2" 'null))
  (define bad-author (book "Title2" "Nope" 'null))
  (define bk-str-avail "Title2 by Author2; Available")
  (define bk-str-out "Title2 by Author2; Checked out to Borrower2")

  (define file-tests
    (test-suite
     "Tests for book.rkt"
     (test-case "Book has the correct avail string" (check-equal? (book-to-string bk1) bk-str-avail))
     (test-case "Book has the correct out string" (check-equal? (book-to-string bk2) bk-str-out))
     (test-case "Book sets the correct title"
                (check-equal? (book-to-string (book-title-set bad-title "Title2")) bk-str-avail))
     (test-case "Book sets the correct author"
                (check-equal? (book-to-string (book-author-set bad-author "Author2")) bk-str-avail))
     (test-case "Book sets the correct borrower"
                (check-equal? (book-to-string (book-maybe-borrower-set bk1 br2)) bk-str-out))))

  (run-tests file-tests))
