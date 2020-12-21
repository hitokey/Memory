#!/usr/local/bin/sbcl --script

(defmacro with-http-authentication (&rest body)
  `(multiple-value-bind (username password) (hunchentoot:authorization)
     (cond ((and (string= username *username*) (string= password *password*))
            ,@body)
           (t (hunchentoot:require-authorization "user")))))


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
	   
(hunchentoot:define-easy-handler (say-yo-post :uri "/yo-post" :default-request-type :post) (name)
  (setf (hunchentoot:content-type*) "text/plain")
  ;;(wrt name)
  (format nil "Hey~@[ ~A~]!" name))

(hunchentoot:define-easy-handler (say-yo-get :uri "/yo-get" :default-request-type :get) (name)
  (setf (hunchentoot:content-type*) "text/plain")
  ;;(wrt name)
  (format nil "Hey~@[ ~A~]!" name))

(hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
  (setf (hunchentoot:content-type*) "text/plain")
  ;;(wrt name)
  (format nil "Hey~@[ ~A~]!" name))

(hunchentoot:define-easy-handler (some-handler :uri "/some") ()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((request-type (hunchentoot:request-method hunchentoot:*request*)))
    (cond ((eq request-type :get) ... );; handle get request
          ((eq request-type :post)
           (let* ((data-string (hunchentoot:raw-post-data :force-text t))
                  (json-obj (jsown:parse data-string)))


(hunchentoot:define-easy-handler (data :uri "/json") ()
  (setf (hunchentoot:content-type*) "text/html")
  (let ((data (hunchentoot:raw-post-data :force-text t)))
    (format nil "~a"  data) ))


(defvar *https-handler*
  (make-instance 'hunchentoot:easy-ssl-acceptor
                 :name 'ssl
                 :ssl-privatekey-file #P"/path/to/privkey.pem"
                 :ssl-certificate-file #P"/path/to/cert.pem"
                 :port 443))

(hunchentoot:start *https-handler*)


(defvar *http-handler*
  (make-instance 'hunchentoot:easy-acceptor
                 :name 'http
                 :port 80))

(hunchentoot:define-easy-handler (redir-to-ssl :uri (lambda (uri) t) :acceptor-names '(http)) ()
  (hunchentoot:redirect "/" :protocol :https)) ; where magic happens


(asdf:oos 'asdf:load-op :hunchentoot)

(defpackage :testserv
  (:use :cl :hunchentoot)
  (:export :start-server))

(in-package :testserv)

;; Add a simple prefix dispatcher to the *dispatch-table*
(setq *dispatch-table*
      `(,(create-prefix-dispatcher "/hello-world" 'hello-page)))

;; Handler functions either return generated Web pages as strings,
;; or write to the output stream returned by write-headers
(defun hello-page ()
  "<html><body>Hello World!</body></html>")

(defun start-server (&key (port 4242))
  (start (make-instance 'easy-acceptor :port port)))

(setq *dispatch-table*
      `(,(create-prefix-dispatcher "/img" 'img-page)))

(defun img-page ()
  (setf (content-type*) "image/png")
  (let ((out (send-headers))   ; send-headers returns the output flexi-stream
        (bar-height (or (and (parameter "height") (parse-integer (parameter "height")))
                        150)))
    (with-canvas (:width 10 :height bar-height)
      (rectangle 0 0 10 bar-height)
      (set-gradient-fill 0 0
			 0 1 1 1
			 0 bar-height
			 1 0 0 1)
      (fill-and-stroke)
      (save-png-stream out)))) ; write the image data to the output stream obtained from send-headers

(setf (header-out "Access-Control-Allow-Origin") "*")
  (setf (header-out "Access-Control-Allow-Methods") "POST,GET,OPTIONS,DELETE,PUT")
  (setf (header-out "Access-Control-Max-Age") 1000)
  (setf (header-out "Access-Control-Allow-Headers") "x-requested-with, Content-Encoding, Content-Type, origin, authorization, accept, client-security-token")
  (setf (header-out "Content-Type") "text/json")

   (hunchentoot:define-easy-handler (one-api :uri *one-endpoint*) () 
    (when (boundp '*acceptor*)
      (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
      (setf (hunchentoot:header-out "Accept") "*/*")
      (setf (hunchentoot:header-out "Access-Control-Allow-Headers") "Content-Type, Accept, Origin") 
      (setf (hunchentoot:header-out "Access-Control-Allow-Methods") "POST, GET, OPTIONS, PUT, DELETE") 
      (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*") 
      (setf (hunchentoot:content-type*) "text/html"))
    (let* ((raw-data (hunchentoot:raw-post-data :force-text t)))
      (funcall callback raw-data)))
   
	   (hunchentoot:define-easy-handler (menu-json :uri "/menu") ()
	     (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Access-Control-Allow-Methods") "GET")
  (setf (hunchentoot:header-out "Access-Control-Max-Age") 1000)
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (setf (hunchentoot:header-out "Content-Type") "text/json")
  (format nil "~A" (json:encode-json-to-string *menu-default*)))



#|
(defparameter *menu-default*
  '(((:ID . 1) (:NAMECLASS . "mr-auto")
     (:MENU (:THEMA . "dark")
      (:HOME (:LINK . "/") (:NOME . "Memory")
	     (:ICO (:IMAGE . "logo2.png") (:WIDTH . 30) (:LENGHT . 30)
		   (:CLASS-NAME . "d-inline-bock align-top")))
      (:LIST-NAME ((:ID . 1) (:NOME . "Inicio") (:LINK . "/"))
		  ((:ID . 3) (:NOME . "FlashCard") (:LINK . "/flash"))
		  ((:ID . 4) (:NOME . "Login") (:LINK . "/login")))))))

* (json:encode-json '((:usename . "pedro") (:password . "123")))
{"usename":"pedro","password":"123"}
* (json:encode-json '(((:usename . "pedro") (:password . "123"))))
[{"usename":"pedro","password":"123"}]
* (json:encode-json '((:id . 1) (:username . "test") (:fristName . "Test") (:lastName . "User")))
{"id":1,"username":"test","fristname":"Test","lastname":"User"}
* (json:encode-json '((id . 1) (username . "test") (fristName . "Test") (lastName . "User")))
{"id":1,"username":"test","fristname":"Test","lastname":"User"}
* (json:encode-json '(("id" . 1) ("username" . "test") ("fristName" . "Test") ("lastName" . "User")))
{"id":1,"username":"test","fristName":"Test","lastName":"User"}
* (find "pedro" (list "pedro" "teste"))
NIL
* (member "pedro" (list "pedro" "teste"))
NIL
* (member "pedro" (list "pedro" "teste"))
NIL
* (member "pedro" '("pedro" "teste"))
NIL
* (member "as" '("pedro" "teste"))
NIL
* (member "pedro" (list "pedro" "teste") :test #'equal)
("pedro" "teste")
* (member "a" (list "pedro" "teste") :test #'equal)
NIL
* (find "a" (list "pedro" "teste") :test #'equal)
NIL
* (find "pedro" (list "pedro" "teste") :test #'equal)
"pedro"
*

#|
