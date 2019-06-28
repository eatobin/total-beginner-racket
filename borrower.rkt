; ,cd "/home/eric/lisp_projects/scheme/racket/total-racket"
; ,enter "borrower.rkt"
; [eric@linux-x2vq total-racket](master)$ raco test "borrower.rkt"

#lang racket

(provide make-borrower
         get-name
         set-name
         get-max-books)
;;          set-max-books
;;          borrower-to-string)

(define (make-borrower name max-books)
  (hasheq 'name name 'max-books max-books))

(define (get-name borrower)
  (hash-ref borrower 'name))

(define (set-name borrower name)
  (hash-update borrower 'name (lambda (n) name)))

(define (get-max-books borrower)
  (hash-ref borrower 'max-books))



;; (define/contract (get-name borrower)
;;   (-> Borrower? name?)
;;   (Borrower-name borrower))

;; (define/contract (set-name borrower name)
;;   (-> Borrower? name? Borrower?)
;;   (struct-copy Borrower borrower [name name]))

;; (define/contract get-max-books
;;   (-> Borrower? integer?)
;;   (lambda (borrower)
;;     (Borrower-max-books borrower)))

;; (define/contract set-max-books
;;   (-> Borrower? max-books? Borrower?)
;;   (lambda (borrower max-books)
;;     (struct-copy Borrower borrower [max-books max-books])))

;; (define/contract (borrower-to-string borrower)
;;   (-> Borrower? string?)
;;   (string-append (get-name borrower) " (" (number->string (get-max-books borrower)) " books)"))

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
      (check-equal? (set-name br1 "joey") (make-borrower "joey" 1))
      (check-equal? (get-max-books br1) 1)
;;       (check-equal? (set-max-books br1 10) (Borrower "borrower1" 10))
;;       (check-equal? (borrower-to-string br1) "borrower1 (1 books)")
))

  (run-tests file-tests))
