import React, { Component } from "react";
import { connect } from "react-redux";
import logo from "./logo.svg";
import { incrementCounter, decrementCounter } from "./actions";
import "./App.css";

class App extends Component {
  render() {
    const { props } = this;

    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
          <p>The counter is at {props.counter}</p>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
        <div>
          <button onClick={() => this.props.incrementCounter()}>
            Increase Counter
          </button>
          <button onClick={() => this.props.decrementCounter()}>
            Decrease Counter
          </button>
        </div>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  counter: state.counter
});

const mapDispatchToProps = {
  incrementCounter,
  decrementCounter
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
