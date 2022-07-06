//sequelize
const dotenv = require('dotenv');
dotenv.config();

var Sequelize = require('sequelize')
  , sequelize = new Sequelize(process.env.DB_DATABASE, process.env.DB_USERNAME, process.env.DB_PASSWORD, {
        host: process.env.DB_HOST,
        dialect: "postgres", // or 'sqlite', 'postgres', 'mariadb'
        port:    5432, // or 5432 (for postgres),
        logging: false,
        timezone: "UTC",
    })
  , cq_sequelize = new Sequelize(process.env.CQ_DB_DATABASE, process.env.CQ_DB_USERNAME, process.env.CQ_DB_PASSWORD, {
        host: process.env.CQ_DB_HOST,
        dialect: "postgres", // or 'sqlite', 'postgres', 'mariadb'
        port:    5432, // or 5432 (for postgres),
        logging: false,
        timezone: "UTC",
    });

module.exports = {Sequelize, sequelize, cq_sequelize};
