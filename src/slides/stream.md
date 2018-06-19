#### <em style="color: red">Les streams</em>
Un <em style="color: red">stream</em>, permet de <em style="color: green">lire</em> et <em style="color: green">d'écrire </em>un contenu sous forme de <em style="color: red">flux</em> et de recevoir les informations sous forme de petits blocs plus digestes pour la mémoire. Dans Node.js, il existe quatre types de flux(<em style="color: magenta">Readable</em>, <em style="color: magenta">Writable</em>, <em style="color: magenta">Duplex</em>, <em style="color: magenta">Transform</em>)<br/>
![](./src/images/stream1.png)

<nsv>
<em style="color: blue">Lecture d'un stream(1/4)</em> <br/>

Chaque type de Stream est une <em style="color: red">instance</em> de <em style="color: red">EventEmitter</em> et lance plusieurs événements différents dans le temps.<br/>
<em style="color: red">Les types d'événements les plus utilisés sont:</em>
* <em style="color: green">data: </em> déclenché lorsqu'il existe des données à lire.
* <em style="color: green">end: </em> déclenché lorsqu'il n'y a plus de données à lire.
* <em style="color: green">error: </em> déclenché lorsque une erreur survient lors de la réception ou d'écriture de données.

<nsv>
<em style="color: blue">Lecture d'un stream(2/4)</em> <br/>
Les streams sont <em style="color: red">généralement</em> utilisé pour <em style="color: #96CA2D">traiter</em> les données qu'on <em style="color: green">récupère</em> depuis la <em style="color: red">base de données</em> et ensuite les <em style="color: magenta">renvoyer</em>  à l'utilisateur.

![](./src/images/stream.png)

<nsv>
<em style="color: blue">Lecture d'un stream(3/4)</em> <br/>
Reprenez le text précédent <em style="color: red">input.txt</em>, puis créer un fichier <em style="color: red">myFirstStream.js</em> ayant le contenu suivant:

```js
const fs = require('fs');
let data = ``;
// Create a readable stream
const readerStream = fs.createReadStream(`input.txt`);
// Set the encoding to be utf8.
readerStream.setEncoding('UTF8');
// Handle stream events --> data, end, and error
readerStream.on('data', (message) => {
    data += message;
});
readerStream.on('end', () => {
    console.log(data);
});
readerStream.on('error', (err) => {
    console.log(err.stack);
});
console.log(`Programme terminé`);
```
<nsv>
<em style="color: blue">Lecture d'un stream(4/4)</em> <br/>
Maintenant, exécutez le fichier <em style="color: red">myFirstStream.js</em>  pour voir le résultat:

```bash
node myFirstStream.js
```

