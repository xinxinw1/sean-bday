(defpackage :sean-test
  (:use :common-lisp :lisp-unit :sean))

(in-package :sean-test)

(define-test char-to-3-digit-ascii
  (assert-equal "032" (char-to-3-digit-ascii #\Space))
  (assert-equal "116" (char-to-3-digit-ascii #\t))
  (assert-equal "126" (char-to-3-digit-ascii #\~)))

(define-test encode
  (assert-equal "" (encode ""))
  (assert-equal "032" (encode " "))
  (assert-equal "080114111111102115032097114101032097119101115111109101033033033032076079076122"
    (encode "Proofs are awesome!!! LOLz")))

(define-test group-by-3
  (assert-equal '("1") (group-by-3 "1"))
  (assert-equal '("12") (group-by-3 "12"))
  (assert-equal '("123") (group-by-3 "123"))
  (assert-equal '("1" "234") (group-by-3 "1234"))
  (assert-equal '("12" "345") (group-by-3 "12345"))
  (assert-equal '("123" "456") (group-by-3 "123456"))
  (assert-equal '("1" "234" "567") (group-by-3 "1234567")))

(define-test decode
  (assert-equal "" (decode ""))
  (assert-equal " " (decode "032"))
  (assert-equal " " (decode "32"))
  (assert-equal "Proofs are awesome!!! LOLz"
    (decode "080114111111102115032097114101032097119101115111109101033033033032076079076122"))
  (assert-equal "Proofs are awesome!!! LOLz"
    (decode "80114111111102115032097114101032097119101115111109101033033033032076079076122")))

(define-test puzzle-num-to-num
  (assert-equal 0 (puzzle-num-to-num 1))
  (assert-equal 0 (puzzle-num-to-num 2))
  (assert-equal 0 (puzzle-num-to-num 7))
  (assert-equal 1 (puzzle-num-to-num 0))
  (assert-equal 1 (puzzle-num-to-num 9))
  (assert-equal 2 (puzzle-num-to-num 8)))

(define-test puzzle-to-num
  (assert-equal 6 (puzzle-to-num "8809"))
  (assert-equal 0 (puzzle-to-num "7111"))
  (assert-equal 4 (puzzle-to-num "0000"))
  (assert-equal 2 (puzzle-to-num "2581"))
  (assert-equal 0 (puzzle-to-num ""))
  (assert-equal 3 (puzzle-to-num "153982")))
  
(define-test num-to-puzzle
  (loop for n from 0 to 9 do
    (let ((a (num-to-puzzle n)))
      (print a)
      (assert-equal n (puzzle-to-num a)))))
    
(define-test num-str-to-puzzle
  (print (num-str-to-puzzle "0123456789")))

(define-test encode-full
  (print (encode-full "abcde")))

(define-test puzzle-to-num-str
  (assert-equal "0123456789" (puzzle-to-num-str "225255 319153 391214 136599 342786 810434 844403 408696 488982 848840")))

(define-test decode-full
  (assert-equal "0123456789" (decode-full "557331 293289 018886 573171 783495 880860 323512 044626 117311 571337 738087 711077 337711 505998 941231 315111 063398 279296 175533 600738 612386 223535 955948 987093 273122 603398 882109 537723 365668 492988")))
