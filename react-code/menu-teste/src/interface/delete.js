import { Link } from 'react-router-dom';
import React from 'react';
import { userService } from '../utils/services';
import Menu from './parts/menu';
import {Container} from 'react-bootstrap';

class Del extends React.Component {
    constructor(props){
	super(props);
	this.state = {
	    user: {},
	    username: '',
	    password: '',
	    error: '',
	    submitp: false,
	    loadp: false,
	    
	    login: [],
	    menu: []
	};
	
	this.handleChange = this.handleChange.bind(this);
	this.handleSubmit = this.handleSubmit.bind(this);
    }
    handleChange(event) {
	const { name, value } = event.target;
	this.setState({ [name]: value});
    }
    handleSubmit(event) {
        event.preventDefault();

        this.setState({ submitted: true });
	
        if (!(this.state.username && this.state.password)) {
            return;
        }

        this.setState({ loading: true });
        userService.deletar(this.state.username, this.state.password)
            .then(
                user => {
                    const { from } = this.props.location.state || { from: { pathname: "/" } };
                    this.props.history.push(from);
                },
                error => this.setState({ error, loadp: false })
            );
    }
    componentDidMount(){
	userService.getMenu()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ menu: data })})
	    .catch(console.log)
	this.setState({ 
            user: JSON.parse(localStorage.getItem('user'))
	});
    }
    
    render() {
	const {user, username, password, error, submitp, loadp,} = this.state;
        return (<div>
		<Menu values={this.state.menu}/>
		<Container><br></br>
		<h1>Deletar Usuário "{user.username}" </h1>
		<p>Claro {user.nome} {user.sobrenome},
		para deletar o seu usuário e usa senha corretamente:</p>
		<form name="form" onSubmit={this.handleSubmit}>
                  <div className={'form-group' +
				  (submitp && !username ? ' has-error' : '')}>
                <label htmlFor="username">Username:</label>
                  <input type="text" className="form-control"
	        name="username" value={username} onChange={this.handleChange} />
		{submitp && !username &&
                 <div className="help-block">Requer UsuÃ¡rio</div>}
                </div>
                <div className={'form-group' +
				(submitp && !password ? ' has-error' : '')}>
                <label htmlFor="password">Password:</label>
                <input type="password" className="form-control" name="password"
	        value={password} onChange={this.handleChange} />
                {submitp && !password && 
		 <div className="help-block">Requer Senha</div>}
		
                </div>
                <div className="form-group">
		<button className="btn btn-primary"
               	disabled={loadp}>Deletar</button>
                {loadp &&
                 <img src="login.gif" alt="loding..." />
                }
                </div>
                {error &&
                 <div className={'alert alert-danger'}>{error}</div>}
                </form><br></br>
		<Link to="/">Home</Link>
		</Container></div>);
    }
};

export default Del;


