#### <em style="color: red">Enoncé de TP(1/3)</em>
* <a href="#/28">Cloner le starter-kit : <em style="color: green">git clone git@gitlab.dev.fr.auchan.com:id-starters/starter-expressjs.git</em></a>
* <a href="#/29">Créer une <em style="color: blue">connexion</em> à une <em style="color: magenta">BDD postgres</em>(externaliser la conf, créer le pool,...).</a>
* <a href="#/30">Copier/Coller la fonction <em style="color: magenta">queryBuilder.js</em> en cliquant ici (app/database/queryBuiler.js).</a>

<nsv>
#### <em style="color: red">Enoncé de TP(2/3)</em>
* <a href="#/31">En utilisant le <em style="color: green">router</em> créer un <em style="color: magenta">service</em> HTTP <em style="color: green">(CRUD)</em> pour la table <em style="color: magenta">orders</em>:</a><br/>
<em style="color: blue">GET(getAll)</em>: <em style="color: magenta">récupérer</em> tous les enregistrements.<br/>
<em style="color: blue">GET(getOne)</em>: <em style="color: magenta">récupérer</em> un enregistrement(verifier si l'id est un integer).<br/>
<em style="color: blue">POST</em>: <em style="color: magenta">insérer</em> des données qu'on va récupérer du body<em style="color: green">(req.body)</em>.<br/>
<em style="color: blue">PUT</em>: <em style="color: magenta">mettre à jour</em> un enregistrement en récuperant l'<em style="color: red">ID</em> dans les paramètres<em style="color: green">(req.params)</em>.<br/>
<em style="color: blue">DELETE</em>: <em style="color: red">supprimer </em> un enregistrement en récupérant l'<em style="color: red">ID</em> dans la query de la requête (verifier si l'id est un integer)<em style="color: green">(req.query)</em>.

<nsv>
#### <em style="color: red">Enoncé de TP(3/3)</em>
* <a href="#/32">Dans <em style="color: yrllow">app.js</em> <em style="color: magenta">importer</em> votre route.</a>
* <a href="#/23/2">Ajouter la documentation swagger (swagger-jsdoc) adéquate à vos routes</a>
* <a href="#/33">Réaliser les <em style="color: blue">tests unitaires</em> sur les méthodes <em style="color: magenta">GET (<em style="color: green">sur le contenu du Body</em>)</em> et <em style="color: magenta">POST(<em style="color: green">sur le code statue de la requête</em>)</em>.</a>

<nsv>
#### <em style="color: red">La table orders est constituée de:</em>

| <em style="color: blue">Champ</em>             |   <em style="color: blue">Type</em>    |
|------------------------------------------------|:--------------------------------------:|
| <em style="color: #01B0F0">order_id</em>       | integer NOT NULL                       |
| <em style="color: #01B0F0">customer_id</em>    | integer                                |
| <em style="color: #01B0F0">order_total</em>    | integer                                |
| <em style="color: #01B0F0">order_timestamp</em>| date                                   |
| <em style="color: #01B0F0">user_id</em>        | integer                                |

<nsh>
# <em style="color: blue">SOLUTION</em>

<nsh>
<em style="color: blue">Cloner le starter-kit</em><br/>

```bash
git clone git@gitlab.dev.fr.auchan.com:id-starters/starter-expressjs.git
cd starter-expressjs
npm install 
NODEJS_CONF_PATH_APPNAME=. npm start
```
<a href="#/26">retour arrière</a>

<nsh>
<em style="color: blue">Création de la connexion(1/3)</em><br/>
La <em style="color: red">connexion</em> à la base se fait en  <em style="color: magenta">trois étapes</em>:
* <em style="color: green">Externaliser</em> les valeurs des informations de connexion dans le <em style="color: red">config.properties</em>.
```bash
DB_USER=postgres
DB_DATABASE=express
DB_PASSWORD=auchan
DB_HOST=10.155.13.166
DB_PORT=5432
DB_POOL_MAX=18
```
<a href="#/26">retour arrière</a>
<nsv>
<em style="color: blue">Création de la connexion(2/3)</em><br/>
* Déclarer ces valeurs dans le fichier <em style="color: red">config.js</em> comme <em style="color: magenta">variables d'environnement</em>. 

```js
const dotenv = require('dotenv');
dotenv.config({ path: process.env.NODEJS_CONF_PATH_APP + '/config.properties' });
console.log(process.env.DB_USER)
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
};
```
<a href="#/26">retour arrière</a>
<nsv>
<em style="color: blue">Création de la connexion(3/3)</em><br/>
* Dans le fichier <em style="color: red">connection.js</em> <em style="color: magenta">importer</em>  le fichier <em style="color: red">config.js</em> et <em style="color: green">créer le pool</em> .

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
<a href="#/26">retour arrière</a>

<nsh>
Dans le dossier (app/database/) créer un fichier <em style="color: red">queryBuilder.js</em> ayant le code suivant:

```js
"use strict";
const QueryStream = require('pg-query-stream');

const pool = require('./../database/connection'),
    logger = require('./../utils/logger'),
    constError = require('./../utils/constantsError');

pool.on('error', (err) => {
    // if an error is encountered by a client while it sits idle in the pool
    // the pool itself will emit an error event with both the error and
    // the client which emitted the original error
    // this is a rare occurrence but can happen if there is a network partition
    // between your application and the database, the database restarts, etc.
    // and so you might want to handle it and at least log it out
    logger.error('idle client error', err.message, err.stack);
});

const queryBuilder = (queryText, values, cb) => {
    pool.connect((err, client, done) => {
        if (err) {
            done();
            logger.error(err);
            logger.info(`Connection released`);
            cb(err, null);
        } else {
            client.query(queryText, values, (err, result) => {
                done();
                logger.info(`Connection released`);
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
                logger.info(`Connection released`);
                resolve(stream);
            })
            .catch(error => {
                logger.error(error);
                reject({ error: error, code: constError.INTERNAL_ERROR });
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
                        logger.info(`Connection released`);
                        resolve(result);
                    })
                    .catch(err => {
                        client.release();
                        logger.info(`Connection released`);
                        logger.error(err.stack);
                        reject({ error: err, code: constError.BAD_REQUEST });
                    });
            })
            .catch(error => {
                logger.error(error);
                reject({ error: error, code: constError.INTERNAL_ERROR });
            });
    });
};

module.exports = {
    queryBuilder: queryBuilder,
    queryBuilderPromise: queryBuilderPromise,
    queryBuilderStream: queryBuilderStream
}
```
<a href="#/26">retour arrière</a>

<nsh>
<em style="color: blue">Création du service HTTP(CRUD)(1/5)</em><br/>
 On va créer un  <em style="color: red">router express</em>, puis on va utiliser ce dernier avec les <em style="color: red">méthodes</em> suivantes:
* <em style="color: magenta">GETone</em>
* <em style="color: magenta">GETall</em>
* <em style="color: magenta">POST</em>
* <em style="color: magenta">PUT</em>
* <em style="color: magenta">DELETE</em><br/>

<a href="#/26/1">retour arrière</a>

<nsv>
<em style="color: blue">Création du service HTTP(CRUD)(2/6)</em><br/>
* <em style="color: magenta">GETone(1/2)</em>
ordersService.js

```js
'use strict';
const db = require('./../../database/queryBuilder');


module.exports.getOne = (order_id) => {
    let sql = `SELECT * from orders where order_id=$1`,
        values = order_id;
    return db.queryBuilderPromise(sql, values);
};
```
<a href="#/26/1">retour arrière</a>
<nsv>
* <em style="color: magenta">GETone(2/2)</em>
OrdersRouter.js

```js
router.get('/orders/:id', (req, res) => {
    req.checkParams("id", "The id is not an integer").isInt();
    validateResult(req, res).then(() => {
        let order_id = [req.params.id];
        ordersService.getOne(order_id)
            .then((result) => {
                httpResponse.sendResponse(res, result);
            })
            .catch((error) => {
                logger.error(error);
                httpResponse.sendError(res, error);
            });
    });
});

```
<a href="#/26/1">retour arrière</a>

<nsv>
<em style="color: blue">Création du service HTTP(CRUD)(3/6)</em><br/>
* <em style="color: magenta">GETall(1/2)</em>
ordersService.js

```js
module.exports.getAll = () => {
    let sql = `SELECT order_id, customer_id, order_total, order_timestamp, user_id FROM orders`,
        values = [];
    return db.queryBuilderPromise(sql, values);
};
```
<a href="#/26/1">retour arrière</a>
<nsv>
* <em style="color: magenta">GETall(2/2)</em>
OrdersRouter.js

```js
router.get('/orders', (req, res) => {
    ordersService.getAll()
        .then((result) => {
            res.status(HttpStatus.OK)
                .send(result.rows);
        })
        .catch((error) => {
            logger.error(error);
            httpResponse.sendError(res, error);
        });
});
```
<a href="#/26/1">retour arrière</a>

<nsv>
<em style="color: blue">Création du service HTTP(CRUD)(4/6)</em><br/>

* <em style="color: magenta">POST(1/2)</em>
OrdersService.js

```js
module.exports.insert = (order) => {
    let sql = `INSERT INTO orders (order_id , customer_id, order_total, order_timestamp, user_id)
    values ($1, $2, $3, $4, $5) RETURNING *`;
    //Get values from body
    let values = order;
    return db.queryBuilderPromise(sql, values);
};
```
<a href="#/26/1">retour arrière</a>
<nsv>
* <em style="color: magenta">POST(2/2)</em>
OrdersRouter.js

```js
router.post('/orders', (req, res) => {
    let order = [req.body.order_id, req.body.customer_id, req.body.order_total,
        req.body.order_timestamp, req.body.user_id
    ];
    ordersService.insert(order)
        .then((result) => {
            res.setHeader("order_id", result.rows[0].order_id)
            res.sendStatus(HttpStatus.CREATED);
        })
        .catch((error) => {
            logger.error(error);
            httpResponse.sendError(res, error);
        });
});

```
<a href="#/26/1">retour arrière</a>

<nsv>
<em style="color: blue">Création du service HTTP(CRUD)(5/6)</em><br/>
* <em style="color: magenta">PUT(1/2)</em>
OrdersService.js

```js
module.exports.update = (order) => {
    let sql = `UPDATE orders SET customer_id=$2, order_total=$3, order_timestamp=$4, user_id=$5
    WHERE order_id=$1`;
    let values = order;
    return db.queryBuilderPromise(sql, values);
};
```
<a href="#/26/1">retour arrière</a>
<nsv>
* <em style="color: magenta">PUT(2/2)</em>
OrdersRouter.js

```js
router.put('/orders/:id', (req, res) => {
    let orderId = req.params.id;
    //get data from body
    let order = [orderId, req.body.customer_id, req.body.order_total, req.body.order_timestamp, req.body.user_id];
    ordersService.update(order)
        .then((result) => {
            httpResponse.sendStatus(res, result, HttpStatus.CREATED);
        })
        .catch((error) => {
            logger.error(error);
            httpResponse.sendError(res, error);
        });
});
```
<a href="#/26/1">retour arrière</a>

<nsv>
<em style="color: blue">Création du service HTTP(CRUD)(6/6)</em><br/>
* <em style="color: magenta">DELETE(1/2)</em>
OrdersService.js

```js
module.exports.delete = (order_id) => {
    let sql = `DELETE FROM orders WHERE order_id=$1`,
        values = order_id;
    return db.queryBuilderPromise(sql, values);
};
```
<a href="#/26/1">retour arrière</a>
<nsv>
* <em style="color: magenta">DELETE(2/2)</em>
OrdersRouter.js

```js
router.delete('/orders/:id', (req, res) => {
    req.checkParams("id", "The id is not an integer").isInt();
    validateResult(req, res).then(() => {
        let order_id = [req.params.id];
        ordersService.delete(order_id)
            .then((result) => {
                httpResponse.sendStatus(res, result, HttpStatus.NO_CONTENT);
            })
            .catch((error) => {
                logger.error(error);
                httpResponse.sendError(res, error);
            });
    });
});
```
<a href="#/26/1">retour arrière</a>

<nsh>
<em style="color: blue">Import de la route dans app.js</em><br/>
<em style="color: red">Importer la route </em> qu'on a préalablement exportée:

```js
const loggers = require('./app/utils/logger'),
    sampleApiRoutes = require('./app/routes/sample-api/sample-apiRouter'),
    orders = require('./app/routes/orders/ordersRouter'),
    swaggerRoutes = require('./app/routes/swagger'),
    packageJSON = require('./package');
....
app.use('/v1', orders);

```
<a href="#/26/2">retour arrière</a>

<nsh>
<em style="color: blue">Réalisation des tests unitaires(1/2)</em><br/>
* Pour la méthode <em style="color: red">GET</em> on va <em style="color: green">tester</em> le <em style="color: magenta">contenu du body</em> de la requête:

```js
describe('/GET{id}', () => {
    it('returns status code 200', (done) => {
        request.get(`${endpoint}/${order_id}`, (error, reponse, body) => {
            expect(body, { json: true }).toBe(`{
                    "success": true,
                    "data": [{
                    "order_id": 1,
                    "customer_id": 7,
                    "order_total": 1890,
                    "order_timestamp": null,
                    "user_id": 2
                    }]
                    }`);
            done();
        });
    });
});
```
<a href="#/26/2">retour arrière</a>

<nsv>
<em style="color: blue">Réalisation des tests unitaires(2/2)</em><br/>
* Pour la méthode <em style="color: red">POST</em> on va faire le même <em style="color: green">test</em> sur le <em style="color: magenta">code status</em> de la requête
, mais cette fois-ci on va <em style="color: red">rajouter le contenu du body </em>

```js
describe('orders', () => {
    describe('post /', () => {
        it('should returns status code 201', (done) => {
            request.post(endpoint, {
                    json: true,
                    body: {
                        "order_id": 13,
                        "order_timestamp": null,
                        "customer_id": 1,
                        "order_total": 2380
                    }
                },(error, response) => {
                    expect(response.statusCode).toEqual(HttpStatus.CREATED);//SERVICE_UNAVAILABLE
                    done();
                });
        });
    });
});
```
