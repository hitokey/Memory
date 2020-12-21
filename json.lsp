(ql:quickload :cl-json)

(defun read-file(f)
  (let ((res "")
	(in (open f :if-does-not-exist nil)))
      (when in
	(loop for line = (read-line in nil)
	   while line do (setf res (format nil "~a~a~%" res line)))
	(close in))
      res))

(defun write-file(d f)
  (with-open-file (s f :direction :output
		     :if-exists :supersede)
    (format s "~a" d)))
