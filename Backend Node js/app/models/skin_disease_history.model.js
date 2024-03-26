const mongoose = require("mongoose");

const skinDiseaseHistorySchema = new mongoose.Schema({
  image: {
    type: String,
    required: true
  },
  age: {
    type: Number,
    required: true
  },
  gender: {
    type: String,
    required: true
  },
  country: {
    type: String,
    required: true
  }
}, {
  timestamps: true // Adds created_at and updated_at timestamps
});

const SkinDiseaseHistory = mongoose.model("SkinDiseaseHistory", skinDiseaseHistorySchema);

module.exports = SkinDiseaseHistory;
