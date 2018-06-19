#### <em style="color: red">Express</em>
Express est une infrastructure d'applications Web Node.js minimaliste et flexible qui fournit un ensemble de fonctionnalités robustes pour les applications Web et mobiles.<br/>
![](./src/images/express1.png)


<nsh>
#### <em style="color: red">Installation</em>
<em style="color: green">Créer</em> un <em style="color: #01B0F0">répertoire</em> pour héberger votre application, puis <em style="color: green">initialiser</em> le <em style="color: #01B0F0">package.json</em>, à la fin <em style="color: green">installer </em><em style="color: #01B0F0">express</em>:

```bash
mkdir applicationExpressjs
cd applicationExpressjs
npm init 
npm install --save express
```

<nsv>
#### <em style="color: red">Premier exemple(1/3)</em>
Dans cette <em style="color: green">exemple</em> on va créer une <em style="color: #01B0F0">application</em> Express <em style="color: #01B0F0">très simple</em> qui démarre un <em style="color: blue">serveur</em> qui écoute sur le port <em style="color: blue">3000</em> :
* Cette application <em style="color: green">répond</em> avec <em style="color: magenta">Hello World!</em>, pour les demandes à la <em style="color: blue">page d'accueil(/)</em>.<br/>
* Pour chaque <em style="color: green">autre chemin</em>, on aura la réponse <em style="color: magenta">404 Not Found</em>.

<nsv>
#### <em style="color: red">Premier exemple(2/3)</em>
Créer un fichier <em style="color: green">app.js</em> ayant le contenu suivant:
```js
const express = require('express'),
    os = require('os'),
    app = express();
//extract PORT number
const port = (process.env.PORT || '3000');

//create route
app.get('/', (req, res, next) => {
    let time = new Date();
    console.log(`${time.getHours()}:${time.getMinutes()}:${time.getSeconds()}`);
    res.status(200).send(`Hello node with fwk express.js using app instance`);

});

//create server
let server = app.listen(port, os.hostname(), () => {
    let host = server.address().address,
        port = server.address().port;
    console.log("Example app listening at http://%s:%s", host, port);
})
```
<nsv>
#### <em style="color: red">Premier exemple(3/3)</em>
Installer <em style="color: #01B0F0">pm2</em>, ce module va nous permettre de <em style="color: green">rafraîchir automatiquement</em> le serveur lors du <em style="color: magenta">changement de code</em> .
```bash
npm install -g pm2
```

Exécutez le fichier <em style="color: green">app.js</em>  pour voir le résultat:

```bash
pm2-dev app.js --auto-exit --timestamp
```
Pour <em style="color: magenta">visualiser le résultat</em> aller sur l'url:<br/>
http://localhost:3000
