# Memory System Web (SBCL+React)

Interligação dois host, React (NodeJs) com Hunchentoot (SBCL)

# Utilização.

## React:

1. cd react-code/menu-teste
2. npm build 
3. npm start

# SBCL:
 
1. (load #p"host.lisp")
2. (hunchentoot:start *servidor*)


# Obs.:

Para desativar o hunchentoot:

1. (hunchentoot:stop *servidor*)
2. (quit)

Assim o hunchentoot ficará http://127.0.0.1:4242 
e NodeJS http://localhost:3000

