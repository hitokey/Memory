import { Link } from 'react-router-dom';
import React from 'react';
import { userService } from '../utils/services';
import Menu from './parts/menu';
import {Container, ListGroup} from 'react-bootstrap';

class User extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            user: {},
	    infos: [],
	    menu: [],

        };
    }

   componentDidMount(){
	userService.getMenu()
	   .then(res => res.json())
	   .then((data) =>
		 { this.setState({ menu: data })})
	   .catch(console.log)
       userService.getInfoUser()
	   .then(res => res.json())
	   .then((data) =>
		 { this.setState({ infos: data })})
	   .catch(console.log)
       this.setState({ 
           user: JSON.parse(localStorage.getItem('user'))
       });
   }
    render() {
        const { user, infos } = this.state;
        return (<div>
		<Menu values={this.state.menu}/>
	        <Container>
		<div>
                <h1>Usuário: {user.username}!</h1>
                <p>Suas Informações Cadastrada:</p>
                <h3>Informações:</h3>
		<div key={infos.id}>
		<ListGroup>
		<ListGroup.Item>Usuário: {infos.username} </ListGroup.Item>
		<ListGroup.Item>Nome: {infos.nome} </ListGroup.Item>
		<ListGroup.Item>Sobrenome: {infos.sobrenome} </ListGroup.Item>
		<ListGroup.Item>Email: {infos.email} </ListGroup.Item>
		</ListGroup>
		</div>
                <p><br></br>
                <Link to="/delete">Remove</Link> <Link to="/login">Logout</Link> 
                </p>
		</div>
		</Container></div>
               );
    }
}

export default User;
