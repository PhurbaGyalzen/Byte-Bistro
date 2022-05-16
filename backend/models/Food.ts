const mongoose = require('mongoose');

// Create a new schema for hotel room
const foodSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true, 'Name is required'],
  },

  price: {
    type: Number,
    required: [true, 'Price is required'],
  },
  description: {
    type: String,
    required: [true, 'Description is required'],
  },

  image: {
    type: String,
    required: [true, 'Room Position is required'],
  },
});

// Create a model using the schema
const Food = mongoose.model('Food', foodSchema);
module.exports = Food;
