import {Container, Jumbotron} from 'react-bootstrap'


const Info = ({values}) => {
    return (
	    <Container>
	    { values.map((value) => (
		    <Jumbotron fluid key="info01">
		    <Container>
		    <h1>{value.pag.title}</h1>
		    <p>{value.pag.text}</p>
		    </Container>
		    </Jumbotron>
	    ))}
	    </Container>
    )
};

export default Info;

