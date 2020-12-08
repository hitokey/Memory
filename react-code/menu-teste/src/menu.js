import React, {Component} from 'react';
import Menu from './parts/menu';
import Slider from './parts/slider';
import Info from './parts/info';
import Carts from './parts/cartas';
import 'bootstrap/dist/css/bootstrap.css';


class App extends Component{
    render(){
	return (<div>
		<Menu values={this.state.menus}/>
		<Slider values={this.state.slider}/>
		<Info values={this.state.info}/>
		<Carts values={this.state.cards}/>
		</div>
	)}
    state = {
	menus: [],
	slider: [],
	cards: [],
	info: []
    };

    componentDidMount(){
	fetch('http://localhost:3001/menu.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ menus: data })})
	    .catch(console.log)
	fetch('http://localhost:3001/slide.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ slider: data})})
	    .catch(console.log)
	fetch('http://localhost:3001/info.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({info : data})})
	    .catch(console.log)
	fetch('http://localhost:3001/card.json')
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({cards: data})})
	    .catch(console.log)

    }
}

export default App;
