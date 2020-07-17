#lang racket
(require racket/cmdline)

(require "missions-csv-parser.rkt")

(define csv-input
  (command-line
   #:usage-help
   "I am a very young parser for mission-csv files into LUA tables."
   "Tell me about a file."
   #:args (csv-input)
   csv-input ; csv file
   ))

;; MAIN FUNCTION
(display (csv-path-produce-lua-tables csv-input))
