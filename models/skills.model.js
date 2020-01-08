var db = require('../utils/database')
module.exports = {

    // Get all
    all: ()=>{
        return db.load('SELECT s.*, (select count(*) from user_skill us where us.skillid = s.id) as used FROM skill s');
    },

    // Get by name
    single: name => {
        console.log(`SELECT * FROM skill WHERE skill = '${name}'`);
        return db.load(`SELECT * FROM skill WHERE skill = '${name}'`);
    },

    singleById: id => {
        console.log(`SELECT * FROM skill WHERE id = '${id}'`);
        return db.load(`SELECT * FROM skill WHERE id = '${id}'`);
    },

    // Insert
    add: entity => {
        return db.add(`skill`, entity);
    },    

    update: entity => {
        return db.update(`skill`, `id`, entity);
    },

    totalSkills: () => {
        return db.load(`select count(*) as skills from skill`);
    }
};