import React from 'react'
import {Carousel, Container, Image} from 'react-bootstrap'


const Slider = ({values}) => {
    return (
	    <Container>
	    <Carousel>
	    { values.map((value) => (
		    <Carousel.Item key={value.id}>
		    <Image className={value.item.className}
		           src={value.item.src}
		           width={value.item.width}
		           alt={value.item.nome}/>
		    <Carousel.Caption>
		    <h3>{value.item.title}</h3>
		    <p>{value.item.text}</p>
		    </Carousel.Caption>
		    </Carousel.Item>
	    ))}
	</Carousel></Container>
    )
}

export default Slider;
