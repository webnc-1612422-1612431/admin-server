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
        c.revenue, ct.startdate, ct.enddate, co.content, co.ishandled, c.state, co.id as complainid,
        u2.email as teacheremail, u1.email as studentemail,
        (select count(*) from complain c1 where c1.contractid = ct.contractid and c1.ishandled = 0) as numbercomplain
        from contract c join contractdetail ct on c.id = ct.contractid 
        left join complain co on ct.contractid = co.contractid 
        join user u1 on u1.id = c.studentid
        join user u2 on u2.id = c.teacherid
        `);
    },

    detailByType: (type) => {
        if (type == 'date'){
            return db.load(`SELECT ct.enddate as date, sum(c.revenue) as sales
            FROM contractdetail ct join contract c on ct.contractid = c.id
            GROUP BY ct.enddate`);
        } else if (type == 'week'){
            return db.load(`SELECT DATE_ADD(ct.enddate, INTERVAL(1-DAYOFWEEK(ct.enddate)) DAY) as date, sum(c.revenue) as sales
            FROM contractdetail ct join contract c on ct.contractid = c.id
            GROUP BY CONCAT(YEAR(ct.enddate), '/', WEEK(ct.enddate))`);
        } else if (type == 'month'){
            return db.load(`SELECT MONTH(ct.enddate) as month, sum(c.revenue) as sales
            FROM contractdetail ct join contract c on ct.contractid = c.id
            GROUP BY MONTH(ct.enddate)`);
        } else if (type == 'year'){
            return db.load(`SELECT YEAR(ct.enddate) as year, sum(c.revenue) as sales
            FROM contractdetail ct join contract c on ct.contractid = c.id
            GROUP BY YEAR(ct.enddate)`);
        }
    }
};