#### <em style="color: red">Les callbacks</em>
Dans une <em style="color: green">application Node</em>, toute fonction <em style="color: blue">asynchrone</em> accepte un <em style="color: #01B0F0">callback</em> comme dernier paramètre et la fonction de callback elle même accepte une erreur en tant que premier paramètre. Toutes les <em style="color: green">API</em> de Node prennent <em style="color: green">nativement</em> en charge les <em style="color: magenta">callback</em>.
![](./src/images/callback-syndrome-cause.jpg)

<nsv>
<em style="color: blue">Création d'une fonction callback(1/3)</em> <br/>
Dans l'exemple ci-dessous on va voir l'intérêt d'avoir un code <em style="color: red">non bloquant</em>, le programme <em style="color: green">lit le fichier</em> et <em style="color: red">n'attend pas la fin de la lecture</em> pour <em style="color: green">procéder à l'impression du message </em>
"Programme terminé"

<nsv>
<em style="color: blue">Création d'une fonction callback(2/3)</em> <br/>
<em style="color: red">Créez</em> un fichier texte nommé <em style="color: red">input.txt</em> ayant le contenu suivant:

```text
Les grandes entreprises optent pour Node.js: Microsoft, IBM, Yahoo!, Netflix, Groupon ou encore PayPal qui, en 2013, migrait ses applications de Java vers Node.js.
```
Créez un fichier nommé <em style="color: red">myFirstCB.js</em> ayant le contenu suivant:

```js
//import require module
const fs = require("fs");

// Asynchronous read
console.log(`-->Debut execution Asynchrone`);
fs.readFile('input.txt', (err, data) => {
    if (err) {
        return console.error(err);
    }
    console.log(`Asynchronous read: ${data.toString()}`);
    console.log('-->Fin Execution Asynchrone');
});

////TODO: After you go put the code Synchronous at this level
console.log(`Programme terminé`);
```

<nsv>
<em style="color: blue">Création d'une fonction callback(3/3)</em> <br/>
Maintenant, exécutez le fichier <em style="color: red">myFirstCB.js</em>  pour voir le résultat:

```bash
node myFirstCB.js
```