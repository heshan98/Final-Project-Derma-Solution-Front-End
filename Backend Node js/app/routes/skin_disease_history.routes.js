const express = require("express");
const router = express.Router();

const skinDiseaseHistoryController = require("../controllers/skinDiseaseHistory.controller");


router.post("/", skinDiseaseHistoryController.create);


router.get("/", skinDiseaseHistoryController.findAll);


router.get("/:id", skinDiseaseHistoryController.findOne);

router.put("/:id", skinDiseaseHistoryController.update);


router.delete("/:id", skinDiseaseHistoryController.delete);

module.exports = router;
