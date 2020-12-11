(require :hunchentoot)
(require :hunchentoot-cgi)
(require :chunga) 
(require :cl-base64)
(require :cl-who)
(require :cl-json)


(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor
				  :port 4242
				  :document-root #p"/home/pedro/twm/www/"))


(defparameter *menu-default*
  '(((:ID . 1) (:NAMECLASS . "mr-auto")
     (:MENU (:THEMA . "dark")
      (:HOME (:LINK . "/") (:NOME . "Memory")
	     (:ICO (:IMAGE . "logo2.png") (:WIDTH . 30) (:LENGHT . 30)
		   (:CLASS-NAME . "d-inline-bock align-top")))
      (:LIST-NAME ((:ID . 1) (:NOME . "Inicio") (:LINK . "/"))
		  ((:ID . 3) (:NOME . "FlashCard") (:LINK . "/flash"))
		  ((:ID . 4) (:NOME . "Login") (:LINK . "/login")))))))


(defparameter *slide-default*
  '(((:ID . 1)
     (:ITEM (:CLASS-NAME . "d-block w-100")
      (:NOME . "Slider1") (:WIDTH . "100px")
      (:SRC . "cap.png") (:TITLE . "A memorização é um problema.")
      (:TEXT . "Utiliza-se do Memory e saiba como é possivel aprender varios conteúdos  sem esquecer nada.")))
    ((:ID . 2)
     (:ITEM (:CLASS-NAME . "d-block w-100")
      (:NOME . "Slider2") (:WIDTH . "100px")
      (:SRC . "acdemy-ia.png") (:TITLE . "Aprendizado e Computer IA")
      (:TEXT . "Utiliza-se de Inteligência Artifical para lhe ajudar a aprender;")))) )


(defparameter *info-top-default*
  '(((:ID . 1)
     (:PAG (:TITLE . "Exemplos de FlashCards:")
      (:TEXT
       . "O sistema a partir de um texto irá criar um sistema de cartas, aonde cartas possuirá um time de recordação, assim você utilizar-se do métodos MMBB (método de memorização na base binário), você não precisá se preocupa-se de quando o texto ou palavra teverá ser revisado.")) )) )



(defparameter *info-down-default*
  '(((:ID . 1)
     (:PAG (:TITLE . "Que é MMBB?:")
      (:TEXT
       . "O MMBB é um método que ajusta a indentificar os intervalos de memórização, com base na na curva de esquecemento, aonde à partir do dia que lhe foi apresentado o conteúdo, já no dia seguinte estará esquencido 30% do que foi aprendido, então este método utiliza-se de um sistema número binário que irá definir quando você derá relembra o que foi aprendido, assim você força o aprendizado, chegado ao um resultado aonde o intervalo de reapredizado é tão simple e grande, que à partir de um momento nunca mais será nessário o reaprendizado.")))) )



(defparameter *card-default*
  '(((:ID . 1)
  (:CARTAS (:ID . 1) (:WIDTH . "18rem") (:LENGHT . "18rem") (:LOCATION . "top")
   (:IMG (:WIDTH . "20px") (:LENGTH . "20px") (:SRC . "apple.png"))
   (:TEXT (:PRINCIPAL . "apple") (:INFO . "Yo como una manzana")
	 (:CLASS-NAME . "list-group-flush"))
   (:LANGUAGE ((:ID . 2) (:ORIGEM . "ES") (:WORD . "manzana"))))
     (:LINK (:EDIT . "#editar") (:INFO . "#info")))
    ((:ID . 2)
     (:CARTAS (:ID . 1) (:WIDTH . "18rem") (:LENGHT . "18rem")
      (:LOCATION . top)
      (:IMG (:WIDTH . "20px") (:LENGTH . "20px") (:SRC . "apple.png"))
      (:TEXT (:PRINCIPAL . "apple") (:INFO . "Eu como uma maçã.")
	    (:CLASS-NAME . "list-group-flush"))
      (:LANGUAGE (("ID" . 2) (:ORIGEM . "PT_BR") (:WORD . "maçã"))))
     (:LINK (:EDIT . "#editar") (:INFO . "#info")))
    ((:ID . 3)
     (:CARTAS (:ID . 1) (:WIDTH . "18rem") (:LENGHT . "18rem")
      (:LOCATION . top)
      (:IMG (:WIDTH . "20px") (:LENGTH . "20px") (:SRC . "apple.png"))
      (:TEXT (:PRINCIPAL . "apple") (:INFO ."私はりんごをたべります。")
	    (:CLASS-NAME . "list-group-flush"))
      (:LANGUAGE ((:ID . 3) (:ORIGEM . "JP") (:WORD . "りんご"))))
     (:LINK (:EDIT . "#editar") (:INFO . "#info")))) )

  
(defun error-sys-html(c)
  (format t "Context-type: text/html~%~%")
  (format t "<html><body><h1>ERRO REQUEST: ~a</h1></body></html>" c))

(defun error-sys-json(c)
  (json:encode-json-to-string (list (cons :message c)) ))

(defun nodebug(c h)
  (declare (ignore h))
  (error-sys-json c)
  (abort))




;; normal-debug *debugger-hook* nil
(setf *debugger-hook* #'nodebug)

;; cgi configurate
(setf chunga:*accept-bogus-eols* t)
(pushnew (hunchentoot-cgi:create-cgi-dispatcher-and-handler
	  "/project-teste/cgi/"
	  "/home/pedro/twm/www/project-teste/cgi/"
	  ) hunchentoot:*dispatch-table* :test #'equal)





(defun user-to-pass(user)
  (if (find user (list "pedro" "teste") :test #'equal)
      "123"
      nil))

(defun if-user(user)
  (member user (list "pedro" "teste") :test #'equal))
  
(defun if-pass(user pass)
  (if (equal (user-to-pass user) pass)
      t
      nil))
      
(defun messagem-json(m)
  (json:encode-json-to-string (list (cons :message m))))



(defun response-login(juser jpass)
  (let ((user (cdr juser)) (pass (cdr jpass)))
    (cond ((not (if-user user)) (messagem-json "Error: UsuÃ¡rio ou Senha incorretas"))
	  ((not (if-pass user pass)) (messagem-json "Error: Senha incorreta"))
	  (t (json:encode-json-to-string (list (cons :id (random 10))
					       (cons :user user)
					       (cons :fristName user)
					       (cons :lastName user)) )) )))




(defun login-switch-json(dados)
  (if (null dados)
      (messagem-json "Error: Dados Vieram Vazios")
      (let* ((js (with-input-from-string (s dados) (json:decode-json s)) )
	     (juser (assoc :username js))
	     (jpass (assoc :password js)))
	(cond ((null juser) (messagem-json "Error: Usuário campo Vazio"))
	      ((null jpass) (messagem-json "Error: Senha campo Vazio"))
	      ((and juser jpass) (response-login juser jpass))
	      (t (messagem-json "Error: bad request dados incompletos ou vazios"))) )))
			     


(hunchentoot:define-easy-handler (head :uri "/head") ()
  (setf (hunchentoot:content-type*) "text/html; application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "text/html application/json;")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (format nil "~A" (hunchentoot:headers-in*)))


(hunchentoot:define-easy-handler (menu-json :uri "/system/menu") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	  "Content-Type, authorization")
  (format nil "~A" (json:encode-json-to-string *menu-default*)))


(hunchentoot:define-easy-handler (slider-json :uri "/system/slider") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	  "Content-Type, authorization")
  (format nil "~A" (json:encode-json-to-string *slide-default*)))


(hunchentoot:define-easy-handler (info-top :uri "/system/infotop") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (format nil "~A" (json:encode-json-to-string *info-top-default*)))



(hunchentoot:define-easy-handler (info-down :uri "/system/infodown") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (format nil "~A" (json:encode-json-to-string *info-down-default*)))


(hunchentoot:define-easy-handler (info-card :uri "/system/card") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (format nil "~A" (json:encode-json-to-string *card-default*)))



(hunchentoot:define-easy-handler (auth :uri "/users/authenticate"
				       :default-request-type :post) ()
  (setf (hunchentoot:content-type*) "text/html; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Max-Age") 1000)
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (setf (hunchentoot:header-out "Content-Type") "text/json")

  (let ((data (hunchentoot:raw-post-data :force-text t)))
    (format nil "~a" (login-switch-json data))))

