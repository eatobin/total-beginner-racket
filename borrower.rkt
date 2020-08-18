;; ,cd "~/lisp_projects/scheme/total-racket"
;; ,enter "borrower.rkt"
;; [eric@linux-x2vq total-racket](master)$ raco test "borrower.rkt"

(module borrower racket
  (provide (struct-out borrower)
           set-name
           set-max-books
           borrower-to-string)

  (struct borrower (name max-books) #:transparent)

  (define (set-name br n)
    (struct-copy borrower br
                 [name n]))

  (define (set-max-books br mb)
    (struct-copy borrower br
                 [max-books mb]))

  (define (borrower-to-string br)
    (string-append (borrower-name br) " (" (number->string (borrower-max-books br)) " books)"))

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
        (check-equal? (borrower-max-books br1) 1)
        (check-equal? (set-max-books br1 10) (borrower "Borrower1" 10))
        (check-equal? (borrower-to-string br1) "Borrower1 (1 books)"))))

    (run-tests file-tests)))
