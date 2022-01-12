const express = require('express');
const router = express.Router();
const chats = require('../services/chats');

router.post('/chat', async function(req, res, next) {
  try {
    res.json(await chats.getChat());
  } catch (err) {
    console.error(`Error while getting chats `, err.message);
    next(err);
  }
});

module.exports = router;