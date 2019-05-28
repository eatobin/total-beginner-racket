; ,cd "/home/eric/lisp_projects/scheme/racket/total-racket"
; ,enter "borrower.rkt"
; [eric@linux-x2vq total-racket](master)$ raco test "borrower.rkt"

#lang racket

(provide make-borrower)

(define (max-books? max-books)
  (and (integer? max-books) (>= max-books 0) (<= max-books 10)))

(struct Borrower (name max-books) #:transparent)
 
(define/contract (make-borrower name max-books)
  (-> string? max-books? Borrower?)
  (Borrower name max-books))

(define/contract (get-name borrower)
  (-> Borrower? string?)
  (Borrower-name borrower))

(define/contract (set-name borrower name)
  (-> Borrower? string? Borrower?)
  (struct-copy Borrower borrower [name name]))

(define/contract get-max-books
  (-> Borrower? integer?)
  (lambda (borrower)
    (Borrower-max-books borrower)))

; (define set-max-books
;   (lambda (br mb)
;     (struct-copy borrower br [max-books mb])))

; (define (borrower-to-string br)
;   (string-append "do this" " and this " (number->string (+ 7 7)) " " br))

; Tests
(module* test #f
  (require rackunit
           rackunit/text-ui)

  (define br1 (make-borrower "borrower1" 1))

  (define file-tests
    (test-suite
      "Tests for borrower.rkt"

      (test-case
        "Borrower has the correct name"
          (check-equal? (get-name br1) "borrower1"))
      (check-equal? (set-name br1 "joey") (Borrower "joey" 1))
      (check-equal? (get-max-books br1) 1)
      ; (check-equal? (set-max-books br1 11) (borrower "borrower1" 11))
      ; (check-equal? (borrower-to-string "end") "do this and this 14 end")
))

  (run-tests file-tests))
