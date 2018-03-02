import React, { Component } from 'react';
import logo from './logo.svg';
import { inject, observer } from 'mobx-react';
import './App.css';

class App extends Component {
  render() {
    const { store } = this.props;

    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
          <p>The counter is at {store.counter}</p>
        </header>
        <p className="App-intro">
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
        <div>
          <button onClick={() => store.incrementCounter()}>
            Increase Counter
          </button>
          <button onClick={() => store.decrementCounter()}>
            Decrease Counter
          </button>
        </div>
      </div>
    );
  }
}

export default inject('store')(observer(App));
