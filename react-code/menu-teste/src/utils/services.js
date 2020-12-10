import { authGet } from './auth';

export const userService = {
    login,
    logout,
    register,
    getAllUser
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
	headers: authGet()
    };
    return fetch("http://localhost:4000/users", requestOptions).then(handleResponse);
}

function register(username,password,email,nome){
    const requestOptions = {
	method: 'POST',
	headers: { 'Content-Type': 'application/json' },
	body: JSON.stringify({ username, password, email, nome })};

    return fetch("http://localhost:4000/users/register", requestOptions)
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

    return fetch("http://localhost:4000/users/authenticate", requestOptions)
	.then(handleResponse)
	.then(user => {
	    if (user) {
		user.authdata = window.btoa(username + ':' + password);
		localStorage.setItem('user', JSON.stringify(user));
	    }
	    return user;
	});
}
