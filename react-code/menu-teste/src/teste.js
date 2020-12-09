import React, {Component} from 'react';
import Menu from './parts/menu';
import Slider from './parts/slider';
import Info from './parts/info';
import Carts from './parts/cartas';
import './bootstrap.css';

class Flash extends Component{
    render(){
	return (<div>
		<Menu values={this.state.menus}/>
		<Info values={this.state.info1}/>
		<Carts values={this.state.cards}/>
		</div>
	)}
    state = {
	menus: [],
	cards: [],
	info1: [],
    };

    
    componentDidMount(){
	fetch('http://localhost:3000/menu.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ menus: data })})
	    .catch(console.log)
	fetch('http://localhost:3000/info.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({info1 : data})})
	    .catch(console.log)
	fetch('http://localhost:3000/card.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({cards: data})})
	    .catch(console.log)

    }
}

export default Flash;
