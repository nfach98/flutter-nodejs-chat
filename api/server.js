const WebSocket = require('ws') 
const wss = new WebSocket.Server({ port: 8080 })
 
var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "chat",
  password: ""
});

wss.on('connection', ws => {
    var chats = [];
    con.connect(function(err) {
      if (err) throw err;
      con.query("SELECT * FROM chats", function (err, result, fields) {
        if (err) throw err;
        chats = result;
        ws.on('message', message => {
            console.log(`Received message => ${message}`)
        })
        ws.send(JSON.stringify(chats))
      });
    });
})