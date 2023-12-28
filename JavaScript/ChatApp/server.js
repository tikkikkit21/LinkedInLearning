const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const http = require("http").Server(app);
const io = require("socket.io")(http);
const mongoose = require("mongoose");
const e = require("express");
require("dotenv").config()

app.use(express.static(__dirname));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

mongoose.Promise = Promise;

const MessageModel = mongoose.model("Message", {
    name: String,
    message: String
});

app.get("/messages", (req, res) => {
    MessageModel.find({}, (err, messages) => {
        res.send(messages);
    });
});

app.get("/messages/:user", (req, res) => {
    const user = req.params.user;
    MessageModel.find({name: user}, (err, messages) => {
        res.send(messages);
    });
});

app.post("/messages", async (req, res) => {
    try {
        const message = new MessageModel(req.body);

        const savedMessage = await message.save();
        
        console.log("saved");
        
        const censored = await MessageModel.findOne({message: "badword"});

        if (censored) {
            await MessageModel.deleteOne({_id: censored.id});
        } else {
            io.emit("message", req.body);
            res.sendStatus(200);
        }
    } catch (error) {
        res.sendStatus(500);
        return console.error(error);
    } finally {
        console.log("message post called")
    }
});

io.on("connection", socket => {
    console.log("a user connected")
})

mongoose.connect(process.env.DB_URL, (err) => {
    console.log("mongodb connection", err);
})

const server = http.listen(3000, () => {
    console.log("Server is listening to port", server.address().port);
});
