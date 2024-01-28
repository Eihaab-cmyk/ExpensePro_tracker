const express = require('express')
const User = require('../models/user.model')
const router = express.Router()
const crypto = require('crypto');
const secretKey = crypto.randomBytes(64).toString('hex');
const jwt = require('jsonwebtoken')

// sign up request
router.post('/signup', (req, res) => {
    console.log(req.body);
    User.findOne({ email: req.body.email })
        .then(existingUser => {
            if (existingUser === null) {
                const user = new User({
                    email: req.body.email,
                    password: req.body.password
                });

                return user.save();
            } else {
                res.json({
                    message: 'Email is not available'
                });
            }
        })
        .then(savedUser => {
            console.log(savedUser);
            res.json(savedUser);
        })
        .catch(err => {
            console.log(err);
            res.json(err);
        });
});

// sign in request
router.post('/signin', (req, res) => {
    User.findOne({ email: req.body.email, password: req.body.password })
        .then(user => {
            if (user) {
                // Sign JWT token upon successful sign-in
                const token = jwt.sign({ userId: user._id }, secretKey, { expiresIn: '2d' });

                res.json({
                    success: true,
                    message: 'Sign in successful',
                    user: user,
                    token: token // Include the token in the response
                });
            } else {
                res.status(404).json({
                    success: false,
                    message: 'User not found'
                });
            }
        })
        .catch(err => {
            console.log(err);
            res.status(500).json({
                success: false,
                message: 'Internal server error'
            });
        });
});

// get user email
router.get('/get-user-email/:userId', async (req, res) => {
    const userId = req.params.userId;
  
    try {
      const user = await User.findById(userId);
      if (user) {
        res.json({
          success: true,
          email: user.email,
        });
      } else {
        res.json({
          success: false,
          message: 'User not found',
        });
      }
    } catch (error) {
      console.error('Error retrieving user email:', error);
      res.status(500).json({
        success: false,
        message: 'Internal server error',
        error: error,
      });
    }
  });

module.exports = router