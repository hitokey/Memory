# Memory System Web (SBCL+React)

Interligação dois host, React (NodeJs) com Hunchentoot (SBCL)

# Utilização.

 - React:

 -- cd react/
 -- npm build 
 -- npm start

 - SBCL:
 
 -- (load #p"host.lisp")
 -- (start)
 
Assim o hunchentoot ficará 127.0.0.1:4242 
e NodeJS 127.0.0.1:4343.
