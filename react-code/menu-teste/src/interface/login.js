import React from 'react';
import { userService } from '../utils/services';
import {Container} from 'react-bootstrap';
import Menu from './parts/menu';
import { Link } from 'react-router-dom';

class Login extends React.Component {
    constructor(props){
	super(props);
	userService.logout();
	this.state = {
	    username: '',
	    password: '',
	    error: '',
	    submitp: false,
	    loadp: false,
	    login: null,
	    menu: []
	};
	
	this.handleChange = this.handleChange.bind(this);
	this.handleSubmit = this.handleSubmit.bind(this);
    }
    componentDidMount(){
	userService.getLogin()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ login: data })})
	    .catch(console.log)
	userService.getMenu()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ menu: data })})
	    .catch(console.log)}

    handleChange(event) {
	const { name, value } = event.target;
	this.setState({ [name]: value});
    }

    handleSubmit(event) {
	event.preventDefault();
	this.setState({ submitp: true });

	if (!(this.state.username && this.state.password)){
	    return;
	}

	this.setState({ loadp: true });
	userService.login(this.state.username, this.state.password)
	    .then(
                user => {
                    const { from } = this.props.location.state || { from: { pathname: "/" } };
                    this.props.history.push(from);
                },
                error => this.setState({ error, loadp: false })
            );
    }
    
    render() {
	const { username, password, submitp, loadp, error} = this.state;
	
        return (<div>
		<Menu values={this.state.menu}/>
		<Container><br></br>
		<form name="form" onSubmit={this.handleSubmit}>
                  <div className={'form-group' +
				  (submitp && !username ? ' has-error' : '')}>
                <label htmlFor="username">Username:</label>
                  <input type="text" className="form-control"
	        name="username" value={username} onChange={this.handleChange} />
		 {submitp && !username &&
                  <br><div className="help-block">{this.state.login.euser}</div></br>
                  }
                  </div>
                  <div className={'form-group' +
				  (submitp && !password ? ' has-error' : '')}>
                <label htmlFor="password">Password:</label>
                   <input type="password" className="form-control" name="password"
	        value={password} onChange={this.handleChange} />
                        {submitp && !password && 
                         <br><div className="help-block">
			 {this.state.login.epass}</div></br>
                        }
		
                    </div>
                    <div className="form-group">
			<button className="btn btn-primary"
               		    disabled={loadp}>Login</button>
                        {loadp &&
                         <img src={this.state.login.src} />
                        }
                    </div>
                    {error &&
                     <div className={'alert alert-danger'}>{error}</div>}
                </form><br></br>
		<Link to="/register">Registar-se</Link>
		</Container></div>);        
    }
};

export default Login;


