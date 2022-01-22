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
	socket.on("online", (id) => {
		console.log(id);
		clients[id] = socket;
		clients[id].emit("online", Object.keys(clients));
	});

	socket.on("message", (msg) => {
		// console.log(msg);
		let idReceiver = msg.idReceiver;
		if (clients[idReceiver]) clients[idReceiver].emit("message", msg);
	});

	socket.on("offline", (id) => {
		delete clients[id];
		console.log(Object.keys(clients));
	});
});

app.route("/check").get((req, res) => {
	return res.json("Your App is working fine");
});

server.listen(port, "0.0.0.0", () => {
	console.log("server started");
})