
// command to start in prod mode with watch : npm start 
// command to start in dev mode with watch : npm run start-dev

// redis : 4.1.0 -> from the course . 

const express = require('express');
const mongoose = require('mongoose');
const redis = require('redis');
const { Client } = require('pg');

// init app 
const PORT = process.env.PORT || 4000;
const app = express()

app.listen(PORT, () => {
	console.log(`app is up and running on port: ${PORT}`)
});

const REDIS_HOST = 'redis';
const REDIS_PORT = '6379'

const redisClient = redis.createClient({
  socket: {
    host: REDIS_HOST,
    port: REDIS_PORT
  }
});

redisClient.on('error', (err) => console.log('Redis client error', err));
redisClient.on('connect', () => console.log('Connected to Redis'));
redisClient.connect();



// mongo database connection using mongoose : 
const DB_USER = 'root';
const DB_PASSWORD = 'example';
const DB_PORT = 27017;
const DB_HOST = 'mongo';

// const URI = `mongodb://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}`;
const URI = `mongodb://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/`; //${DB_NAME}?authSource=admin
mongoose.connect(URI).then(
	() => console.log('successfully connected to database')
).catch((erro) => console.log('faild to connect to db ', erro));







// postgress database connection using pg package :
// const DB_USER = 'postgres';
// const DB_PASSWORD = 'postgrespassword';
// const DB_PORT = 5432;
// const DB_HOST = 'postgres';
// const DB_NAME = 'mydatabase';

// const client = new Client({
//   user: `${DB_USER}`,
//   host: `${DB_HOST}`,
//   database: `${DB_NAME}`,
//   password: `${DB_PASSWORD}`,
//   port: `${DB_PORT}`,
// });

// client.connect().then(
//  () => console.log('successfully connected to postgres db')
// ).catch((erro) => console.log('faild connection to postgres db ', erro));





app.get('/', (req, res) => {
	redisClient.set('products', 'phones, laptop, sd, ram...etc');
	res.send('<h1>Hello mena dev-dev using docker-hup <h1>')
	console.log(`response sent on port : ${PORT}`)
});


app.get('/data', async (req, res) => {
	const products = await redisClient.get('products');
	res.send(`<h1>Hello mena dev </h1> <h2>${products}</h2>`)
});

