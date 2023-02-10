/// 1. Http Server mit 'express' einrichten ...
// Olis Kommentar
const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));
const db = require('./public/js/databaseController')
app.set('view engine', 'pug')

app.get('/admins', async (req, res) => {
  res.render('index', { title: 'Node Server', admins: await db.getDataFromDB("select * from admins")})
});

app.get('/lehrer', async (req, res) => {
  if(req.query.update_by) {
    let update_by = req.query.update_by;
    res.render('lehrer', { title: 'Node Server', lehrer: await db.getDataFromDB("select * from lehrer"), inputs: await db.getDataFromDB("select * from lehrer where id = " + update_by)});
  }
  if(req.query.order_by){
    let a = req.query.order_by;
    res.render('lehrer', { title: 'Node Server', lehrer: await db.getDataFromDB("select * from lehrer order by "+ a )});
  }
  res.render('lehrer', { title: 'Node Server', lehrer: await db.getDataFromDB("select * from lehrer")});
})

app.post('/lehrer', async (req, res) => {
  if (req.body.loesch_id) {
    console.log("########## " + req.body.loesch_id);
    db.update("" +
        "UPDATE schulklasse " +
        "SET   klassenlehrer_id= NULL "+
        "WHERE klassenlehrer_id= " +req.body.loesch_id+ ";");
    db.remove("delete from pruefen where lehrer_id ="+req.body.loesch_id+" ;");
    db.remove("delete from lehrt where lehrer_id ="+req.body.loesch_id+" ;");
    db.remove("delete from unterrichtet where lehrer_id ="+req.body.loesch_id+" ;");
    db.remove("delete from lehrer where lehrer.id ="+req.body.loesch_id+" ;");
  } else if (req.body.id) {
    db.update("UPDATE lehrer SET l_vorname = \"" + req.body.l_vorname + "\", l_nachname = \"" + req.body.l_nachname + "\", l_email = \"" + req.body.l_email + "\" WHERE id = " + req.body.id);
  } else {
    db.insert("lehrer", req.body);
  }
  res.redirect('http://localhost:3000/lehrer');
})

app.get('/schueler', async (req, res) => {
  if(req.query.order_by){
    let a = req.query.order_by;
    console.log(a);
    res.render('schueler', { title: 'Node Server', schueler: await db.getDataFromDB("select schueler.id, schueler.s_vorname, schueler.s_nachname, schueler.s_schuljahr, schueler.s_email, schulklasse.jahrgang, schulklasse.bezeichner\n" +
          "from schueler\n" +
          "LEFT JOIN schulklasse ON schueler.`klassen_id` = schulklasse.id order by "+a+"")})
  } else {
    res.render('schueler', { title: 'Node Server', schueler: await db.getDataFromDB("select schueler.id, schueler.s_vorname, schueler.s_nachname, schueler.s_schuljahr, schueler.s_email, schulklasse.jahrgang, schulklasse.bezeichner\n" +
        "from schueler\n" +
        "LEFT JOIN schulklasse ON schueler.`klassen_id` = schulklasse.id"), klassen: await db.getDataFromDB("select id, jahrgang, bezeichner from schulklasse")});
  }

});

app.post('/schueler', async (req, res) => {
  if(req.body.id){
    db.update("" +
                    " UPDATE schulklasse\n" +
                    " SET   klassensprecher_id = NULL\n" +
                    " WHERE klassensprecher_id= " +req.body.id+ ";"
    );
    db.remove("delete from pruefen where schueler_id = "+req.body.id+" ;");
    db.remove("delete from schueler where schueler.id = "+req.body.id+" ;");
  }else if (req.body.order_by){//TODO
    res.render('schueler', { title: 'Node Server', schueler: await db.getDataFromDB("select * from schueler order by"+ req.body.order_by)});
  }else{
    db.insert("schueler", req.body);
  }
    res.redirect('http://localhost:3000/schueler');
});

app.get('/schulklasse', async (req, res) => {
  let sql = "";
  if (req.query.order_by){
    let a = req.query.order_by;
    sql = "SELECT schulklasse.id, schulklasse.jahrgang, schulklasse.bezeichner, lehrer.l_vorname, lehrer.l_nachname, schueler.s_vorname, schueler.s_nachname FROM schulklasse LEFT JOIN lehrer ON schulklasse.klassenlehrer_id = lehrer.id LEFT JOIN schueler ON  schulklasse.klassensprecher_id = schueler.id order by  "+ a;
    res.render('schulklasse', { title: 'Node Server', schulklasse: await db.getDataFromDB(sql)});
  }
  else{
    sql = "SELECT schulklasse.id, schulklasse.jahrgang, schulklasse.bezeichner, lehrer.l_vorname, lehrer.l_nachname, schueler.s_vorname, schueler.s_nachname\n" +
      "FROM schulklasse\n" +
      "LEFT JOIN lehrer ON schulklasse.klassenlehrer_id = lehrer.id\n" +
      "LEFT JOIN schueler ON  schulklasse.klassensprecher_id = schueler.id";
    res.render('schulklasse', { title: 'Schulklassen', schulklasse: await db.getDataFromDB(sql), klassenlehrer: await db.getDataFromDB("select * from lehrer"), klassensprecher: await db.getDataFromDB("select * from schueler")});
  }
});

app.post('/schulklasse', async (req, res) => {
  if(req.body.id){
    // beim löschen einer klasse wird erst die tabelle schuler bearbeitet(klassen_ID bei den schüler auf null setzten)
    //dann die Relationen raumverwendung und unterrichtet die mit der Klasse abhängen gelöcsht und abschileßend wird die klasse gelöscht
    db.update("" +
                  "UPDATE schueler " +
                  "SET   klassen_id= NULL "+
                  "WHERE klassen_id= " +req.body.id+
                  ";");
    db.remove("delete from raumverwendung where klassen_id = "+req.body.id+" ;");
    db.remove("delete from unterrichtet   where klassen_id = "+req.body.id+" ;");
    db.remove("delete from schulklasse    where id = "+req.body.id+" ;")
  }else {
    db.insert("schulklasse", req.body);
  }
  res.redirect("http://localhost:3000/schulklasse");
});

app.get('/raum', async (req, res) => {
  if(req.query.order_by){
    let a = req.query.order_by;
    res.render('raum', { title: 'Node Server', raum: await db.getDataFromDB("select * from raum order by " + a )})

  } else {
    res.render('raum', { title: 'Raum', raum: await db.getDataFromDB("select * from raum"), raumart: await db.getDataFromDB("select raumart from raum group by raumart")})
  }
});

app.post('/raum', async (req, res) => {
  //wenn die request ein id beinhaltet, der löschbutton wurde gedrückt
  if (req.body.id){
    //erst wird die beziehzn "raumverwendung" gelöscht dann der Raum selbst
    db.remove("delete from raumverwendung where raum_id = "+req.body.id+" ;");
    db.remove("delete from raum where raum.id = "+req.body.id+" ;");
  }else{
    db.insert("raum", req.body);
  }
  res.redirect("http://localhost:3000/raum");
});


app.get('/remove', (req,res) => {
  if (req.query.name !== undefined) {
    console.log(req.query);
    db.remove(req.query.name)
  }

  // Zurück zur Tabellenansicht
  res.redirect("http://localhost:3000");
})

app.get('/', async (req,res)=> {
  let adminData = ["anas.a", "1111", "oli.g" ,"1234", "jonas.b","1212"];
  console.log(req.query.username);
  console.log(req.query.pw);
  switch (req.query.username) {
    case adminData[0]:
      if (req.query.pw === adminData[1])
        res.render('index', { title: 'Node Server', admins: await db.getDataFromDB("select * from admins")});
      break;
    case adminData[2]:
      if(req.query.pw === adminData[3])
        res.render('index', { title: 'Node Server', admins: await db.getDataFromDB("select * from admins")});
      break;
    case adminData[4]:
      if(req.query.pw === adminData[5])
        res.render('index', { title: 'Node Server', admins: await db.getDataFromDB("select * from admins")})
      break;
    default :
      res.render('login', { title: 'Node Server', admins: await db.getDataFromDB("select * from admins")})

  }

});


/// 2. Server starten und auf localhost:3000 horchen
app.listen(3000, () => {
  console.log(`Example app listening at http://localhost:3000`);
  db.connect();
});