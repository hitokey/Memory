import React from 'react'
import 'bootstrap/dist/css/bootstrap.css';
import {Image, Carousel, Container,Jumbotron, Col, Row} from 'react-bootstrap'
import { Form, Nav, Navbar, Card, Button, ListGroup, ListGroupItem } from 'react-bootstrap';

function App() {
    return (
	    <Container>
	    <Container>
	    <Navbar bg="dark" variant="dark">
	    <Navbar.Brand href="#home">
	    <img src="logo.png"
	width="30"
        height="30"
        className="d-inline-block align-top"
        alt="React Bootstrap logo"/>{' '}
	</Navbar.Brand>
	    <Nav  className="mr-auto">
	    <Nav.Link href="#home">Inicio</Nav.Link>
	      <Nav.Link href="#about">Sobre</Nav.Link>
	    <Nav.Link href="#card">Meus FlashCards</Nav.Link>
	    <Nav.Link href="#login">Login</Nav.Link>
	    </Nav>
	    </Navbar>
	    </Container>
	       <Container>
	       <Carousel>
	       <Carousel.Item>
	        <Image className="d-block w-100" src="cap.png"
	          width="100px" alt="First slide"/>
	        <Carousel.Caption>
	        <h3>Muitas Coisas</h3>
	        <p>Ajusta.</p>
	       </Carousel.Caption>
	    </Carousel.Item>
	    <Carousel.Item>
	        <Image className="d-block w-100" src="cap.png"
	          width="100px" alt="First slide"/>
	        <Carousel.Caption>
	        <h3>Muitas Coisas</h3>
	        <p>Ajusta.</p>
	       </Carousel.Caption>
	       </Carousel.Item>
	       </Carousel>
	    </Container>
	    <Container>
	    <Jumbotron fluid>
	    <Container>
	    <h1>Exemplos de FlashCard</h1>
	    <p>
	    Baixo exemplos dos FlashCard:
	    </p>
	    </Container>
	    </Jumbotron>
	    </Container>
            <Container fluid="sm">
	    <Row>
	    <Col>
	    <Card style={{ width: '18rem', lenght: '18rem' }}>
	    <Card.Img variant="top" width="20px" lenght="20px" src="apple.png" />
	    <Card.Body>
	    <Card.Title>Apple</Card.Title>
	    <Card.Text>
	    </Card.Text>
	    </Card.Body>
	    <ListGroup className="list-group-flush">
	    <ListGroupItem>manzana</ListGroupItem>
	    <ListGroupItem>ringo</ListGroupItem>
	    </ListGroup>
            <Card.Body>
	    <Card.Link href="#">Editar</Card.Link>
	    <Card.Link href="#">Info</Card.Link>
	    </Card.Body>
	    </Card>
	    </Col>
	    <Col>
	    <Card style={{ width: '18rem', lenght: '18rem' }}>
	    <Card.Img variant="top" width="20px" lenght="20px" src="apple.png" />
	    <Card.Body>
	    <Card.Title>Apple</Card.Title>
	    <Card.Text>
	    </Card.Text>
	    </Card.Body>
	    <ListGroup className="list-group-flush">
	    <ListGroupItem>manzana</ListGroupItem>
	    <ListGroupItem>ringo</ListGroupItem>
	    </ListGroup>
            <Card.Body>
	    <Card.Link href="#">Editar</Card.Link>
	    <Card.Link href="#">Info</Card.Link>
	    </Card.Body>
	    </Card>
	    </Col>
	    <Col>
	    <Card>
	    <Card.Header>Quote</Card.Header>
	    <Card.Body>
	    <blockquote className="blockquote mb-0">
	    <p>
            {' '}
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere
        erat a ante.{' '}
	</p>
	    <footer className="blockquote-footer">
            Someone famous in <cite title="Source Title">Source Title</cite>
	    </footer>
	    </blockquote>
	    </Card.Body>
	    </Card>
	    </Col>
	    </Row>
	    
	    </Container>
	    <Container>
	    <Jumbotron>
	    <h1>Hello, world!</h1>
	    <p>
	    This is a simple hero unit, a simple jumbotron-style component for calling
	extra attention to featured content or information.
	    </p>
	    <p>
	    <Button variant="primary">Learn more</Button>
	    </p>
	    </Jumbotron>
	    </Container>
	  
	    </Container>
    )
}


export default App;
