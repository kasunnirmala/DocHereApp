const Sequelize = require('sequelize');
const db = require('../db');

module.exports = db.sequelize.define(
    'doctor_location',
    {
       id: {
            type: Sequelize.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        doctor_ID: { 
            type: Sequelize.INTEGER, 
            references: { 
                model: 'dotors', 
                key: 'id' 
            } 
        },
        latitude: Sequelize.DOUBLE,
        longitude: Sequelize.DOUBLE
    }
);