#lang racket

(require rackunit
         "../src/borrower.rkt")

(define br1 (make-borrower "borrower1" 1))

(check-equal? (get-name br1) "borrower1")
