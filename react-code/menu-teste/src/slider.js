import React, {Component} from 'react';
import Slider from './parts/slider'
import 'bootstrap/dist/css/bootstrap.css';

class App extends Component{
    render(){
	return (
		<Slider values={this.state.contacts}/>
	)}
    state = {
	contacts: []
    };

    componentDidMount(){
	fetch('http://localhost:3001/slider.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ contacts: data })})
	    .catch(console.log)
    }
}

export default App;

