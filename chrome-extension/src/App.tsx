import React from "react";
import { Route, Switch } from "react-router-dom";
import { About } from "./routes/About";
import { Configure } from "./routes/Configure";
import { Home } from "./routes/Home";

import "./App.css";

export const App = () => {
  return (
    <Switch>
      <Route path="/about">
        <About />
      </Route>
      <Route path="/">
        <Home />
      </Route>
      <Route path="/configure">
        <Configure />
      </Route>
    </Switch>
  );
};
