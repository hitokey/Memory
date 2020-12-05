#!/usr/local/bin/sbcl --script


(format t "Content-type: text/html~%~%")

(format t
" <html>
   <body>
    <h1>Output of ~a ~a</h1>
    It works!
   </body>
  </html>" 
 (lisp-implementation-type)
 (lisp-implementation-version)
)