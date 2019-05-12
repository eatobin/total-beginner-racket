#lang racket

(require "../src/borrower.rkt"
         rackunit)

(define br1 (make-borrower "borrower1" 1))

(check-equal? (get-name br1) "borrower1")
