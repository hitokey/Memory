import { authHead } from './auth';

export const userService = {
    login,
    logout,
    register,
    getAllUser,
    getMenu,
    getSlide,
    getInfoT,
    getInfoD,
    getCard,
    getLangUser,
    getCardUser,
    getLogin,
    getReg,
    
};

function logout(){
    localStorage.removeItem('user');
}

function handleResponse(response) {
    return response.text().then(text => {
	const data = text && JSON.parse(text);
	if (!response.ok) {
	    if (response.status === 401) {
		logout();
		//windows.location.reload(true);
	    }
	    const error = (data && data.message) || response.statusText;
	    return Promise.reject(error);
	}
	return data;
    });
}

function getAllUser(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4000/users",
		 requestOptions).then(handleResponse)}


function getMenu(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4242/system/menu", requestOptions)}


function getSlide(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4242/system/slider", requestOptions)}


function getInfoT(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4242/system/infotop", requestOptions)}


function getInfoD(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4242/system/infodown", requestOptions)}


function getCard(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4242/system/cardexemplo", requestOptions)}


function getLangUser(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4242/system/langU", requestOptions)}


function getCardUser(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http://localhost:4242/system/cardU", requestOptions)}


function getLogin(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http:localhost:4242/system/login", requestOptions)}

function getReg(){
    const requestOptions = {
	method: 'GET',
	headers: authHead()
    };
    return fetch("http:localhost:4242/system/register", requestOptions)}


function register(username,password,email,nome){
    const requestOptions = {
	method: 'POST',
	headers: { 'Content-Type': 'application/json' },
	body: JSON.stringify({ username, password, email, nome })};

    return fetch("http://localhost:4242/users/register", requestOptions)
	.then(handleResponse)
	.then(user => {
	    if (user) {
		user.authdata = window.btoa(username + ':' + password);
		localStorage.setItem('user',JSON.stringify(user));
	    }
	    return user;
	});
}
    

function login(username,password) {
    const requestOptions = {
	method: 'POST',
	headers: { 'Content-Type': 'application/json' },
	body: JSON.stringify({ username, password })};

    return fetch("http://localhost:4242/users/authenticate", requestOptions)
	.then(handleResponse)
	.then(user => {
	    if (user) {
		user.authdata = window.btoa(username + ':' + password);
		localStorage.setItem('user', JSON.stringify(user));
	    }
	    return user;
	});
}
