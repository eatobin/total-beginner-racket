#lang racket

(provide make-borrower)
(provide get-name)
(provide set-name)

(struct borrower (name max-books) #:transparent)

(define (make-borrower n mb)
  (borrower n mb))

(define (get-name br)
  (borrower-name br))

(define (set-name br n)
  (struct-copy borrower br [name n]))
