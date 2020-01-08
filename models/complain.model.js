var db = require('../utils/database')
module.exports = {

    // Get all
    all: ()=>{
        return db.load('SELECT * FROM complain');
    },

    singleById: id => {
        console.log(`SELECT * FROM complain WHERE id = '${id}'`);
        return db.load(`SELECT * FROM complain WHERE id = '${id}'`);
    },

    // Insert
    add: entity => {
        return db.add(`complain`, entity);
    },    

    update: entity => {
        return db.update(`complain`, `id`, entity);
    },

    updateByContractId: entity => {
        return db.update(`complain`, `contractid`, entity)
    },

    allByContractId: id => {
        return db.load(`SELECT * FROM complain WHERE contractid = ${id}`);
    }
};