const express = require('express');
const app = express();
const bodyParse = require('body-parser');
const cors = require('cors');
const formidable = require('express-formidable');
const http = require('http').Server(app);
const io = require('socket.io')(http);


app.use(cors());

app.use(bodyParse.json());
app.use(bodyParse.urlencoded({ extended: true }));

const userRoute = require('./routes/user');
const doctorRoute = require('./routes/doctor');
const doctorLocationRoute = require('./routes/doctor_location');
const doctorAvailabilityRoute = require('./routes/doctor_availability');


app.use('/user', userRoute);
app.use('/doctor', doctorRoute);
app.use('/doc_loc', doctorLocationRoute);
app.use('/doc_avai', doctorAvailabilityRoute);

app.get('/', (res, req) => {
    req.send("TEST");
});

io.on('connection', socket => {
    console.log("CONNECTED");
    // socket.on('hello-sent', (msg) => {
    //     console.log(msg);
    //     socket.emit("hello", { greeting: msg });
    // });
    socket.on('disconnect', () => {
        console.log("DISCONNECTED");
    });
});

http.listen(process.env.PORT || 3000)