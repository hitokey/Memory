(ql:quickload :hunchentoot)
(ql:quickload :hunchentoot-cgi)
(ql:quickload :chunga) 
(ql:quickload :cl-base64)
(ql:quickload :cl-who)
(ql:quickload :cl-json)
(ql:quickload :cl-dbi)

(defvar *localdb* "db/system.db")

(defvar *servidor* (make-instance 'hunchentoot:easy-acceptor
				  :port 4242
				  :document-root #p"/home/pedro/twm/www/"))


(defparameter *menu-default*
  '(((:ID . 1) (:NAMECLASS . "mr-auto")
     (:MENU
      (:THEMA . "dark")
      (:HOME
       (:LINK . "/")
       (:NOME . "Memory")
       (:ICO (:IMAGE . "logo2.png")
	     (:WIDTH . 30)
	     (:LENGHT . 30)
	     (:CLASS-NAME . "d-inline-bock align-top")))
      (:LIST-NAME ((:ID . 1) (:NOME . "Inicio") (:LINK . "/"))
		  ((:ID . 3) (:NOME . "FlashCard") (:LINK . "/flash"))
		  ((:ID . 4) (:NOME . "Login") (:LINK . "/login")))))))


(defparameter *stand-menu*
  '((:id 1 :nome "Inicio" :link "/") (:id 3 :nome "FlashCard" :link "/flash")))


(defun ccons-par(xs &optional (res nil))
  (if (null xs) (reverse res)
      (ccons-par (cddr xs) (push (cons (car xs) (cadr xs)) res)) ))

(defun list-name(xs)
  (let ((xl (loop for i in xs collect (ccons-par i))))
    (push :list-name xl)))


(defun rebuild-menu(xs new)
  (let ((res (reverse xs)))
    (reverse (push new res))))


(defun make-menus(xs &optional (log "logo2.png"))  
  (list (list (cons :ID 1)
	      (cons :NAMECLASS "mr-auto")
	      (list :MENU
		    (cons :THEMA "dark")
		    (list :HOME
			  (cons :LINK "/")
			  (cons :NOME "Memory")
			  (list :ICO
				(cons :IMAGE log)
				(cons :WIDTH 30)
				(cons :LENGHT 30)
				(cons :CLASS-NAME "d-inline-bock align-top")))
		    (list-name xs)))))


(defparameter *slide-default*
  '(((:ID . 1)
     (:ITEM
      (:CLASS-NAME . "d-block w-100")
      (:WIDTH . "100px")
      (:NOME . "Slider1") 
      (:SRC . "cap.png")
      (:TITLE . "A memorização é um problema.")
      (:TEXT . "Utiliza-se do Memory e saiba como é possivel aprender varios conteúdos  sem esquecer nada.")))
    ((:ID . 2)
     (:ITEM
      (:CLASS-NAME . "d-block w-100")
      (:NOME . "Slider2")
      (:WIDTH . "100px")
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

(defparameter *login-default*
  '(((:ID . 1) (:EUSER . "É necessário inserir um Usuário")
     (:EPASS . "É necessário inserir uma Senha") (:SRC . "image.gif")
     (:ALT . "loading..."))))
 
(defparameter *register-default*
  '((:ID . 1) (:EUSER . "É necessário inserir um Usuário")
     (:EPASS . "É necessário inserir uma Senha")
     (:EEMAIL . "É necessário inserir um E-mail")
     (:ENOME . "É necessário inserir um Nome") (:SRC . "image.gif")
    (:ALT . "loading...")))

;; CODING SERVER

(defun types-code(number)
  (cond ((= number 200) hunchentoot:+http-ok+)
	((= number 400) hunchentoot:+http-bad-request+)
	(t hunchentoot:+http-bad-request+)) )


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
;;(setf *debugger-hook* #'nodebug)

;; cgi configurate
(setf chunga:*accept-bogus-eols* t)
(pushnew (hunchentoot-cgi:create-cgi-dispatcher-and-handler
	  "/project-teste/cgi/"
	  "/home/pedro/twm/www/project-teste/cgi/"
	  ) hunchentoot:*dispatch-table* :test #'equal)



;; System database control

(defun messagem-json(m)
  (json:encode-json-to-string (list (cons :message m))))

(defun resp-code(code resp)
  (cons (types-code code) resp))


(defun build-done(xs &optional (r nil))
  (if (null xs)
      (reverse r)
      (build-done (cddr xs) (cons (cons (car xs) (cadr xs)) r)) ))


(defun ok-request(xs)
  (json:encode-json-to-string (build-done xs)))


(defun if-admin(user pass)
  (if (string= user "admin")
      (dbi:with-connection (conn :sqlite3 :database-name *localdb*)
	(let* ((query (dbi:prepare conn "SELECT password FROM tb_user WHERE username=?"))
	       (query (dbi:execute query (list "admin")))
	       (senha (loop for row = (dbi:fetch query) while row return (cadr row)) ))
	  (if (string= pass senha)
	      t
	      nil)))
      nil))
	       
(defun delete-user(cmd pass user)
  (if (if-admin cmd pass)
      (progn
	(dbi:with-connection (conn :sqlite3 :database-name *localdb*)
	  (dbi:do-sql conn "DELETE FROM tb_user WHERE username=?" (list user)))
	(resp-code 200 (messagem-json "DONE: User deletado")))
      (resp-code 400 (messagem-json "ERROR: Apenas admin poderá deletar usuário")) ))

;(defun del-user(user)
;  (progn
;    (dbi:with-connection (conn :sqlite3 :database-name *localdb*)
;      (dbi:do-sql conn "DELETE FROM tb_user WHERE username=?" (list user)))
;    (resp-code 200 (messagem-json "DONE: User deletado"))))


;(defun auto-delete-switch(dados user pass)
;  (if (null dados)
;      (resp-code 400 (messagem-json "Error: Dados Varios"))
;      (let* ((js (with-input-from-string (s dados) (json:decode-json s)));
;	     (juser (cdr (assoc :username js)));
;	     (jpass (cdr (assoc :password js))));
;	(cond ((not (equal pass jpass))
;	       (resp-code 400 (messagem-json "Senha Errada")))
;	      ((not (equal pass juser));
;	       (resp-code 400 (messagem-json "Usuário Errado")))
;	      ((and (existe-db juser) (if-pass juser jpass))
;	       (del-user juser))
;	      (t (resp-code 400 (messagem-json "Usuário e Senha Errados")) )) )))
		    

(defun delete-switch-json(dados)
    (if (null dados)
      (resp-code 400 (messagem-json "Error: NULL DADOS"))
      (let* ((js (with-input-from-string (s dados) (json:decode-json s)))
	     (juser (cdr (assoc :username js))) (jpass (cdr (assoc :cmd-pass js)))
	     (jcmd (cdr (assoc :cmd-user js))))
	(cond ((null juser) (messagem-json "Error: user vazio"))
	      ((null jpass) (messagem-json "Error: Password comand vazio"))
	      ((null jcmd) (messagem-json "Error: User comand vazio"))
	      (t (delete-user jcmd jpass juser)) )) ))

(defun is-user(user)
  (dbi:with-connection (conn :sqlite3 :database-name *localdb*)
    (let* ((query (dbi:prepare conn
	           "SELECT username,password FROM tb_user WHERE username=?"))
	   (query (dbi:execute query (list user))) )
      (loop for row = (dbi:fetch query)
	 while row
	 return (cons (cadr row) (cadddr row)) ))))

(defun existe-db(user)
  (if (is-user user)
      t
      nil))

(defun done-user(user)
  (dbi:with-connection (conn :sqlite3 :database-name *localdb*)
    (let* ((query (dbi:prepare conn "SELECT id,username,nome,sobrenome FROM tb_user WHERE username=?"))
	   (query (dbi:execute query (list user))))
      (loop for row = (dbi:fetch query)
	   return row)) ))


(defun info-user-db(user)
  (dbi:with-connection (conn :sqlite3 :database-name *localdb*)
    (let* ((query (dbi:prepare conn "SELECT id,username,nome,sobrenome,email FROM tb_user WHERE username=?"))
	   (query (dbi:execute query (list user))))
      (loop for row = (dbi:fetch query)
	   return row)) ))


(defun get-nomes(user)
  (dbi:with-connection (conn :sqlite3 :database-name *localdb*)
    (let* ((query (dbi:prepare conn "SELECT nome,sobrenome FROM tb_user WHERE username=?"))
	   (query (dbi:execute query (list user))))
      (loop for row = (dbi:fetch query)
	   return (cons (cadr row) (cadddr row)) ))))


(defun input-register(username pass email nome sobrenome)
  (if (existe-db username)
      (resp-code 400 (messagem-json "Error: Já existe este usuário"))
      (progn
	(dbi:with-connection (conn :sqlite3 :database-name *localdb*)
	  (dbi:do-sql conn
	    "INSERT INTO tb_user (username,nome,sobrenome,email,password) 
                VALUES (?,?,?,?,?)"
	    (list username nome sobrenome email pass)))
	(resp-code 200 (ok-request (done-user username))) )))



(defun user-to-pass(user)
  (dbi:with-connection (conn :sqlite3 :database-name *localdb*)
    (let* ((query (dbi:prepare conn "SELECT password FROM tb_user WHERE username=?"))
	   (query (dbi:execute query (list user))))
      (loop for row = (dbi:fetch query)
	 while row
	 return (cadr row)) )))
      
  
(defun if-pass(user pass)
  (if (equal pass (user-to-pass user))
      t
      nil))
 

(defun response-login(user pass)
  (cond ((not (existe-db user))
	 (resp-code 400 (messagem-json "Error: Usuário ou Senha incorretas")))
	((not (if-pass user pass))
	 (resp-code 400 (messagem-json "Error: Senha incorreta")))
	(t (resp-code 200 (ok-request (done-user user))) )))


(defun infos-user(user pass)
  (cond ((not (existe-db user))
	 (messagem-json "Error: Usuário ou Senha incorretas"))
	((not (if-pass user pass))
	 (messagem-json "Error: Senha incorreta"))
	(t (ok-request (info-user-db user))) ))



(defun register-switch-json(dados)
  (if (null dados)
      (resp-code 400 (messagem-json "Error: Dados Vazíos"))
      (let* ((js (with-input-from-string (s dados) (json:decode-json s)))
	     (juser (cdr (assoc :username js))) (jpass (cdr (assoc :password js)))
	     (jemail (cdr (assoc :email js))) (jnome (cdr (assoc :nome js)))
	     (jsobre (cdr (assoc :sobre js))))
	(cond ((null juser) (resp-code 400 (messagem-json "Erro: Usuário Vazio")))
	      ((null jpass) (resp-code 400 (messagem-json "Erro: Senha Vazio")))
	      ((null jemail) (resp-code 400 (messagem-json "Erro: Email Vazio")))
	      ((or (null jnome) (null jsobre)) (resp-code 400 (messagem-json "Erro: Nome e Sobrenome é necessario")))
	      (t (input-register juser jpass jemail jnome jsobre)) ))))


(defun login-switch-json(dados)
  (if (null dados)
      (resp-code 400 (messagem-json "Error: Dados Vazíos"))
      (let* ((js (with-input-from-string (s dados) (json:decode-json s)) )
	     (juser (cdr (assoc :username js)))
	     (jpass (cdr (assoc :password js))))
	(cond ((null juser)
	       (resp-code 400 (messagem-json "Error: Usuário campo Vazio")))
	      ((null jpass)
	       (resp-code 400 (messagem-json "Error: Senha campo Vazio")))
	      ((and juser jpass) (response-login juser jpass))
	      (t (resp-code 400
		  (messagem-json "Error: incompletos ou vazios")) )) )))


(defun response-menu-user(user pass)
  (if (and (existe-db user) (if-pass user pass))
      (let ((user-sobre (get-nomes user)))
	(json:encode-json-to-string
	 (make-menus (rebuild-menu
		      *stand-menu* (list :id 4
					 :nome (concatenate 'string
						(car user-sobre)
						" "
						(cdr user-sobre))
					 :link "/user"))
		     "logo.png")))
      (json:encode-json-to-string
       (make-menus (rebuild-menu
		    *stand-menu* (list :id 4 :nome "Join" :link "/login"))) )))


(hunchentoot:define-easy-handler (head :uri "/head") ()
  (setf (hunchentoot:content-type*) "text/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "text/html; application/json;")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")	
	"Content-Type, authorization")
  (setf (hunchentoot:return-code*) hunchentoot:+http-bad-request+)
  (format nil "~A" (hunchentoot:headers-in*)))

(hunchentoot:define-easy-handler (authz :uri "/auth") ()
  (setf (hunchentoot:content-type*) "text/json;charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "text/html;application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")	
	"Content-Type, authorization")
  (setf (hunchentoot:return-code*) hunchentoot:+http-bad-request+)
  (multiple-value-bind (username password) (hunchentoot:authorization)
    (format nil "~A-~A" username password)))


#|
(hunchentoot:define-easy-handler (autodelete :uri "/autodelete") ()
  (setf (hunchentoot:content-type*) "text/json;charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "text/html;application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")	
	"Content-Type, authorization")
  (setf (hunchentoot:return-code*) hunchentoot:+http-bad-request+)
  (multiple-value-bind (username password) (hunchentoot:authorization)
    (let* ((data (hunchentoot:raw-post-data :force-text t))
	   (resp (auto-delete-switch data username password)))
      (setf (hunchentoot:return-code*) (car resp))
      (format nil "~a" (cdr resp)) ))
 |#


(hunchentoot:define-easy-handler (infos-json :uri "/system/menu") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (multiple-value-bind (username password) (hunchentoot:authorization)
    (format nil "~A" (response-menu-user username password)) ))
    

(hunchentoot:define-easy-handler (menu-json :uri "/system/infosUser") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (multiple-value-bind (username password) (hunchentoot:authorization)
    (format nil "~A" (infos-user username password)) ))
    



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

(hunchentoot:define-easy-handler (register-card :uri "/system/register") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (format nil "~A" (json:encode-json-to-string *register-default*)))

(hunchentoot:define-easy-handler (login-card :uri "/system/login") ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-Type, authorization")
  (format nil "~A" (json:encode-json-to-string *login-default*)))


(hunchentoot:define-easy-handler (auth :uri "/users/authenticate"
				       :default-request-type :post) ()
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Access-Control-Max-Age") 100)
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers") "Content-Type")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (let* ((data (hunchentoot:raw-post-data :force-text t))
	 (resp (login-switch-json data)))
    (setf (hunchentoot:return-code*) (car resp))
    (format nil "~a" (cdr resp)) ))


(hunchentoot:define-easy-handler (register :uri "/users/register"
					   :default-request-type :post) ()
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Access-Control-Max-Age") 100)
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers") "Content-Type")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (let* ((data (hunchentoot:raw-post-data :force-text t))
	 (resp (register-switch-json data)))
    (setf (hunchentoot:return-code*) (car resp))
    (format nil "~a" (cdr resp)) ))


(hunchentoot:define-easy-handler (delete-cmd :uri "/users/delete"
					     :default-request-type :post) ()
  (setf (hunchentoot:content-type*) "application/json; charset=utf-8")
  (setf (hunchentoot:header-out "Access-Control-Allow-Origin") "*")
  (setf (hunchentoot:header-out "Content-Type") "application/json")
  (setf (hunchentoot:header-out "Access-Control-Max-Age") 1000)
  (setf (hunchentoot:header-out "Access-Control-Allow-Headers")
	"Content-type, authorization")
  (let* ((data (hunchentoot:raw-post-data :force-text t))
	 (resp (delete-switch-json data)))
    (setf (hunchentoot:return-code*) (car resp))
    (format nil "~a" (cdr resp)) ))
