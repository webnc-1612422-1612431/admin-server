var db = require('../utils/database')
module.exports = {

    // Get all
    all: ()=>{
        return db.load(`SELECT u.*, (select count(*) from contract c1 where c1.teacherid = u.id) as contracts, 
        (select avg(c2.rate) from contract c2 where c2.teacherid = u.id) as rate,
        (100*(select count(*) from contract c3 where c3.teacherid = u.id and c3.state = 2)/(select count(*) from contract c4 where c4.teacherid = u.id and c4.state = 2)) as successrate
         FROM user u;`);
    },

    // Get by id
    single: email => {
        console.log(`SELECT * FROM user WHERE email = '${email}'`);
        return db.load(`SELECT * FROM user WHERE email = '${email}'`);
    },

    singleById: id => {
        console.log(`SELECT * FROM user WHERE id = '${id}'`);
        return db.load(`SELECT * FROM user WHERE id = '${id}'`);
    },

    // Insert
    add: entity => {
        return db.add(`user`, entity);
    },    

    update: entity => {
        return db.update(`user`, `id`, entity);
    },

    totalUsers: () => {
        return db.load(`select count(*) as users from user`);
    }
};