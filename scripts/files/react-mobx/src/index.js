import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import App from "./App";
import store from "./store";
import { useStrict } from "mobx";
import { Provider } from "mobx-react";
import registerServiceWorker from "./registerServiceWorker";

useStrict(true);

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById("root")
);
registerServiceWorker();
