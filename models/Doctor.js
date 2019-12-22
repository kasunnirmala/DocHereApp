const Sequelize = require('sequelize');
const db = require('../db');

module.exports = db.sequelize.define(
    'doctor',
    {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        first_name: Sequelize.STRING,
        last_name: Sequelize.STRING,
        contact_no: Sequelize.STRING,
        address: Sequelize.STRING,
        reg_no: Sequelize.STRING,
        approved: Sequelize.BOOLEAN,
    }
);