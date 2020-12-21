function performSignIn() {

    let headers = new Headers();

    headers.append('Content-Type', 'application/json');
    headers.append('Accept', 'application/json');
    
    headers.append('Access-Control-Allow-Origin', 'http://localhost:3000');
    headers.append('Access-Control-Allow-Credentials', 'true');
    
    headers.append('GET', 'POST', 'OPTIONS');
}

export default performsSignIn;
