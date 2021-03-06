# Memory System Web (SBCL+React)

Interligação dois host, React (NodeJs) com Hunchentoot (SBCL)

# Utilização.

## React:

```sh
$ cd react-code/menu-teste
$ npm build 
$ npm start
```

# SBCL:
 
1. 
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

