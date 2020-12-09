#!/usr/local/bin/sbcl --script

(format t "Context-type: text/html~%~%")

(format t
	"<html>
           <body>
           <from action=\"/yo\" method=\"post\">
           <p>name: <input type=\"text\" name=\"name\"></p>
           <input type=\"submit\" value=\"submit\">
           </from>
           </body>
           </html>")


