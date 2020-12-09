#!/usr/local/bin/sbcl --script


(defun wrt(data)
  (with-open-file
      (W "data.txt" :direction :output
	 :if-exists :supersede) ))

(format t "Context-type: text/html~%~%")

(format t
	"<html><body><h1>~a</h1></body></html>"
	(let (env (sb-unix::posix-getenv "CONTENT_LENGTH"))
	  (wrt env)
	  env))
	   
(hunchentoot:define-easy-handler (say-yo :uri "/yo" :default-request-type :post) (name)
  (setf (hunchentoot:content-type*) "text/plain")
  (wrt name)
  (format nil "Hey~@[ ~A~]!" name))
