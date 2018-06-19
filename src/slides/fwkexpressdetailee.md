#### <em style="color: red">Explication détaillée de l'exemple</em>
Dans cette partie on va voir le fonctionnement en détail de chaque partie du Framework Express
<nsv>
<em style="color: blue">Express et les middlewares(1/3)</em> <br/>
Express est un <em style="color: #01B0F0">framework</em> basé sur le concept de <em style="color: #01B0F0">middlewares</em>. Ce sont des <em style="color: green">petits morceaux </em> d'application qui rendent chacun un service spécifique. Vous pouvez <em style="color: green">charger</em> uniquement les <em style="color: #01B0F0">middlewares</em> dont vous avez <em style="color: green">besoin</em>.<br/>

<nsv>
<em style="color: blue">Express et les middlewares(2/3)</em> <br/>
Les middlewares les <em style="color: magenta">plus utilisés</em> sont:<br/>

| <em style="color: red">middlewares</em>           |           <em style="color: red">Description</em>                                              |
|---------------------------------------------------|-----------------------------------------------------------------------------------------------:|
| <em style="color: #01B0F0">compression</em>       | permet la compression <em style="color: green">gzip</em>.                                      |
| <em style="color: #01B0F0">cookie-parser</em>     | permet de <em style="color: green">manipuler</em> les <em style="color: blue">cookies</em>   |
| <em style="color: #01B0F0">express-session</em>   | gérer des <em style="color: green">informations</em> de <em style="color: blue">session</em> |
| <em style="color: #01B0F0">body-parser</em>       | analyse le <em style="color: green">corps</em> de la <em style="color: blue">demande</em>     |
| <em style="color: #01B0F0">express-validator</em> | valider les <em style="color: green">champs</em> d'un <em style="color: blue">form</em>      |

<nsv>
<em style="color: blue">Express et les middlewares(3/3)</em> <br/>
Depuis le <em style="color: green">gestionnaire de paquets </em>NPM, télécharger <em style="color: red">body-parser</em>, ce dernier va nous permettre de <em style="color: #01B0F0">gérer les données postées</em> par un formulaire<em style="color: magenta">(req.body)</em>.

```bash
npm install body-parser --save
```
Dans le fichier <em style="color: red">app.js</em> <em style="color: green">rajouter</em>  les lignes suivantes(à la fin de la declaration des dépendances):

```js
const bodyParser = require('body-parser');
// parse application/json 
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

```

<nsv>
<em style="color: blue">Routage de base(1/5)</em> <br/>
Le <em style="color: green">routage</em> fait référence à la <em style="color: green">définition</em> de <em style="color: green">points finaux</em>  d’application <em style="color: #01B0F0">(URI) </em> et à la façon dont ils <em style="color: #01B0F0">répondent</em> aux <em style="color: green">demandes</em> client.<br/>

<nsv>
<em style="color: blue">Routage de base(2/5)</em> <br/>
La <em style="color: green">définition</em> de la route utilise la <em style="color: #01B0F0">structure</em> suivante :

```js
app.METHOD(PATH, HANDLER)
```
<em style="color: red">Où:</em><br/>
<em style="color: #01B0F0">app</em> est une instance d’express.<br/>
<em style="color: #01B0F0">METHOD</em> est une méthode de demande HTTP.<br/>
<em style="color: #01B0F0">PATH</em> est un chemin sur le serveur.<br/>
<em style="color: #01B0F0">HANDLER</em> est la fonction exécutée lorsque la route est mise en correspondance.<br/>

<nsv>
<em style="color: blue">Routage de base(3/5)</em> <br/>
![](./src/images/express.PNG)

<nsv>
<em style="color: blue">Routage de base(4/5)</em> <br/>
On peut aussi utiliser la classe <em style="color: red">express.Router</em>,  pour <em style="color: red">créer</em> des <em style="color: green">gestionnaires</em> de route <em style="color: green">modulaires</em> et pouvant être <em style="color: red">montés</em>, créer un fichier 
<em style="color: red">router.js</em> ayant le code suivant:

```js
const express = require('express'),
    router = express.Router();

//create router
router.get('/hello', (req, res, next)=>{
    console.log(`Hello node with fwk express.js using express.Router`);
});
module.exports = router;

```
<nsv>
<em style="color: blue">Routage de base(4/5)</em> <br/>
Dans votre fichier <em style="color: red">app.js</em> <em style="color: green">importer</em> le <em style="color: red">router.js</em> puis on va demander à express de <em style="color: #01B0F0">l'utiliser</em>.

```js

const router = require('./path-to/router');
...
app.use('/v1', router);

```
Si votre serveur est lancé navigez sur cette url:
http://localhost:3000/v1/hello

<nsv>
<em style="color: blue">Méthodes HTTP</em> <br/>
Les méthodes HTTP définissent les opérations : <em style="color: red">Create</em>, <em style="color: red">Read</em>, <em style="color: red">Update</em> et <em style="color: red">Delete</em> <em style="color: #01B0F0">(CRUD)</em>, ces opérations sur les ressources sont effectuées par des méthodes <em style="color: green">HTTP</em> <em style="color: magenta">POST</em>, <em style="color: magenta">GET</em>, <em style="color: magenta">PUT</em> et <em style="color: magenta">DELETE</em> respectivement.

```js
app.get('/', (req, res, next)=> {
    console.log(`Hello node with fwk express.js`);
});
app.post('/', (req, res, next)=> {
    console.log(`At this point we will insert data`);
});
//or
router.get('/', (req, res, next)=> {
    console.log(`Hello node with fwk express.js`);
}); 
router.post('/', (req, res, next)=> {
    console.log(`At this point we will insert data`);
});
```

<nsv>
<em style="color: blue">Request Object(1/6)</em> <br/>
L'objet <em style="color: red">req</em> représente la requête HTTP et <em style="color: green">possède des propriétés</em> pour la demande de requête (query string, parameters, body, HTTP headers, etc).

<nsv>
<em style="color: blue">Request Object(2/6)</em> <br/>
Voici la liste des quelques <em style="color: magenta">propriétés</em> associées à l'objet de <em style="color: magenta">request</em>.


| <em style="color: red">Propriétés</em>            |           <em style="color: red">Description</em>                                              |
|---------------------------------------------------|-----------------------------------------------------------------------------------------------:|
| <em style="color: #01B0F0">req.app </em>          | La référence à l'instance de l'application                                                     |
| <em style="color: #01B0F0">req.url</em>           | URL de la route                                                                                |
| <em style="color: #01B0F0">req.ip</em>            | L'adresse IP de la demande.                                                                    |
| <em style="color: #01B0F0">req.body</em>          | Paires clé-valeur des données fournies dans le corps de la demande                             |


<nsv>

| <em style="color: red">Propriétés</em>            |           <em style="color: red">Description</em>                                              |
|---------------------------------------------------|-----------------------------------------------------------------------------------------------:|
| <em style="color: #01B0F0">req.params </em>       | L'objet contenant des propriétés mappées aux paramètres de la route appelée                    |
| <em style="color: #01B0F0">req.query</em>         | L'objet contenant une propriété pour chaque paramètre de chaîne de requête                     |
| <em style="color: #01B0F0">req.hostname</em>      | Le nom  d'hôte                                                                                 |
| <em style="color: #01B0F0">req.protocol </em>     | Le protocole de la requête                                                                     |

<nsv>
<em style="color: blue">Request Object(3/6)</em> <br/>
Dans le fichier <em style="color: red">router.js</em> rajouter ces exemples d'utilisations:<br/>
* <em style="color: magenta">req.params</em>
```js
router.get('/users/:id', (req, res, nex) => {
    let userId = req.params.id;
    //send result
    res.status(200).send(`The user id is: ${userId}`)
});
```
L'url appelante est:
http://localhost:3000/users/5

<nsv>
<em style="color: blue">Request Object(4/6)</em> <br/>
* <em style="color: magenta">req.body(1/2)</em><br/>
```js
router.post('/users', (req, res, next)=>{
    let firstname = req.body.firstname;
    let lastname = req.body.lastname; 
    //send result
    res.status(201).send(`From the body i receive: Firstname: ${firstname} && Lastname: ${lastname}`)
})
```
<nsv>
<em style="color: blue">Request Object(5/6)</em> <br/>
* <em style="color: magenta">req.body(2/2)</em><br/>
Pour <em style="color: green">exécuter</em> la méthode HTTP <em style="color: magenta">POST</em> il faut utiliseur le logiciel <em style="color: red">Postman</em><br/>
  1. Sélectionner la méthode HTTP <em style="color: red">POST</em>, indiquer <em style="color: #01B0F0">l'url</em>:  http://localhost:3000/users/ <br/>
  2. Sélectionner l'onglet <em style="color: red">Body</em> et copier le <em style="color: magenta">JSON</em> :<br/>
```json
{
    "firstname": "Nodejs",
    "lastname": "Expressjs"
}
```

<nsv>
<em style="color: blue">Request Object(6/6)</em> <br/>
* <em style="color: magenta">req.query </em><br/>
```js
app.put('/users?', (req, res, next) => {
    let userId = req.query.id;
    let userName = req.query.name;
    //send response
    res.status(201).send(`The user is: ${userName} with id=${userId}`)
});
```
L'url appelante est:
http://localhost:3000/users?id=xfr6195001&name=samir <br/>

<nsv>
<em style="color: blue">Response Object(1/2)</em> <br/>
L'objet <em style="color: red">res</em> représente la <em style="color: green">réponse</em> HTTP qu'une application Express <em style="color: magenta">envoie</em> lorsqu'elle <em style="color: green">reçoit</em> une <em style="color: magenta">demande</em> de requête HTTP.

<nsv>
<em style="color: blue">Response Object(2/2)</em> <br/>
Voici la liste des quelques <em style="color: magenta">propriétés</em> associées à l'objet de <em style="color: magenta">response</em>.


| <em style="color: red">Propriétés</em>            |           <em style="color: red">Description</em>                                              |
|---------------------------------------------------|-----------------------------------------------------------------------------------------------:|
| <em style="color: #01B0F0">res.download()</em>    | Vous invite à télécharger un fichier                                                           |
| <em style="color: #01B0F0">res.end()</em>         | Met fin au processus de réponse                                                                |
| <em style="color: #01B0F0">res.json()</em>        | Envoie une réponse JSON                                                                        |
| <em style="color: #01B0F0">res.jsonp()</em>       | Envoie une réponse JSON avec une prise en charge JSONP.                                        |
| <em style="color: #01B0F0">res.redirect()</em>    | Redirige une demande                                                                           |


<nsv>
| <em style="color: red">Propriétés</em>            |           <em style="color: red">Description</em>                                              |
|---------------------------------------------------|-----------------------------------------------------------------------------------------------:|
| <em style="color: #01B0F0">res.render()</em>      | Génère un modèle de vue.                                                                       |
| <em style="color: #01B0F0">res.send()</em>        | Envoie une réponse de divers types                                                             |
| <em style="color: #01B0F0">res.sendFile()</em>    | 	Envoie une réponse sous forme de flux d’octets                                               |
| <em style="color: #01B0F0">res.sendStatus()</em>  | Définit le code de statut de réponse et envoie sa représentation sous forme de chaîne comme corps de réponse |
 

<nsv>
<em style="color: blue">Servir des fichiers statiques(1/2)</em> <br/>
Express fournit un middleware intégré <em style="color: red">express.static</em> pour servir des fichiers statiques, tels que les images, CSS, JavaScript, etc.<br/>
Rajouter la ligne suivante au fichier <em style="color: red">app.js</em>   
```js
app.use(express.static('public'));
```

<nsv>
<em style="color: blue">Servir des fichiers statiques(2/2)</em> <br/>
Créer cette <em style="color: green">arborescence</em> à la racine du projet: <em style="color: red">/public/images/</em>, puis <em style="color: green">mettez</em> une image à l'interieur du dossier images.

Maintenant, <em style="color: red">lancez</em> votre application, puis appeler l'URL ci-dessous:

```bash
node app.js
```
http://localhost:3000/images/express.jpg