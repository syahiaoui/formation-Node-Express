#### <em style="color: red">Première application Node.js</em>
Une application Node.js se compose de <em style="color: green">trois parties</em> importantes:<br/>
<em style="color: blue">1. Importer les modules nécessaires</em><br/>
Nous utilisons la directive <em style="color: red">require</em> pour charger les modules Node.js.<br/>
Dans le même  répertoire créer un fichier <em style="color: green">main.js</em> 

```js
//import required module
const http = require("http");

```
<nsv>

<em style="color: blue">2. Création d'un serveur</em> <br/>
Nous utiliserons la méthode <em style="color: red">http.createServer()</em> pour créer un serveur qui écoutera les requêtes du client.

```js
//create server and send response
http.createServer((request, response)=> {

   // Send the HTTP header 
   // HTTP Status: 200 : OK
   // Content Type: text/plain
   response.writeHead(200, {'Content-Type': 'text/plain'});
   
   // Send the response body as "Hello World"
   response.end('Hello World\n');
}).listen(3000);

// Console will print the message
console.log('Server running at http://127.0.0.1:3000/');
```

<nsv>
<em style="color: blue">3. Lire la demande et retourner la réponse</em> <br/>
Le serveur lit la demande HTTP faite par le client et lui retourne la réponse.

* Exécutez maintenant le <em style="color: red">main.js</em> pour démarrer le serveur comme suit:

```bash
node main.js
```

* Sur votre navigateur appelez cette <em style="color: red">URL</em>:
http://127.0.0.1:3000/

