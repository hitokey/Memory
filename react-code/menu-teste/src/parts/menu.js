import React from 'react'
import {Nav, Navbar, Image} from 'react-bootstrap'
import {Carousel, Container, Card} from 'react-bootstrap'


const Menu = ({values}) => {
    return (
	    <div>
	    { values.map((value) => (
		    <div key={value.id}>
		    <Navbar.Toggle aria-controls="responsive-navbar-nav" />
		    <Navbar bg={value.menu.thema}
	                    variant={value.menu.thema}>
		    <Navbar.Brand href={value.menu.home.link}>
		    <Image src={value.menu.home.ico.image}
	                   width={value.menu.home.ico.width}
	                   height={value.menu.home.ico.lenght}
	                   className={value.menu.home.ico.className}
                           alt={value.menu.home.nome}/>{' '}
		</Navbar.Brand>
		    <Nav className={value.menu.nameclass}>
		    { value.menu.listName.map((ln) => (
		      <Nav.Link key={ln.id} href={ln.link}>{ln.nome}</Nav.Link>))}
	            </Nav>
	        </Navbar>
	        </div>
	    ))}
	</div>
    )
};
 

export default Menu;
