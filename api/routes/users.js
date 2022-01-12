const express = require('express');
const router = express.Router();
const users = require('../services/users');

router.post('/create', async function(req, res, next) {
  try {
    res.json(await users.create(req.body));
  } catch (err) {
    console.error(`Error while creating trucks`, err.message);
    next(err);
  }
});

module.exports = router;