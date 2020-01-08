var db = require('../utils/database')
module.exports = {

    // Get all
    all: ()=>{
        return db.load(`SELECT u.*, (select count(*) from contract c1 where c1.teacherid = u.id) as contracts, 
        (select avg(ct2.rate) from contract c2 join contractdetail ct2 on c2.id = ct2.contractid where c2.teacherid = u.id) as rate
         FROM user u; `);
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