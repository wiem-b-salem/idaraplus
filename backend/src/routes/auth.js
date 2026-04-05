const express = require('express');
const { signup, login, getMe, authenticate } = require('../controllers/authController');

const router = express.Router();

router.post('/signup', signup);
router.post('/login', login);
router.get('/me', authenticate, getMe);

module.exports = router;
