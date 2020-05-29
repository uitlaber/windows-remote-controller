const cmd = require('node-cmd')
const express = require('express')
const bodyParser = require('body-parser')
const path = require('path');

const app = express()
app.use(bodyParser.urlencoded({ extended: true }));


// app.get('/', (request, response) => {
//     response.sendFile(path.join(__dirname + '/index.html'));
// })

app.post('/', (request, response) => {
    console.log(path.join(__dirname + '/nircmdc.exe ') + request.body.cmd);
    cmd.get(
        path.join(__dirname + '/nircmdc.exe ') + request.body.cmd,

        

        // function(err, data, stderr){
        //     // console.log(request.body.cmd)
        //     //console.log('the current dir contains these files :\n\n',data)
        // }

        // function(err, data, stderr){
        //     return response.status(404).json({
        //         status: 'error',
        //         message: request.body.cmd
        //     })
        // }
    );
})

app.use((err, request, response, next) => {
    // логирование ошибки, пока просто console.log
    console.log(err)
    response.status(500).send('Something broke!')
})

app.listen(9988)


    
    

 
