(cl:defpackage :net
  (:use :common-lisp)
  (:export :wget
	   :parse
	   :find-node
	   :*body*
	   :*status*
	   :*headers*
	   :*extra-headers*
	   :*URI*
	   :*stream*
	   :*closed*
	   :*reason*
	   :*cookie*))

(cl:in-package :net)

;; http client
(ql:quickload :drakma)
(ql:quickload :st-json)
;; GBK codec facility
(ql:quickload :babel)
;; regexp facility
(ql:quickload :cl-ppcre)
;; string split
(ql:quickload :split-sequence)
;; html-parsing
(ql:quickload :closure-html)

;; return values of drakma:http-request
(defparameter *body* nil)
(defparameter *status* nil)
(defparameter *headers* nil)
(defparameter *URI* nil)
(defparameter *stream* nil)
(defparameter *closed* nil)
(defparameter *reason* nil)
(defparameter *extra-headers* nil)
(defparameter *cookie* nil)

(defun test ()
  "print return values of drakma:http-request"
  (with-output-to-string (*standard-output*)
  ;; (princ *body*)
    (print *status*)
    (print *headers*)
    (print *URI*)
    (print *stream*)
    (print *closed*)
    (print *reason*)))

(defun string-to-keyword (name)
  "string-to-keyword
http://stackoverflow.com/questions/211717/common-lisp-programmatic-keyword
origin: sky-pher"
  (values (intern (string-upcase name) "KEYWORD")))


(defun wget (url &rest args)
  "url is a string
result stored in global variable of package net"
  (multiple-value-bind (body status-code headers URI stream should-be-closed reason)
      (apply #'drakma:http-request url :additional-headers *extra-headers* :external-format-in :utf-8 args)
    (setf *body* body
	  *status* status-code
	  *headers* headers
	  *URI* URI
	  *stream* stream
	  *closed* should-be-closed
	  *reason* reason)
    body))

(defun parse (body-string)
  (chtml:parse body-string (chtml:make-lhtml-builder)))

(defun find-node (tree pred deal)
  "if a tree satisfy pred.
return (deal tree)
else
return collection if (deal subtree) for each satisfiable childtree

example:
 (find-node '((1 (d e))
	      (1 (1 (a b)) (1 v))
	      (h i (1 j))
	      (m n (1 (r s))))
	    #'(lambda (x) (and (listp x)
			  (numberp (car x))))
	    #'second)
===> ((D E) (1 (A B)) J (R S))
"
  (if (funcall pred tree)
      (list (funcall deal tree))
      (if (and (listp tree)
	     (not (null tree)))
	  (let (a)
	    (loop for i in tree do
		 (let ((b (find-node i pred deal)))
		   (if (not (null b))
		       (setf a (append a b)))))
	    a)
	  nil)))
