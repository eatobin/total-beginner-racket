;; C-c, C-a to enter file!!!
;; ,cd "~/lisp_projects/scheme/racket/total-racket"
;; ,enter "book.rkt"
;; [eric@linux-x2vq total-racket](master)$ raco test "book.rkt"

(module book racket
  (require struct-update
           "borrower.rkt")

  (provide (struct-updaters-out book))

  (struct book (title author maybe-borrower) #:transparent)
  (define-struct-updaters book)

  (define (set-title bk ttl)
    (book-title-set bk ttl))

  (define (set-author bk aut)
    (book-author-set bk aut))

  (define (set-borrower bk mbr)
    (book-maybe-borrower-set bk mbr))

                                        ; (define (available-string book)
                                        ;   (let ([borrower (get-borrower book)])
                                        ;     (if (eq? borrower 'null)
                                        ;         "Available"
                                        ;         (string-append
                                        ;          "Checked out to "
                                        ;          (get-name borrower)))))

                                        ; (define (book-to-string book)
                                        ;   (string-append
                                        ;    (get-title book)
                                        ;    " by "
                                        ;    (get-author book)
                                        ;    "; "
                                        ;    (available-string book)))

  ;; Tests
  (module* test #f
    (require rackunit
             rackunit/text-ui)

    (define br2 (borrower "Borrower2" 2))
    (define bk1 (book "Title2" "Author2" 'null))
    (define bk2 (book "Title2" "Author2" br2))

    (define file-tests
      (test-suite
       "Tests for book.rkt"

       (test-case
        "Book has the correct title"
        (check-equal? (book-title bk1) "Title2"))
       (test-case
        "Book has the correct author"
        (check-equal? (book-author bk1) "Author2"))
       (test-case
        "Book has the correct null borrower"
        (check-equal? (book-maybe-borrower bk1) 'null))
       (test-case
        "Book has the correct borrower"
        (define new-bk (set-borrower bk1 br2))
        (check-equal? bk2 new-bk))))
                                        ;      (check-equal? (get-borrower bk2) br2)
                                        ;      (check-equal? (set-title bk1 "Norman") (make-book "Norman" "Author1"))
                                        ;      (check-equal? (set-author bk1 "Wow") (make-book "Title1" "Wow"))
                                        ;      (check-equal? (set-borrower bk1 (make-borrower "Borrower99" 99)) (make-book "Title1" "Author1" (make-borrower "Borrower99" 99)))
                                        ;      (check-equal? (book-to-string bk1) "Title1 by Author1; Available")
                                        ;      (check-equal? (book-to-string bk2) "Title2 by Author2; Checked out to Borrower2")))

    (run-tests file-tests)))
