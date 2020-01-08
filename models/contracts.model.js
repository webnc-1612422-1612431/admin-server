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

    detailById: id => {
        return db.load(`SELECT c.*, u1.fullname as teachername, u2.fullname as studentname FROM contract c join user u1 on c.teacherid = u1.id
        join user u2 on c.studentid = u2.id where c.id = ${id}
        `);
    },

    // Insert
    add: entity => {
        return db.add(`contract`, entity);
    },    

    update: entity => {
        return db.update(`contract`, `id`, entity);
    },

    detail: () => {
        return db.load(`select c.id, u2.fullname as teachername, u1.fullname as studentname,
        c.revenue, c.startdate, c.enddate, c.state,
        u2.email as teacheremail, u1.email as studentemail,
        (select count(*) from complain c1 where c1.contractid = c.id and c1.ishandled = 0) as numbercomplain
        from contract c
        join user u1 on u1.id = c.studentid
        join user u2 on u2.id = c.teacherid
        `);
    },

    detailByType: (type) => {
        if (type == 'date'){
            return db.load(`SELECT c.enddate as date, sum(c.revenue) as sales
            FROM contract c
            GROUP BY c.enddate`);
        } else if (type == 'week'){
            return db.load(`SELECT DATE_ADD(c.enddate, INTERVAL(1-DAYOFWEEK(c.enddate)) DAY) as date, sum(c.revenue) as sales
            FROM contract c
            GROUP BY CONCAT(YEAR(c.enddate), '/', WEEK(c.enddate))`);
        } else if (type == 'month'){
            return db.load(`SELECT MONTH(c.enddate) as month, sum(c.revenue) as sales
            FROM contract c
            GROUP BY MONTH(c.enddate)`);
        } else if (type == 'year'){
            return db.load(`SELECT YEAR(c.enddate) as year, sum(c.revenue) as sales
            FROM contract c
            GROUP BY YEAR(c.enddate)`);
        }
    },

    salesByTeacher: number => {
            return db.load(`select c.teacherid, sum(c.revenue) as sales, u.*
            from contract c
            join user u on c.teacherid = u.id
            where DATEDIFF(now(), c.enddate) < ${number}
            group by c.teacherid
            order by sales desc`);
    },

    salesBySkill: number => {
        return db.load(`select sum(c.revenue) as sales, s.skill, count(c.skillid) as contract, (select count(us.userid) from user_skill us where us.skillid = c.skillid) as users
        from contract c join skill s on c.skillid = s.id 
        where DATEDIFF(now(), c.enddate) <  ${number}
        group by c.skillid
        order by sales desc`
        );
    },

    totalSales: number => {
        return db.load(`select sum(c.revenue) as sales 
        from contract c`);
    },

    totalContracts: () => {
        return db.load(`select count(*) as contracts from contract`);
    }
};