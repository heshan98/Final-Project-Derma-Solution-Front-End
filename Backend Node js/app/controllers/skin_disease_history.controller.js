const db = require("../models");
const SkinDiseaseHistory = db.skinDiseaseHistory;

// Create and Save a new Skin Disease History
exports.create = (req, res) => {
  if (!req.body.image || !req.body.age || !req.body.gender || !req.body.country) {
    return res.status(400).send({ message: "Image, age, gender, and country are required fields" });
  }

  const skinDiseaseHistory = new SkinDiseaseHistory({
    image: req.body.image,
    age: req.body.age,
    gender: req.body.gender,
    country: req.body.country,
  });

  skinDiseaseHistory.save()
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while creating the Skin Disease History."
      });
    });
};

// Retrieve all Skin Disease Histories from the database
exports.findAll = (req, res) => {
  SkinDiseaseHistory.find()
    .then(histories => {
      res.send(histories);
    })
    .catch(err => {
      res.status(500).send({
        message:
          err.message || "Some error occurred while retrieving skin disease histories."
      });
    });
};

// Find a single Skin Disease History with an id
exports.findOne = (req, res) => {
  const id = req.params.id;

  SkinDiseaseHistory.findById(id)
    .then(data => {
      if (!data)
        res.status(404).send({ message: "Not found Skin Disease History with id " + id });
      else res.send(data);
    })
    .catch(err => {
      res
        .status(500)
        .send({ message: "Error retrieving Skin Disease History with id=" + id });
    });
};

// Update a Skin Disease History by the id in the request
exports.update = (req, res) => {
  if (!req.body) {
    return res.status(400).send({
      message: "Data to update cannot be empty"
    });
  }

  const id = req.params.id;

  SkinDiseaseHistory.findByIdAndUpdate(id, req.body, { useFindAndModify: false })
    .then(data => {
      if (!data) {
        res.status(404).send({
          message: `Cannot update Skin Disease History with id=${id}. Maybe Skin Disease History was not found!`
        });
      } else res.send({ message: "Skin Disease History was updated successfully." });
    })
    .catch(err => {
      res.status(500).send({
        message: "Error updating Skin Disease History with id=" + id
      });
    });
};

// Delete a Skin Disease History with the specified id in the request
exports.delete = (req, res) => {
  const id = req.params.id;

  SkinDiseaseHistory.findByIdAndRemove(id, { useFindAndModify: false })
    .then(data => {
      if (!data) {
        res.status(404).send({
          message: `Cannot delete Skin Disease History with id=${id}. Maybe Skin Disease History was not found!`
        });
      } else {
        res.send({
          message: "Skin Disease History was deleted successfully!"
        });
      }
    })
    .catch(err => {
      res.status(500).send({
        message: "Could not delete Skin Disease History with id=" + id
      });
    });
};
