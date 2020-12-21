import { Link } from 'react-router-dom';
import React from 'react';
import { userService } from '../utils/services';
import Menu from './parts/menu';

class User extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            user: {},
            users: [],
	    menu: []
        };
    }

    componentDidMount() {
        this.setState({ 
            user: JSON.parse(localStorage.getItem('user')),
            users: { loading: true }
        });
	console.log(this.setState.users)
        userService.getAllUser().then(users => this.setState({ users }));
	userService.getMenu()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ menu: data })})
	    .catch(console.log)
    }
    render() {
        const { user, users } = this.state;
        return (
	    	<Menu values={this.state.menu}/>
		<div className="col-md-6 col-md-offset-3">
                <h1>Usuário {user.firstName}!</h1>
                <p>You\'re logged in with React & Basic HTTP Authentication!!</p>
                <h3>Users from secure api end point:</h3>
                {users.loading && <em>Loading users...</em>}
                {users.length &&
                    <ul>
                        {users.map((user, index) =>
                            <li key={user.id}>
                                {user.firstName + ' ' + user.lastName}
                            </li>
                        )}
                    </ul>
                }
                <p>
                <Link to="/login">Logout</Link>
                </p>
            </div>
        );
    }
}

export default User;
