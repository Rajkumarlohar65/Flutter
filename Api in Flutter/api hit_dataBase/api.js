// Create the Server and Client
const express = require('express');
const app = express();
const client = require('./db_connection.js');

// This is used to handle conversion to and from json.
app.use(express.json());

// ***GET METHOD*** :-> requesting information from the Server
// GET method usually use to get response data
// Get All Users
app.get('/userDetails', (request, response)=>{
    client.query(`SELECT * FROM users`, (err, result)=>{
        if(!err){
            response.send(result.rows);
        }
    });
    client.end;
})


// ***POST METHOD*** :-> POST method used to send data
// POST methods are stored in the request body
// Add New User
app.post('/userDetails/add', (request, response) => {
    const rb = request.body;
    let insertQuery = `INSERT INTO users(id, name, email, age)
                        VALUES(${rb.id}, '${rb.name}','${rb.email}', '${rb.age}');`

    client.query(insertQuery, (err, result) => {
        if(!err){
            response.send('Insertion was successful');
        }
        else{
            console.log(err.message);
        }

    })
    client.end;
})

// // ***PUT METHOD*** 


// ***DELETE METHOD*** 
// Delete a User
app.delete('/userDetails/delete/:id', (request, response) => {
    const deleteQuery = `DELETE FROM users WHERE id = ${request.params.id}`

    client.query(deleteQuery, (err, result) => {
        if(!err){
            response.send('Deletion was successfull');
        }
        else{
            console.log(err.message);
        }
    })
    client.end;
})

const port = 3000;
app.listen(port, () => {
    console.log(`App listening on port ${port}`);
});

