(require :hunchentoot)
(require :hunchentoot-cgi)
(require :easy-routes)
(require :chunga)

(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor
				  :port 4242
				  :document-root #p"/home/pedro/twm/www/"))



(setf chunga:*accept-bogus-eols* t)


(pushnew (hunchentoot-cgi:create-cgi-dispatcher-and-handler
	  "/project-teste/"
	  "/home/pedro/twm/www/project-teste/"
	  ) hunchentoot:*dispatch-table* :test #'equal)


