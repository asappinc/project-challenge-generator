import React, { Component } from "react";
import logo from "./logo.svg";
import 'isomorphic-fetch';
import "./App.css";

class App extends Component {
  state = {
    serverText: "Click the button"
  };

  fetchHello() {
    fetch("/hello")
      .then(res => res.text())
      .then(text => {
        this.setState({
          serverText: text
        });
      });
  }

  render() {
    const { serverText } = this.state;

    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
        <button onClick={() => this.fetchHello()}>Get Server Text</button>
        <p>{serverText}</p>
      </div>
    );
  }
}

export default App;
