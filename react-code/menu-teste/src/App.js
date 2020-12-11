import React from 'react';
import Home from './interface/menu';
import Login from './interface/login';
import Homepage from './interface/flash';
import Register from './interface/register';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { PrivateRoute } from './utils/private';

class App extends React.Component {
    render() {
        return (
		<div>
		<Router>
		<div>
		<Route exact path="/" component={Home} />
		<Route path="/login" component={Login} />
		<PrivateRoute path="/flash" component={Homepage} />
		<Route path="/register" component={Register} />
		</div>
		</Router>
		</div>
	);
    }
}


export default App;
