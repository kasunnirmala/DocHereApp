const Sequelize = require('sequelize');
const db = require('../db');

module.exports = db.sequelize.define(
    'doctor_availability',
    {
        id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        doctor_ID: { type: Sequelize.INTEGER, allowNull: false, references: { model: 'dotors', key: 'id' } },
        nearby: Sequelize.BOOLEAN,
        call_available: Sequelize.BOOLEAN,
        home_visit: Sequelize.BOOLEAN
    }
);