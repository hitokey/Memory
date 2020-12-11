import React, {Component} from 'react';
import Menu from './parts/menu';
import Slider from './parts/slider';
import Info from './parts/info';
import Carts from './parts/cartas';
import { userService } from '../utils/services';

class Home extends Component{
    render(){
	return (<div>
		<Menu values={this.state.menus}/>
		<Slider values={this.state.slider}/>
		<Info values={this.state.info1}/>
		<Carts values={this.state.cards}/>
		<Info values={this.state.info2}/>
		</div>
	)}
    state = {
	menus: [],
	slider: [],
	cards: [],
	info1: [],
	info2: [],
    }

    componentDidMount(){
	userService.getMenu()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ menus: data })})
	    .catch(console.log)
	userService.getSlide()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({ slider: data})})
	    .catch(console.log)
	userService.getInfoT()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({info1 : data})})
	    .catch(console.log)
	userService.getCard()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({cards: data})})
	    .catch(console.log)
	userService.getInfoD()
	    .then(res => res.json())
	    .then((data) =>
		  { this.setState({info2: data})})
	    .catch(console.log)

    }
}

export default Home;
