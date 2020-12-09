import React from 'react';
import Home from "./menu";
import Flash from "./teste";
import { BrowserRouter, Switch, Route } from "react-router-dom";


function App() {
    return (
	    <BrowserRouter>
	       <Switch>
                 <Route exact path="/"><Home /></Route>
	         <Route path="/flash"><Flash /></Route>
               </Switch>
	    </BrowserRouter>
    );
}


export default App;
