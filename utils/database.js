var mysql = require('mysql');

var createConnection = () => {
    var remote = mysql.createConnection({
        host: 'sql10.freemysqlhosting.net',
        port: '3306',
        user: 'sql10314363',
        password: 'alEh71xttJ',
        database: 'sql10314363'
    });

    var local = mysql.createConnection({
        host: 'localhost',
        port: '3306',
        user: 'root',
        password: '',
        database: 'uberfortutor'
    });

    return local;
}
module.exports = {
    load: sql => {
        return new Promise((resolve, reject) => {
            var connection = createConnection();
            connection.connect();
            connection.query(sql, (error, results, fields) => {
                if (error)
                    reject(error);
                else {
                    resolve(results);
                }
                connection.end();
            });
        });
    },

    add: (tablename, entity) => {
        return new Promise((resolve, reject) => {
            var sql = `insert into ${tablename} set ?`;
            console.log(sql);
            var connection = createConnection();
            connection.connect();
            connection.query(sql, entity, (error, value) => {
                if (error)
                    reject(error);
                else {
                    resolve(value.insertId);
                }
                connection.end();
            });
        });
    },

    update: (tablename, idField, entity) => {
        return new Promise((resolve, reject) => {
            var id = entity[idField];
            delete entity[idField];
            console.log(entity);
            var sql = `update ${tablename} set ? where ${idField} = ?`;
            var connection = createConnection();
            connection.connect();
            connection.query(sql, [entity, id], (error, value) => {
                if (error)
                    reject(error);
                else {
                    resolve(id);
                }
                connection.end();
            });
        });
    },

    delete: (tablename, idField, id) => {
        return new Promise((resolve, reject) => {
            var sql = `delete from ${tablename} where ${idField} = ?`;
            var connection = createConnection();
            connection.connect();
            connection.query(sql, id, (error, value) => {
                if (error)
                    reject(error);
                else {
                    resolve(value.affectedRows);
                }
                connection.end();
            });
        });
    },
};