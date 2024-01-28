const express = require('express');
const router = express.Router();
const Transaction = require('../models/transaction_model');
const mongoose = require('mongoose');



// Add a new transaction
router.post('/add-transaction', (req, res) => {
  const { userId, category, type, amount, explanation } = req.body;

  const newTransaction = new Transaction({
    userId: userId,
    category: category,
    type: type,
    amount: amount,
    explanation: explanation,
    //date: date,
  });

  newTransaction
    .save()
    .then((transaction) => {
      console.log('Transaction added:', transaction);
      res.json({
        success: true,
        message: 'Transaction added successfully',
        transaction: transaction,
      });
    })
    .catch((err) => {
      console.error('Error adding transaction:', err);
      res.status(500).json({
        success: false,
        message: 'Internal server error',
        error: err,
      });
    });
});

// get transaction for a specific user
router.get('/user-transactions/:userId', (req, res) => {
  const userId = req.params.userId; // Assuming userId is a string
  console.log('Received userId:', userId);  // Add this line for debugging

  Transaction.find({ userId: userId })
    .then((transactions) => {
      res.json({
        success: true,
        message: 'User transactions retrieved successfully',
        transactions: transactions,
      });
    })
    .catch((err) => {
      console.error('Error retrieving user transactions:', err);
      res.status(500).json({
        success: false,
        message: 'Internal server error',
        error: err,
        error: err.message,  // Include the error message in the response for debugging

      });
    });
});

module.exports = router;
