//sequelize
const dotenv = require('dotenv');
dotenv.config();

var Sequelize = require('sequelize')
  , sequelize = new Sequelize(process.env.DB_DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD, {
        host: process.env.DB_HOST,
        dialect: "postgres", // or 'sqlite', 'postgres', 'mariadb'
        port:    5432, // or 5432 (for postgres),
        logging: false
    });

module.exports = {Sequelize, sequelize};
