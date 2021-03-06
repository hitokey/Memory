# Memory System Web (SBCL+React)

Interligado dois host, React (NodeJs) FrontEnd com Hunchentoot (SBCL) BackEnd.

# Utilização.

## React:

```sh
$ cd react-code/menu-teste
$ npm build 
$ npm start
```

# SBCL:

```lisp
* (load #p"host.lisp")
* (hunchentoot:start *servidor*)
```

# Obs.:

Para desativar o hunchentoot:

```lisp
* (hunchentoot:stop *servidor*)
* (quit)
```

Assim o hunchentoot ficará http://127.0.0.1:4242 
e NodeJS http://localhost:3000

