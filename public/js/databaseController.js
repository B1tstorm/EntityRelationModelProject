/// 1. Datenbank connector.
const con = require("./databaseContext").con;

// Funktion zum verbinden mit der Datenbank
function connect() {
    /// 2. Verbindung zu DB aufbauen
    con.connect((err) => {
        if (err) throw err;
        console.log("++++++++++++++DB connected!++++++++++++++++++");
    });
}

function insert(table, query) {
    let keysString = "";
    let valuesString = "";
    let keys = [];
    let values = [];
    for (let key in query) {
        if (query.hasOwnProperty(key)) {
            console.log(key + " -> " + query[key]);
            keys.push(key);
            if (query[key] === "") {
                values.push("null");
            } else {
                values.push("\"" + query[key] + "\"");
            }
        }
    }
    valuesString = values.join(', ');
    keysString = keys.join(', ');

    // Werte in die Datenbank schreiben
    let sql = "INSERT INTO " + table + " (" + keysString + ") VALUES (" + valuesString + ")";
    con.query(sql, function (err) {
      if (err) throw err;
    });
}

function remove(sql) {
    con.query(sql, function (err) {
        if (err) throw err;
    });
}

function update(sql) {
    con.query(sql, function (err) {
        if (err) throw err;
    });
}

function getDataFromDB(sql) {
    try {
        return new Promise(resolve => {
            con.query(sql, (error, data) => {
                if (error) throw error;
                resolve(data);
            });
        });
    } catch(e) {
        console.log(e);
    }
}

module.exports = { connect, insert, update, remove, getDataFromDB }
