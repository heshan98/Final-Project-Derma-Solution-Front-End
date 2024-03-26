const mongoose = require('mongoose');
mongoose.Promise = global.Promise;

const db = {};

db.mongoose = mongoose;

db.user = require("./user.model");
db.role = require("./role.model");

db.product = require("./products.model.js")(mongoose);

db.ROLES = ["user", "admin", "moderator"];//for future update for a admin or moderator.

module.exports = db;