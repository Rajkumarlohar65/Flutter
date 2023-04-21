const express = require('express')
const app = express()
const port = 3000
const data = require('./data.json')
const fs = require('fs')

app.use(express.json());

// Fetch users data
app.get('/userDetails', (req, res) => {
    
    try {
      const userData = data;
      res.json(userData);
    } catch (error) {
      res.status(500).send('Internal server error');
    }
})

// Add users data
app.post('/userDetails/add', (req, res) => {
  const { id, name, email, age} = req.body;
  const user = { id, name, email, age };
  
  // Read the existing users from the JSON file
  const users = JSON.parse(fs.readFileSync('./data.json'));
  
  // Add the new user to the array
  users.push(user);
  
  // Write the updated users array back to the JSON file
  fs.writeFileSync('./data.json', JSON.stringify(users, null, 2));
  
  // Send a response with the newly added user
  res.json(user);
});

// Deleting a user by id
app.delete('/userDetails/delete/:id', (req, res) => {
  try {
    const _id = parseInt(req.params.id);
    const users = JSON.parse(fs.readFileSync('./data.json'));
    const filteredUsers = users.filter((user) => user.id !== _id);
    fs.writeFileSync('./data.json', JSON.stringify(filteredUsers, null, 2));
    res.status(204).send(); // No content response
  } catch (error) {
    console.error(error);
    res.status(500).send('Internal server error');
  }
});



app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})