import {Container, Row, Col, Card, ListGroupItem, ListGroup } from 'react-bootstrap'


const Carts = ({values}) => {
    return (<div>
	    <Container>
	    <Row>
	    { values.map((value) => (
		    <Col>
		    <Card key={value.cartas.id}
		    style={{ width: value.cartas.width,
			     lenght: value.cartas.lenght }}>
		    <Card.Img variant={value.cartas.location}
		              width={value.cartas.img.width}
		              lenght={value.cartas.img.lenght}
		              src={value.cartas.img.src}/>
		    <Card.Body>
		    <Card.Title>{value.cartas.text.principal}</Card.Title>
		    <Card.Text>{value.cartas.text.info}</Card.Text>
		    </Card.Body>
		    <ListGroup key="exemplo" className={value.cartas.text.className}>
		    { value.cartas.language.map((lang) => (
			    <ListGroupItem>{lang.origem}
			      :  {lang.word}
			    </ListGroupItem>))}
		    </ListGroup>
		    <Card.Body>
		    <Card.Link href="#editar?id={value.id}">Editar</Card.Link>
		    <Card.Link href="#info?id={value.id}">Info</Card.Link>
		    </Card.Body>
		    </Card></Col>
	    ))}
	</Row></Container></div>
    )
};

export default Carts;
