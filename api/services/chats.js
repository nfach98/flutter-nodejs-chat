const db = require('./db');
const helper = require('../helper');
const config = require('../config');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

async function getChat(page = 1){
  // const offset = helper.getOffset(page, config.listPerPage);
  const rows = await db.query(
    'SELECT * FROM chats'
  const data = helper.emptyOrRows(rows);
  const meta = {page};

  return {
    data,
    meta
  }
}