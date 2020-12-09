(require :hunchentoot)
(ql:quickload :cl-who)

(hunchentoot:define-easy-handler (test :uri "/test") () 
 (cl-who:with-html-output-to-string (*standard-output* nil :prologue t :indent t)
    (:html 
     (:body
      (:h1 "Test")
      (:form :action "/test1" :method "post" :id "addform"
       (:input :type "text" :name "name" :class "txt")
       (:input :type "submit" :class "btn" :value "Submit"))))))

(hunchentoot:define-easy-handler (test1 :uri "/test1") (name)
 (cl-who:with-html-output-to-string (*standard-output* nil :prologue t :indent t)  
  (:html 
   (:body  
    (:h1 "My List")
    (:p (str (models ($ "NOM" name)))) ))))
