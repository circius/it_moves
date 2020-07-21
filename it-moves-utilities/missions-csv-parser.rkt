#lang racket
(require csv-reading)

(module+ test
  (require rackunit))

(provide csv-path-produce-lua-tables)

;; a missions-csv is a csv-file with the following columns:

;; - Name (str)
;; - Difficulty (num)
;; - Initial State Description (str)
;; - Depends on (???)

;; generated automatically by Airtable.

;; a missions-table is a string representation of a LUA
;; table-of-tables, in the format:

;; {
;;  subtable
;;  subtable
;;  subtable
;;  ...
;;  }

;; where the subtables having the format:

;; {
;;  name : [str],
;;  diff : [num],
;;  initialState: [str]
;; }

;; constants
(define MISSIONS-READER-SPEC '())

(define make-missions-csv-reader (make-csv-reader-maker MISSIONS-READER-SPEC))

;; subtable-expr-formatting-functions

; lop-format-name: [List-of Pair] -> Str
; consumes a list of pairs representing a mission and produces a string
; representing the desired value of the symbol "name" in a subtable representing
; that mission.
(define (lop-format-name lop)
  (str-represent-as-LUAstring
   (string-append (cdr (assoc "name" lop)) " :: " (cdr (assoc "difficulty" lop)))))

; lop-format-difficulty: [List-of Pair] -> Str
; consumes a list of pairs representing a mission and produces a string
; representing the desired value of the symbol "difficulty" in a subtable representing
; that mission.
(define (lop-format-difficulty lop)
  (lop-format-identity-function lop "difficulty"))

; lop-format-state_0: [List-of Pair] -> Str
; consumes a list of pairs representing a mission and produces a string
; representing the desired value of the symbol "state_0" in a subtable representing
; that mission.v
(define (lop-format-state_0 lop)
  (lop-format-identity-as-string lop "state_0"))

; lop-format-identity-function: [List-of Pair], Str -> Str
; consumes a list of pairs representing a mission and a string which is the car of
; one of the pairs. Produces the cdr of the corresponding pair.
(define (lop-format-identity-function lop str)
  (cdr (assoc str lop)))

; lop-format-identity-as-string: [List-of Pair], Str -> Str
; consumes a list of pairs representing a mission and a string which is the car of
; one of the pairs. Produces the cdr of the corresponding pair.
(define (lop-format-identity-as-string lop str)
  (str-represent-as-LUAstring (lop-format-identity-function lop str)))

; str-represent-as-LUAstring: str -> str
; consumes a string and produces its representation as a LUA string. WARNING: very
; naive, just wraps everything is "[[ ]]"...
(define (str-represent-as-LUAstring str)
  (format "[[~a]]" str))


; the fields we want to show in the lua mission-specifications, along with their formatting-functions.
(define REQUIRED-FIELDS-ASSOC `(("name" . ,lop-format-name)
                                ("difficulty" . ,lop-format-difficulty)
                                ("state_0" . ,lop-format-state_0)))

;; auxiliary functions



; csv-path-get-lol: missions-csv-path -> [List-of [List-of Any]]
; consumes the path of a missions-csv and produces a representation of its data
; as a list of lists.
(define (missions-csv-get-lol missions-csv-path)
  (define (discard-bom p)
    (void (regexp-try-match #rx"^\uFEFF" p))) 
  (let ([reader-maker (make-csv-reader-maker MISSIONS-READER-SPEC)]
        [port (open-input-file missions-csv-path)])
    (discard-bom port)
    (csv->list (reader-maker port))))

; missions-lol-get-lua-table: [List of Lists] -> missions-table
; consumes a list of lists and produces a representation of its data
; as a missions-table
(define missions-lol1 '(("name"
                         "difficulty"
                         "state_0"
                         "depends_on"
                         "notes"
                         "attachments")
                        ("Repair Radio" "4" "The radio is mysteriously broken." "" "" "")))
(module+ test
  (check-equal? (missions-lol-format-missions-table missions-lol1)
                "missions={
{
name = [[Repair Radio :: 4]],
difficulty = 4,
state_0 = [[The radio is mysteriously broken.]]
}
}")
  (check-equal? (missions-lol-format-missions-table '()) "missions={

}"))

(define (missions-lol-format-missions-table lol)
  (let ([missions-lolop (missions-lol->missions-assoc lol)])
    (missions-lolop-format-missions missions-lolop)))


;; missions-lol->missions-assoc: [List of List] -> [List of Pair]
;; consumes a list of lists representing a missions-csv and produces a list
;; of pairs representing its rows.
(module+ test
  (define missions-lop1               '((("name" . "Repair Radio")
                                         ("difficulty" . "4")
                                         ("state_0" . "The radio is mysteriously broken.")
                                         ("depends_on" .  "")
                                         ("notes" . "")
                                         ("attachments" . ""))))
  (check-equal? (missions-lol->missions-assoc missions-lol1) missions-lop1)
  (check-equal? (missions-lol->missions-assoc '()) '()))
(define (missions-lol->missions-assoc lol)
  (cond[(empty? lol) '()]
       [else
        (let ([headers (first lol)])
          (for/list ([row (in-list (rest lol))]) (zip headers row)))]))

;; missions-lolop-format-missions: [List-of [List-of Pair]] -> sub-mission-tables
;; consumes a list of lists of pairs and produces a string representing them
(module+ test
  (define mission-tables-1 "missions={
{
name = [[Repair Radio :: 4]],
difficulty = 4,
state_0 = [[The radio is mysteriously broken.]]
}
}")
  (check-equal? (missions-lolop-format-missions missions-lop1) mission-tables-1))
(define (missions-lolop-format-missions lolop)
  (string-join (for/list ([lop (in-list lolop)]) (mission-lop-format-mission lop))
               ",\n"
               #:before-first "missions={\n"
               #:after-last "\n}"))

;; mission-lop-format-mission: [List-of Pair] -> sub-mission table
;; consumes a list of pairs and produces a string representing them
;; as a LUA table
(module+ test
  (check-equal? (mission-lop-format-mission (first missions-lop1))
                "{
name = [[Repair Radio :: 4]],
difficulty = 4,
state_0 = [[The radio is mysteriously broken.]]
}"))
(define (mission-lop-format-mission lop)
  (string-join (for/list ([pair (in-list REQUIRED-FIELDS-ASSOC)])
                 (string-append (car pair) " = " ((cdr pair) lop))
                 )
     ",\n"
     #:before-first "{\n"
     #:after-last "\n}"))

;; field-is-required? str -> bool
;; consumes a string and produces true if the string's one of the cars of the REQUIRED-FIELDS-ASSOC,
;; false otherwise.
(module+ test
  (check-true (field-is-required? "name"))
  (check-true (field-is-required? "difficulty"))
  (check-true (field-is-required? "state_0"))
  (check-false (field-is-required? "annotations"))
  (check-false (field-is-required? 0))
  (check-false (field-is-required? #t))
  (check-false (field-is-required? 'symbol)))
(define (field-is-required? str)
  (for/or ([pair (in-list REQUIRED-FIELDS-ASSOC)]) (equal? str (car pair))))

; format-pair-as-LUA-expr: Pair -> str
; consumes a pair and produces a LUA expression expressing the equality of the
; cons, interpreted as a symbol, and the cdr, interpreted as a value. Note:
; cannot handle exprs in the rhs.
(module+ test
  (check-equal? (format-pair-as-LUA-expr '("name" . "tester")) "name = [[tester]]")
  (check-equal? (format-pair-as-LUA-expr '("difficulty" . "4")) "difficulty = 4")
  (check-equal? (format-pair-as-LUA-expr '("depends_on" . "")) "depends_on = nil"))
(define (format-pair-as-LUA-expr pair)
  (let ([LUA-symbol (car pair)]
        [LUA-value (express-value-as-LUA (cdr pair))])
    (string-join (list LUA-symbol LUA-value)
                 " = ")))

; express-value-as-LUA: Any -> str
; consumes whatever lisp value and produces a string representation of a
; LUA value corresponding to it, or, failing this, nil.
(module+ test
  (check-equal? (express-value-as-LUA "") "nil")
  (check-equal? (express-value-as-LUA "test this") "[[test this]]")
  (check-equal? (express-value-as-LUA "4") "4")
  (check-equal? (express-value-as-LUA '(this will not work)) "nil"))
(define (express-value-as-LUA expr)
  (cond
    [(or (not (string? expr)) (equal? expr "")) "nil"]
    [(or (number? expr) (number? (string->number expr))) expr]
    [(string? expr) (format "[[~a]]" expr)]
    [else "nil"]))


; zip: List, List -> List
; consumes two lists of equals lengths and zips them together, discarding
; the remainder of the longer if one is longer.
(define (zip l1 l2)
  (cond
    [(or (empty? l1) (empty? l2)) '()]
    [else
     (cons (cons (first l1) (first l2)) (zip (rest l1) (rest l2)))]))

; csv-path-produce-lua-tables: String -> String
; consumes the path of a missions-csv and produces a string representing the csv
; as a lua table.
(define (csv-path-produce-lua-tables str)
  (missions-lol-format-missions-table (missions-csv-get-lol str)))

