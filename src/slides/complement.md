#### <em style="color: red">complément</em>
* Ajout d'<em style="color: #01B0F0">express validator</em>
* Developpement des APIs avec les <em style="color: magenta">promises</em> et les <em style="color: magenta">streams</em>.
* <em style="color: green">Manipulation</em> des données.

<nsv>
<em style="color: blue">Express validator(1/4)</em> <br/>
Express validator va nous permettre de valider les champs qu'on reçoit du client

```bash
npm install express-validator --save
```
Dans le fichier app.js rajouter ces lignes:

```js
const validator = require('express-validator');
...
app.use(validator());//add this line after bodyParder

```

<nsv>
<em style="color: blue">Express validator(2/4)</em> <br/>
Créer un fichier <em style="color: red">/app/utils/validator.js</em> ayant le contenu suivant:

```js
'use strict';
const validator = (req, res) =>
    new Promise((resolve) => {
        req.getValidationResult()
            .then((result) => {
                if (!result.isEmpty() && result !== undefined) {
                    res.contentType('application/json')
                        .status(400)
                        .send(JSON.stringify({
                            success: false,
                            detailed_message: result.array()
                        }));
                } else {
                    resolve();
                }
            });

    });

module.exports = validator;
```
<nsv>
<em style="color: blue">Express validator(3/4)</em> <br/>
Mettez à jour le fichier <em style="color: red">/app/routes/simple-api/sample-apiRouter.js</em>, importer le validator.js et rajouter ces lignes:

```js
//import validator.js **add this line on the top
const validateResult = require('./../../utils/validator');

//update route like this
router.get('/customers/:id', (req, res) => {
   req.checkParams("id", "The id is not an integer").isInt();
    validateResult(req, res).then(() => {
        let customer_id = [req.params.id];
        customersService.getOne(customer_id)
            .then((result) => {...})
            .catch((error)=> {...})
    });
});
```
<nsv>
<em style="color: blue">Express validator(4/4)</em> <br/>
Tester votre route: http://localhost:3000/v5/customers/4 && http://localhost:3000/v5/customers/fsd

<nsv>
<em style="color: blue">Developpement des APIs avec les promises et les streams</em> <br/>
Dans les <em style="color: red">exemples</em> suivants on va <em style="color: magenta">utiliser</em> les <em style="color: magenta">callback</em> et les <em style="color: magenta">streams</em> pour le developpement des APIs:<br/>
Rajouter <em style="color: magenta">deux dossiers</em> au dossier <em style="color: magenta">app/routes</em>:

```
customersCallback
     ├──customerRouter.js       
     └──customerService.js  
customersStream
     ├──customerRouter.js       
     └──customerService.js  
```
<nsv>
<em style="color: blue">Les callback(1/2)</em> <br/>
On va utiliser <em style="color: red">queryBuilderCb</em> pour récupérer la connexion du pool ensuite on va utiliser un <em style="color: magenta">callback</em> pour <em style="color: green">afficher les données</em>, rajouter le code suivant au fichier <em style="color: #01B0F0">customerService.js</em>:
```js
'use strict';
const db = require('./../../database/queryBuilder');

module.exports.getOne = (id_customer, cb) => {
    let sql = 'SELECT * FROM customers where customer_id = $1',
        values = id_customer;
    return db.queryBuilderCb(sql, values, cb);
};
```
<nsv>
<em style="color: blue">Les callback(2/2)</em> <br/>
Rajouter la code suivant au fichier <em style="color: #01B0F0">customerRouter.js</em>:

```js
"use strict";
const express = require('express'),
    HttpStatus = require('http-status-codes'),
    router = express.Router();

const customersServiceCb = require('./customersService');

router.get('/customers/:id', (req, res) => {
    let customer_id = [req.params.id];
    customersServiceCb.getOne(customer_id, (err, result) => {
        if (err || result.rowCount === 0) {
            console.log(err);
            const status = err ? HttpStatus.INTERNAL_SERVER_ERROR : HttpStatus.NOT_FOUND;
            res.sendStatus(status);
        } else {
            res.status(HttpStatus.OK).send(result.rows);
        }
    });
});
```

<nsv>
<em style="color: blue">Les streams(1/2)</em> <br/>
On va utiliser <em style="color: red">queryBuilderStream</em> pour récupérer la connexion du pool ensuite on va utiliser les <em style="color: magenta">streams</em> pour <em style="color: green">afficher les données</em>, rajouter le code suivant au fichier <em style="color: #01B0F0">customerService.js</em>:
```js
'use strict';
const db = require('./../../database/queryBuilder');

module.exports.getOne = (id_customer) => {
    let sql = 'SELECT * FROM customers where customer_id = $1',
        values = id_customer;
    return db.queryBuilderStream(sql, values);
};

```

<nsv>
<em style="color: blue">Les streams(2/2)</em> <br/>
Rajouter la code suivant au fichier <em style="color: #01B0F0">customerRouter.js</em>:
```js
"use strict";
const express = require('express'),
    HttpStatus = require('http-status-codes'),
    router = express.Router();

const customersServiceStream = require('./customersService');

router.get('/customers/:id', (req, res) => {
    let customer_id = [req.params.id],
        results = [];
    customersServiceStream.getOne(customer_id)
        .then((stream) => {
            stream.on('data', (x) => {
                results.push(x);
            });
            stream.on('error', (err) => {
                console.log(err);
                res.sendStatus(HttpStatus.BAD_REQUEST);
            });
            stream.on('end', () => {
                res.setHeader('Content-Type', 'application/json');
                res.status(HttpStatus.OK).send(results);
            });
        })
        .catch((error) => {
            console.log(error);
            res.sendStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        });
});

module.exports = router;
```

<nsv>
<em style="color: blue">Manipulation des données(1/3)</em> <br/>
* Manipulation de tableaux: 

```js
array.forEach(), 
for (const [index, elem] of array.entries()),
...
```
* Manipulation d'objets: 

```js
obj.forEach(), 
for (const key in obj),
... 
```


<nsv>
<em style="color: blue">Manipulation de données(2/3)</em> <br/>
Reprener une de vos <em style="color: magenta">routes précédente</em> et <em style="color: red">avant</em> de renvoyer le résultat à l'utlisateur <em style="color: green">mettre à jour</em> la <em style="color: green">réponse</em> pour  renvoyer le nom et prenom en <em style="color: red">majuscule</em>:<br/>

* <em style="color: #01B0F0">Première méthode:</em> 

```js
results = results.slice(0, 6);
results.map(i => {
    Object.assign(i, {
        cust_first_name: i.cust_first_name.toUpperCase(),
        cust_last_name: i.cust_last_name.toUpperCase(),

    });
            
```

<nsv>
<em style="color: blue">Manipulation de données(3/3)</em> <br/>

* <em style="color: #01B0F0">Deuxième méthode:</em> <br/>

```js
const totalResult = results.length = 7
for (var i = 0; i < totalResult; i++) {
    let newData = {
        cust_first_name: results[i].cust_first_name.toUpperCase(),
        cust_last_name: results[i].cust_city.toUpperCase()
    };
    const newResult = Object.assign(results[i], newData);
    console.log(newResult);
```
<em style="color: red">Le résultat:</em> 

```json
{"cust_first_name":"JOHN","cust_last_name":"DULLES","cust_street_adress2":"45020 Aviation Drive",...}

```

<nsv>
<em style="color: blue">Quelques méthodes importantes(1/2)</em> <br/>

| <em style="color: red">Méthode</em>              |   <em style="color: red">Description</em>                 |
|--------------------------------------------------|:---------------------------------------------------------:|
| <em style="color: #01B0F0"> CONCAT()</em>        | Fusionner deux tableaux                                   |
| <em style="color: #01B0F0">SLICE()</em>          | Sélectionner les éléments à retourner                     |
| <em style="color: #01B0F0">SHIFT()</em>          | Supprimer le premier élément du tableau                   |
| <em style="color: #01B0F0">PUSH()</em>           | Rajouter un ou plusieurs éléments à la fin d'un tableau   |
| <em style="color: #01B0F0">POP()</em>            | Retirer le dernier élément tu tableau                     |

<nsv>
<em style="color: blue">Quelques méthodes importantes(2/2)</em> <br/>

| <em style="color: red">Méthode</em>              |   <em style="color: red">Description</em>                                     |
|--------------------------------------------------|:-----------------------------------------------------------------------------:| 
| <em style="color: #01B0F0">Object.create()</em>  |  Crée un nouvel objet                                                         |
| <em style="color: #01B0F0">Object.entries()</em> | Renvoie un tableau contenant des paires [clé, valeur] de l'objet              |
| <em style="color: #01B0F0">Object.is()</em>      | Détermine si deux valeurs sont les mêmes                                      |
| <em style="color: #01B0F0">Object.assign()</em>  | copie les propriétés énumérables de un ou plusieurs objets sur un objet cible |
