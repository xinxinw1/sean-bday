(defpackage :sean
  (:use :common-lisp)
  (:import-from :cl-utilities :split-sequence)
  (:export :char-to-3-digit-ascii
           :encode
           :group-by-3
           :decode
           :puzzle-num-to-num
           :puzzle-to-num
           :num-to-puzzle
           :num-str-to-puzzle
           :encode-full
           :puzzle-to-num-str
           :decode-full))

(in-package :sean)

;; Random number functions

; this is to deal with the random state being saved in the executable
; making the generated "random" numbers being the same every time the executable is run
(defparameter *random-state-init* nil)
(defparameter *fresh-random-state* nil)

; generates a random number in [0, max)
(defun random-num (max)
  (when (not *random-state-init*)
    (setq *fresh-random-state* (make-random-state t))
    (setq *random-state-init* t))
  (random max *fresh-random-state*))

;; Text to ascii

(defun char-to-3-digit-ascii (c)
  (format nil "~3,'0d" (char-code c)))

; encode string to string
(defun encode (str)
  (apply #'concatenate (cons 'string (loop for c across str collect (char-to-3-digit-ascii c)))))

(defun subseq-check-end (str start end)
  (cond ((> end (length str))
           (subseq-check-end str start (length str)))
        ((< start 0) (subseq-check-end str 0 end))
        (t (subseq str start end))))

(defun group-by-3 (str)
  (nreverse (loop for i downfrom (length str) to 1 by 3
    collect (subseq-check-end str (- i 3) i))))

(defun str-to-num (str)
  (let ((n (parse-integer str :junk-allowed t)))
    (if (not n) 0 n)))

(defun decode (str)
  (map 'string #'code-char (map 'list #'str-to-num (group-by-3 str))))

;; Numbers to puzzle numbers

(defun puzzle-num-to-num (n)
  (case n ((1 2 3 5 7) 0)
          ((0 4 6 9) 1)
          ((8) 2)))

(defun puzzle-to-num (s)
  (reduce (lambda (sum next) (+ sum (puzzle-num-to-num (digit-char-p next)))) s :initial-value 0))

(defun num-to-puzzle (n)
  (let ((s (format nil "~6,'0d" (random-num 1000000))))
    (if (eq (puzzle-to-num s) n) s
        (num-to-puzzle n))))

(defun num-str-to-puzzle (s)
  (format nil "~{~A~^ ~}" (map 'list (lambda (a) (num-to-puzzle (digit-char-p a))) s)))

(defun encode-full (s)
  (num-str-to-puzzle (encode s)))
  
(defun puzzle-to-num-str (p)
  (map 'string (lambda (a) (digit-char (puzzle-to-num a))) (split-sequence #\Space p)))

(defun decode-full (p)
  (decode (puzzle-to-num-str p)))
