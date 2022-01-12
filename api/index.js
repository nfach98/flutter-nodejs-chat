const express = require("express");
var http = require("http");
const cors = require("cors");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server, {
	cors: {
		origin: "*"
	}
});

//middleware
app.use(express.json());
app.use(cors());

var clients = {};

io.on("connection", (socket) => {
	console.log("connected");
	socket.on("signin", (id) => {
		console.log(id);
		clients[id] = socket;
	});

	socket.on("message", (msg) => {
		console.log(msg);
		let idReceiver = msg.idReceiver;
		if (clients[idReceiver]) clients[idReceiver].emit("message", msg);
	});
});

server.listen(port, "0.0.0.0", () => {
	console.log("server started");
})