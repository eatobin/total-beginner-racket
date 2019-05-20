; ,cd "/home/eric/lisp_projects/scheme/racket/total-racket"
; ,enter "test/borrower.rkt"

(module borrower racket
  
  (provide (struct-out borrower))
  (provide (all-defined-out))

  (struct borrower (name max-books) #:transparent)

  (define (make-borrower n mb)
    (borrower n mb))

  (define (get-name br)
    (borrower-name br))

  (define (set-name br n)
    (struct-copy borrower br [name n]))

  (define get-max-books
    (lambda (br)
      (borrower-max-books br)))
  
  (define set-max-books
    (lambda (br mb)
      (struct-copy borrower br [max-books mb])))
  
  (define borrower-to-string
    "do this"))
