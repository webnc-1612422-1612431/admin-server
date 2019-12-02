var db = require('../utils/database')
module.exports = {

    // Get all
    all: ()=>{
        return db.load('SELECT * FROM user');
    },

    // Get by id
    single: email => {
        console.log(`SELECT * FROM user WHERE email = '${email}'`);
        return db.load(`SELECT * FROM user WHERE email = '${email}'`);
    },

    // Insert
    add: entity => {
        return db.add(`user`, entity);
    },    

    update: entity => {
        return db.update(`user`, `id`, entity);
    }
};