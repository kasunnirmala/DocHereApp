const express = require('express');
const Sequelize = require('sequelize');
require('dotenv/config');

const db = {};
const sequelize = new Sequelize(
    process.env.DB_DATABASE,
    process.env.DB_USERNAME,
    process.env.DB_PASSWORD,
    {
        host: process.env.HOST,
        dialect: "mysql",
        pool: {
            max: 5,
            min: 0,
            acquire: 30000,
            idle: 10000
        },
        dialectOptions: {
            dateStrings: true,
            typeCast: true,
            timezone: "+05:30"
        },
        timezone: "+05:30",
        operatorsAliases: false

    }
);

sequelize.sync(); 
db.sequelize = sequelize;
db.Sequelize = Sequelize;
module.exports = db;