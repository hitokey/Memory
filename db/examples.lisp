(ql:quickload :cl-dbi)
(ql:quickload :cl-json)
#|
(defvar *connection*
  (dbi:connect :mysql
	       :database-name "teste"
	       :host "localhost"
	       :port 5432
	       :username "teste"
	       :password "teste"
	       ))
|#

(defparameter *connection*
  (dbi:connect :sqlite3
	       :database-name "system.db"))



(defun input-register(username nome sobrenome email senha)
  (dbi:do-sql *connection*
    "INSERT INTO tb_user (username,nome,sobrenome,email,senha) VALUES (?,?,?,?,?)"
    (list username nome sobrenome email senha)))

(defun desconnect()
  (dbi:disconnect *connection*))


(defun conectar()
  (setq *connection* (dbi:connect :sqlite3 :database-name "system.db")))

(defun select-all-register()
  (let* ((query (dbi:prepare *connection* "SELECT * FROM tb_user"))
	 (query (dbi:execute query)))
    (loop for row = (dbi:fetch query)
       while row
	 do (format t "~A~%" row))))

(defun select-users()
  (let* ((query (dbi:prepare *connection* "SELECT username FROM tb_user"))
	 (query (dbi:execute query)))
    (loop for i = (dbi:fetch query)
       while i
	 collect (cadr i))))


(defun is-user(user)
  (let* ((query (dbi:prepare *connection*
			     "SELECT username,senha FROM tb_user WHERE username=?") )
	 (query (dbi:execute query (list user))) )
    (loop for row = (dbi:fetch query)
       while row
	 return (cons (cadr row) (cadddr row)) )))


(defun build-done(xs &optional (r nil))
  (if (null xs)
      (reverse r)
      (build-done (cddr xs) (cons (cons (car xs) (cadr xs)) r)) ))

(defun done-user(user)
  (dbi:with-connection (conn :sqlite3 :database-name "system.db")
    (let* ((query (dbi:prepare conn "SELECT id,username,nome,sobrenome FROM tb_user WHERE username=?"))
	   (query (dbi:execute query (list user))))
      (loop for row = (dbi:fetch query)
	   return row))))

(defun ok-request(xs)
  (json:encode-json xs))


(defun existe-db(user)
  (if (is-user user)
      t
      nil))
