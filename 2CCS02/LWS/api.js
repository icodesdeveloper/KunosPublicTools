const express = require('express');
//Import sequelize
const { Sequelize, DataTypes } = require('sequelize');

const app = express();
const port = 3000;

//Create a sequelize instance with a connection to a database
const sequelize = new Sequelize('postgres://dbm2:dbm2@10.0.31.54:5432/dbm2');
sequelize.authenticate().then(() => {console.log('Connection has been established successfully.');}).catch((error) => {console.error('Unable to connect to the database: ', error);});
//sequelize.createSchema('dbm2').then(() => { console.log('Schema created successfully'); }).catch((error) => { console.error('Error while creating schema: ', error);});

//Initiate the schema
const dbm2 = sequelize.define('dbm2', {
    name: DataTypes.STRING,
}, {
    tableName: 'dbm2', // Specify table name here
    schema: 'dbm2', // Specify the schema here
});
sequelize.sync().then(() => {console.log('Tables successfully created.');}).catch((error) => {console.error('Unable to create table : ', error);});


//Get the name from the database where id = 1
let username = 'Not loaded';


app.get('/user', (req, res) => {
    dbm2.findByPk(1).then((user) => {
        username = user.name;
        res.json({ user:  username});
    }).catch((error) => {console.error('Unable to find user: ', error);});

}); 
app.get('/container', (req, res) => {
    res.json({ id: 'Kuno Claes' });
  });


app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});