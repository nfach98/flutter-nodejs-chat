const db = require('./db');
const helper = require('../helper');
const config = require('../config');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

async function create(user){
	const date = new Date();
	const today = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate() + " " 
	+ date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();

  const password = await bcrypt.hash(user.password, 12);

  const result = await db.query(
    'INSERT INTO users (name, email, password, token, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)', 
    [user.name, user.email, password, user.token, today, today]
  );

  let message = 'Error in create user';

  if (result.affectedRows) {
    message = 'User ' + user.name + ' is created succesfully';
  }

  return {message};
}

module.exports = {
  create
}