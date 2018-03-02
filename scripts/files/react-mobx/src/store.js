import { action, observable } from "mobx";

const Store = observable({
  counter: 1,
  incrementCounter: action(function() {
    this.counter += 1;
  }),

  decrementCounter: action(function() {
    this.counter -= 1;
  })
});

export default Store;
