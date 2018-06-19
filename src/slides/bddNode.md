#### <em style="color: red">Intégration de bases de données</em>
L’ajout de la <em style="color: #01B0F0">fonctionnalité</em> permettant de <em style="color: magenta">connecter</em> des bases de données aux <em style="color: blue">applications</em> Express consiste simplement à <em style="color: #01B0F0">charger</em> un <em style="color: blue">pilote</em> Node.js approprié pour <em style="color: green">les bases de données</em> de votre application.

<nsv>
<em style="color: blue">Pilote Node.js pour les BDD</em> <br/>
Les <em style="color: green">pilotes Node.js</em> qu'on utilisent pour les systèmes de  <em style="color: magenta">base de données</em> sont:
* <em style="color: red">Oracle</em><em style="color: blue">:</em> <em style="color: #01B0F0">npm install --save oracledb</em> 
* <em style="color: red">Postgres</em><em style="color: blue">:</em> <em style="color: #01B0F0">npm install --save pg</em>  
* <em style="color: red">Couchbase</em><em style="color: blue">:</em> <em style="color: #01B0F0">npm install --save couchbase</em>  
* <em style="color: red">Teradata</em><em style="color: blue">:</em> <em style="color: #01B0F0">npm install --save jdbc</em>  


<nsv>
<em style="color: blue">Utilisation du pilote postgres</em> <br/>
Créer cette <em style="color: red">structure</em> dans votre <em style="color: green">répertoire</em> de <em style="color: red">travail</em>:
```
├──app/                
│   ├──database/             
│   |   ├──connection.js             * Connexion à bdd 
│   │   └──queryBuilder.js           * Execute query
│   ├──routes/              
│   │   ├──sample-api                
│   |   |   ├──sample-apiRouter.js          * La route 
|   │   |   ├──sample-apiService.js         * Partie métier
|   |   |   └──sample-apiSpec.js            * Unit test
│   │
│   └──config.js            * Configuration principale
│ 
├──config.properties        * Externalisation de la config
```
<em style="color: red">Installation</em> du driver <em style="color: magenta">postgres</em>:
```bash
npm install pg --save
npm install pg-query-stream --save
```
<nsv>
<em style="color: blue">Externalisation de la configuration(1/4)</em> <br/>
Dans cette partie on va <em style="color: red">externaliser</em> la <em style="color: green">configuration</em> des paramètres de connexion comme des <em style="color: magenta">variables d'environnement</em>, puis les <em style="color: #01B0F0">exporter</em>.<br/>
Rajouter ces <em style="color: red">lignes</em> au fichier <em style="color: red">app/config.js</em>
```js
module.exports = {
    //Config DATABASE
    database: {
        user: process.env.DB_USER,
        database: process.env.DB_DATABASE,
        password: process.env.DB_PASSWORD,
        host: process.env.DB_HOST,
        port: process.env.DB_PORT,
        poolMax: process.env.DB_POOL_MAX
    }
}    
```

<nsv>
<em style="color: blue">Externalisation de la configuration(2/4)</em> <br/>
Maintenant dans le fichier <em style="color: red">config.properties</em> on va <em style="color: green">renseigner</em> les <em style="color: red"> valeurs </em>des variables d'environnement <em style="color: magenta">précédement</em> déclarés:

```bash
DB_USER=postgres
DB_DATABASE=express
DB_PASSWORD=auchan
DB_HOST=10.155.13.166
DB_PORT=5432
DB_POOL_MAX=18
```

<nsv>
<em style="color: blue">Externalisation de la configuration(3/4)</em> <br/>
Pour <em style="color: red">charger</em> les valeurs de ces <em style="color: green">variables d'environnement</em> définie dans le fichier <em style="color: magenta">config.properties</em> on va utiliser le module <em style="color: red">dotenv</em>:<br/>

```bash
npm install dotenv --save
```
Rajouter ces lignes au début du fichier <em style="color: red">config.js</em>

```js
const dotenv = require('dotenv');
dotenv.config({ path: process.env.NODEJS_CONF_PATH_APP + '/config.properties' });
```

<nsv>
<em style="color: blue">Externalisation de la configuration(4/4)</em> <br/>
Avant de demarrer l'application renseigner le <em style="color: green">chemin</em> du fichier <em style="color: red">config.properties</em>, en le passant à la variable d'environnement <em style="color: magenta">NODEJS_CONF_PATH_APP</em>.<br/>
Exemple d'utilisation:

```bash
NODEJS_CONF_PATH_APP=/product/nodejs/conf node app.js
```


<nsv>
<em style="color: blue">Création du pool de connexion</em> <br/>
Dans le fichier <em style="color: red">connection.js</em> on fait un <em style="color: green">import</em>  du fichier <em style="color: red">config.js</em> (on renseigne chaque propriété), puis on créer le <em style="color: magenta">pool de connexion</em>:
```js
const pg = require('pg'),
    config = require('./../config');
const pool = new pg.Pool({
    user: config.database.user, //env var: PGUSER
    database: config.database.database, //env var: PGDATABASE
    password: config.database.password, //env var: PGPASSWORD
    host: config.database.host, // Server
    port: config.database.port, //env var: PGPORT
    max: config.database.poolMax //number of connections to use in connection pool
});
pool.on('error', (err, client) => {
    console.error(`Unexpected error on idle client: ${err}`);
});

module.exports = pool;
```
<nsv>
<em style="color: blue">Création de la fonction QueryBuilder</em> <br/>
Cette fonction a pour but de <em style="color: magenta">récupérer le pool de connexion</em> et d'<em style="color: magenta">exécuter la requête</em>.
Cette fonction est disponible avec les <em style="color: green">callback</em>, <em style="color: green">promise</em> et <em style="color: green">stream</em>.
<em style="color: red">Copier/coller</em> le code ci-dessous dans le fichier <em style="color: red">queryBuilder.js</em>   
```js
"use strict";
const QueryStream = require('pg-query-stream');

const pool = require('./../database/connection');

pool.on('error', (err) => {
    console.log('idle client error', err.message, err.stack);
});

const queryBuilderCb = (queryText, values, cb) => {
    pool.connect((err, client, done) => {
        if (err) {
            done();
            console.log(err);
            console.log(`Connection released`);
            cb(err, null);
        } else {
            client.query(queryText, values, (err, result) => {
                done();
                console.log(`Connection released`);
                cb(err, result);
            });
        }
    });
};
const queryBuilderStream = (queryText, values) => {
    return new Promise((resolve, reject) => {
        pool.connect()
            .then(client => {
                const query = new QueryStream(queryText, values);
                const stream = client.query(query);
                client.release();
                console.log(`Connection released`);
                resolve(stream);
            })
            .catch(error => {
                console.log(error);
                reject({ error: error, code: 500 });
            });
    });
};

const queryBuilderPromise = (queryText, values) => {
    return new Promise((resolve, reject) => {
        pool.connect()
            .then(client => {
                return client.query(queryText, values)
                    .then(result => {
                        client.release();
                        console.log(`Connection released`);
                        resolve(result);
                    })
                    .catch(err => {
                        client.release();
                        console.log(`Connection released`);
                        console.log(err.stack);
                        reject({ error: err, code: 400 });
                    });
            })
            .catch(error => {
                console.log(error);
                reject({ error: error, code: 500 });
            });
    });
};

module.exports = {
    queryBuilderCb: queryBuilderCb,
    queryBuilderPromise: queryBuilderPromise,
    queryBuilderStream: queryBuilderStream
}
```

<nsv>
<em style="color: blue">Création d'une simple API(1/5)</em> <br/>
Dans le fichier <em style="color: red">/app/routes/simple-api/sample-apiService.js</em>:
* On va créer la requêtes sql qui va nous permettre de retourner un customers : <em style="color: magenta">SELECT * FROM customers WHERE customer_id = $1</em>.
* Ensuite faire appel à la fonction <em style="color: green">queryBuilderPromise</em> avec les bons paramètres.

```js
'use strict';
const db = require('./../../database/queryBuilder');

module.exports.getOne = (id_customer) => {
    let sql = `SELECT * FROM customers where customer_id = $1`,
        values = id_customer;
    return db.queryBuilderPromise(sql, values);
};
```
<nsv>
<em style="color: blue">Création d'une simple API(2/5)</em> <br/>
* <em style="color: red">Création</em> d'une <em style="color: green">route</em> pour <em style="color: red">récupérer</em> les données:

```js
const express = require('express'),
    HttpStatus = require('http-status-codes'),
    router = express.Router();

const customersService = require('./sample-apiService');

router.get('/customers/:id', (req, res) => {
    let customer_id = [req.params.id];
    //put the custoemrsService here
});

module.exports = router
```

<nsv>
<em style="color: blue">Création d'une simple API(3/5)</em> <br/>
* Utilisation du <em style="color: red">customersService</em> avec la méthode adéquate(ici getOne()): 

```js
    customersService.getOne(customer_id)
        .then((result) => {
            //put success code here
        })
        .catch((error) => {
            //put erreur code here
         });
```

<nsv>
<em style="color: blue">Création d'une simple API(4/5)</em> <br/>
Pour gérer les cas <em style="color: red">erreurs</em>  et les cas de <em style="color: red">réussite</em> on va faire appel à <em style="color: green">Express</em>:<br/>
* <em style="color: magenta">Premier cas(erreur)(1):</em><br/>
 
```js
    if (error.code === 400) {
        res.sendStatus(HttpStatus.BAD_REQUEST);
        return;
    } else {
        res.sendStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        return;
    }     
```
<nsv>
<em style="color: blue">Création d'une simple API(5/5)</em> <br/>
* <em style="color: magenta">Deuxième cas(succès)(2):</em><br/>

```js
    let results = result.rows;
    if (result.rowCount === 0) {
        res.sendStatus(HttpStatus.NOT_FOUND);
    } else {
        res.status(HttpStatus.OK).send(results);
    }
```

<nsv>
<em style="color: blue">Ajout des tests unitaires</em> <br/>
Dans le fichier <em style="color: red">/app/routes/simple-api/simple-apiSpec</em> on va rajouter les tests unitaires:

```js
"use strict";
const request = require('request'),
    HttpStatus = require('http-status-codes'),
    server = require('./../../../bin/www');

jasmine.getEnv().defaultTimeoutInterval = 500;

const endpoint = 'http://localhost:3000/v1/customers',
    customer_id = 25;

describe("customers", () => {
    describe(' / GET ONE', () => {
        it('should returns status code 200', (done) => {
            request.get(`${endpoint}/${customer_id}`, (error, response) => {
                expect(response.statusCode).toEqual(HttpStatus.OK);
                done();
            });
        });
    });
});
``` 

<nsv>
<em style="color: blue">Intégrer la route à l'application</em> <br/>
Dans le fichier <em style="color: red">simple-apiRouter.js</em> on a utilisé le <em style="color: magenta">router</em> d'Express qu'on va <em style="color: red">monter</em> jusqu'au <em style="color: green">point d'entrée</em> de l'application <em style="color: red">app.js</em>, puis l'<em style="color: green">intégrer</em> à celle-ci:

```js
const simple_api = require('./app/routes/simple-api/simple-apiRouter');
app.use('/v1', simple_api);
```
Executer:
```bash 
NODEJS_CONF_PATH_APP=. npm start
```