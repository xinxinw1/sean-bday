(defpackage :sean-main
  (:use :common-lisp :sean :unix-options)
  (:export :main))

(in-package :sean-main)

;; Interface

(defun encode-message (message)
  (format t "~a~%" (encode message)))

(defun decode-message (message)
  (format t "~a~%" (decode message)))
  
(defun encode-full-message (message)
  (format t "~a~%" (encode-full message)))

(defun decode-full-message (message)
  (format t "~a~%" (decode-full message)))

(defun main ()
  (handler-case 
      (with-cli-options (sb-ext:*posix-argv*)
          (&parameters encode-full decode-full encode decode )
        (cond (encode-full (encode-full-message encode-full))
              (decode-full (decode-full-message decode-full))
              (encode (encode-message encode))
              (decode (decode-message decode))))
    (condition (e) (format t "Error: ~a~%" e))))
