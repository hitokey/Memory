import React from 'react'
import { Button, Form } from 'react-bootstrap'


const App = () => {
    return (<div>
	    <Form action='autho' method='get'>
	    <Form.Group controlId="formBasicEmail">
	    <Form.Label>Email address</Form.Label>
	    <Form.Control type="email" placeholder="Enter email" />
	    </Form.Group>
	    
	    <Form.Group controlId="formBasicPassword">
	    <Form.Label>Password</Form.Label>
	    <Form.Control type="password" placeholder="Password" />
	    </Form.Group>
	    <Form.Group controlId="formBasicCheckbox">
	    <Form.Check type="checkbox" label="Check me out" />
	    </Form.Group>
	    <Button variant="primary" type="submit"> Submit</Button>
	    </Form>
	    </div>

    )
};
 

export default App;



  
