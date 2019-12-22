const Sequelize = require('sequelize');
const db = require('../db');
// defaultValue: Sequelize.NOW 
module.exports = db.sequelize.define(
    'user',
    {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        first_name: Sequelize.STRING,
        last_name: Sequelize.STRING,
        contact_no: Sequelize.STRING,
        address: Sequelize.STRING
    }
);