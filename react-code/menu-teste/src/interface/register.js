import React from 'react';
import { userService } from '../utils/services';
import { Container } from 'react-bootstrap';
import Menu from './parts/menu';

class Register extends React.Component {
    constructor(props){
	super(props);
	this.state = {
	    username: '',
	    password: '',
	    email: '',
	    nome: '',
	    sobre: '',
	    error: '',
	    submitp: false,
	    loadp: false,
	    menu: []
	};

	this.handleChange = this.handleChange.bind(this);
	this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
	const { name, value } = event.target;
	this.setState({ [name]: value});
    }

    handleSubmit(event){
	event.preventDefault();
	this.setState({ submitp: true });
	
	if (!(this.state.username && this.state.password && this.state.email
	     && this.state.nome && this.state.sobre)){
	    return;
	}

	this.setState({ loadp: true });
	userService.register(this.state.username, this.state.password, this.state.email, this.state.nome, this.state.sobre)
	    .then(
                user => {
                    const { from } = this.props.location.state || { from: { pathname: "/" } }
                    this.props.history.push(from)
                },
                error => this.setState({ error, loadp: false }) 
            )
    }

    componentDidMount(){
	userService.getMenu()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ menu: data })})
	    .catch(console.log)
//	userService.getReg()
//	    .then(res => res.json())
//	    .then((data) =>
//		  { this.setState({ reg: data })})
//	    .catch(console.log)
   }
		      

    render() {
	const { username, password, email, nome, sobre, error,submitp,loadp} = this.state;
	return (<div>
		<Menu values={this.state.menu}/>
		<Container><br></br>
		<form name="form" onSubmit={this.handleSubmit}>


		<div className={'form-group' +
				(submitp && !username ? ' has-error' : '')}>
		<label htmlFor="username">Username:</label>
		<input type="text" className="form-control" name="username"
		value={username}
		onChange={this.handleChange} />
		{submitp && !username &&
		 <div className="help-block">Requer Usuário</div>}
		</div>


		<div className={'form-group' +
				(submitp && !password ? ' has-error' : '')}>
		<label htmlFor="password">Password:</label>
		<input type="password" className="form-control" name="password"
		value={password}
		onChange={this.handleChange} />
		{submitp && !password &&
		 <div className="help-block">Requer Senha</div>}
		</div>

		
		<div className={'form-group' +
				(submitp && !email ? ' has-error' : '')}>
		<label htmlFor="email">E-mail:</label>
		<input type="email" className="form-control" name="email"
		value={email}
		onChange={this.handleChange} />
		{submitp && !email &&
		 <div className="help-block">Requer E-mail</div>}
		</div>


		<div className={'form-group' +
				(submitp && !nome ? ' has-error' : '')}>
		<label htmlFor="nome">Nome:</label>
		<input type="text" className="form-control" name="nome"
		value={nome}
		onChange={this.handleChange} />
		{submitp && !nome &&
		 <div className="help-block">Requer Nome</div>}
		</div>

		<div className={'form-group' +
				(submitp && !nome ? ' has-error' : '')}>
		<label htmlFor="sobre">Sobre:</label>
		<input type="text" className="form-control" name="sobre"
		value={sobre}
		onChange={this.handleChange} />
		{submitp && !nome &&
		 <div className="help-block">Requer Sobrenome</div>}
		</div>
		
		<div className="form-group">
		<button className="btn btn-primary"
		disabled={loadp}>Register</button>
		{loadp && <img src="login.gif" alt="loging..."/>}
		</div>

		{error && <div className={'alert alert-danger'}>{error}</div>}
		</form><br></br>
		</Container>
		</div>);
    }
};

export default Register;
