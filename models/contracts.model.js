var db = require('../utils/database')
module.exports = {

    // Get all
    all: ()=>{
        return db.load('SELECT * FROM contract');
    },

    singleById: id => {
        console.log(`SELECT * FROM contract WHERE id = '${id}'`);
        return db.load(`SELECT * FROM contract WHERE id = '${id}'`);
    },

    // Insert
    add: entity => {
        return db.add(`contract`, entity);
    },    

    update: entity => {
        return db.update(`contract`, `id`, entity);
    },

    detail: () => {
        return db.load(`select ct.contractid, u2.fullname as teachername, u1.fullname as studentname,
        c.revenue, ct.startdate, ct.enddate, co.content, co.ishandled, c.state
        from contract c join contractdetail ct on c.id = ct.contractid 
        join complain co on ct.contractid = co.contractid 
        join user u1 on u1.fullname = c.studentid
        join user u2 on u2.fullname = c.teacherid
        `);
    }
};