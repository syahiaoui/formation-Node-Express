#### <em style="color: red">Les promises</em>
L'objet <em style="color: #01B0F0">Promise</em> est utilisé pour réaliser des <em style="color: #01B0F0">traitements</em> de façon <em style="color: blue">asynchrone</em>. Une Promise représente une <em style="color: green">valeur</em> qui peut être disponible <em style="color: magenta">maintenant</em>, dans le <em style="color: magenta">futur</em> voire <em style="color: magenta">jamais</em>.

<nsv>
<em style="color: blue">États d'une Promise</em> <br/>
Une Promise est dans un <em style="color: red">état</em>, et un <em style="color: red">seul</em>. Les <em style="color: #FF5B2B">états possibles</em> sont : 
* <em style="color: #01B0F0">pending</em><em style="color: magenta">(en attente)</em>: état <em style="color: green">initial</em>, la promesse n'est <em style="color: #96CA2D">ni remplie</em>, <em style="color: #96CA2D">ni rompue</em>.
* <em style="color: #01B0F0">fulfilled</em><em style="color: magenta">(remplie)</em>:  l'opération a <em style="color: green">réussi</em>.
* <em style="color: #01B0F0">rejected</em><em style="color: magenta">(rompue)</em>: l'opération a <em style="color: green">échoué</em>.
* <em style="color: #01B0F0">settled</em><em style="color: magenta">(acquittée)</em>: la promise est <em style="color: green">remplie </em><em style="color: red">ou</em>  <em style="color: green">rompue</em> mais elle <em style="color: #96CA2D">n'est </em> plus en <em style="color: #96CA2D">en attente</em>.

<nsv>
<em style="color: blue">Promise en image</em> <br/>
![](./src/images/p1.PNG)


<nsv>
<em style="color: blue">Créer une Promise</em> <br/>
La <em style="color: red">fonction</em> suivante <em style="color: green">renvoie</em> un <em style="color: green">résultat</em> de manière <em style="color: magentas">asynchrone</em>, via une <em style="color: red">promise</em>:
```js
const asyncFunc = return new Promise(
         (resolve, reject) => {
            ···
            resolve(result);
            ···
            reject(error);
        });
}
```

<nsv>
<em style="color: blue">Consommer une Promise</em> <br/>
Vous appelez <em style="color: red">asyncFunc()</em>comme suit:

```js
asyncFunc()
.then(result => { ··· })
.catch(error => { ··· });

```
<nsv>
<em style="color: blue">Lire un fichier avec les promises(1/4)</em> <br/>
Précédement on a vu comment lire un fichier en utilisant les <em style="color: green">callbacks</em> et les <em style="color: green">streams</em>, dans cette partie on va voir comment <em style="color: red">créer</em> et <em style="color: red">consommer</em> une <em style="color: magenta ">promise</em> pour lire un fichier.

<nsv>
<em style="color: blue">Lire un fichier avec les promises(2/4)</em> <br/>
* Créer un fichier <em style="color: red">promise.js</em>(ajouter les <em style="color: green">require</em> requis).
* Ensuite créer la fonction <em style="color: red">getData</em> ayant le code suivant:

```js
const getData = (dirName, type) =>
    new Promise((resolve, reject) => {
        fs.readdir(dirName, type, (err, data) => {
            if (err) {
                reject(err);
            } else {
                resolve(data);
            }
        });
    });

```

<nsv>
<em style="color: blue">Lire un fichier avec les promises(3/4)</em> <br/>
* Créer une <em style="color: red">route</em> avec <em style="color: green">express</em> et faites un <em style="color: red">appel</em> à la <em style="color: magenta">fonction</em> précédement crée:

```js
app.get('/file', (req, res) => {
    let dirName = 'public/images',
        type = 'utf8';
    //consume promise
    getData(dirName, type)
        .then((data) => {
            res.send(data);
        })
        .catch((error) => {
            console.log(error)
            res.send("Error when executing the promise");
        });
});
```

<nsv>
<em style="color: blue">Lire un fichier avec les promises(4/4)</em> <br/>
Avant d'<em style="color: red">exécuter</em> rajouter le <em style="color: green">serveur</em>:

```js

app.listen(3000, () => {
    console.log('App listening on port 3000!');
});
```
Maintenant, exécutez le fichier <em style="color: red">promise.js</em>  pour voir le résultat:

```bash
node promise.js
```
Pour <em style="color: magenta">visualiser le résultat</em> aller sur l'url:<br/>
http://localhost:3000

<nsv>
<em style="color: blue">Lire un fichier en utilisant promisify(1)</em> <br/>
On peut lire un fichier en utilisant la fonction <em style="color: green">promisify</em> disponible dans le module <em style="color: red">util</em> 

```js
const fs = require('fs'),
    util = require('util');
//promesify readFile function
const readFilePromise = util.promisify(fs.readFile);

readFilePromise('./test.txt')
    .then((result) => console.log(result.toString()))
    .catch((error) => console.log(error));
```

<nsv>
<em style="color: blue">Lire un fichier en utilisant promisify(2)</em> <br/>
A partir de la version <em style="color: red">7.6.X</em> de Node.js, on peut utiliser <em style="color: green">async/await</em> pour <em style="color: green">consommer</em> une promise.

```js
const processFile = async () => {
    try {
        let data = await readFilePromise('./test.txt');
        console.log(data.toString());
    } catch (error) {
        console.error(error)
    }
}
processFile();
```
*** <em style="color: red">Remarque</em> *** <br/>
Le mor clé <em style="color: #01B0F0">await</em> est utilisé uniquement dans une fonction précédée par le mot <em style="color: green">async</em>.