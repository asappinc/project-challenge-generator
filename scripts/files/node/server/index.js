var express = require('express')
var app = express()

app.get('/hello', function (req, res) {
    res.send('Hello from Node server!')
});

app.listen(3001, function () {
    console.log('Node server listening on port 3001!')
});