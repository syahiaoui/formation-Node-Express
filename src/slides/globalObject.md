#### <em style="color: red">Les objets globaux</em>

Les objets globaux de Node.js sont disponibles dans tous les modules. Il n'est pas nécessaire d'inclure ces objets dans notre application, nous pouvons les utiliser directement.

<nsv>
<em style="color: blue">1. __filename</em> <br/>

Le filename représente le <em style="color: red">chemin absolu</em>  du <em style="color: green">fichier</em> exécuté. 
* Exemple: Essayons d'imprimer la valeur du __filename

```js
console.log(path.basename(__filename));
```
Exécutez le fichier <em style="color: red">test.js</em> pour voir le résultat:
```bash
node test.js
```

<nsv>
<em style="color: blue">2. __dirname</em> <br/>
Le dirname représente le <em style="color: red">chemin absolu</em> du <em style="color: green">répertoire</em> contenant le fichier exécuté.
* Exemple: Essayons d'imprimer la valeur du __dirname

```js
console.log( __dirname );
```
Exécutez le fichier <em style="color: red">test.js</em> pour voir le résultat:
```bash
node test.js
```

<nsv>
<em style="color: blue">3. exports(1/3)</em> <br/>
Le <em style="color: red">module.exports</em> ou <em style="color: red">exports</em> est un objet spécial qui est <em style="color: green">inclus par défaut</em> dans chaque fichier JS dans l'application Node.js. Un <em style="color: red">module</em> est une variable qui représente le module actuel et <em style="color: red">exports</em> est un objet qui sera <em style="color: green">exposé</em> en tant que <em style="color: green">module</em>. Donc, tout ce que vous <em style="color: red">attribuez</em> à module.exports ou exports, <em style="color: green">sera exposé en tant que module</em>.
![](./src/images/myExport.PNG)

<nsv>
<em style="color: blue">3. exports(2/3)</em> <br/>
Créer un fichier <em style="color: red">export.js</em> ayant le contenu du fichier <em style="color: red">test.js</em>, modifier le contenu du fichier pour avoir quelque chose qui ressemble au fichier ci-dessous:

```js
//import required module
const path = require('path');

//create module
const myModule = () => {
/**
 * put here the content of file test.js (line 3, 4, 5)
*/
};
//myModule();
module.exports = myModule;
```
<nsv>
<em style="color: blue">3. exports(3/3)</em> <br/>
Maintenant il nous reste juste à <em style="color: green">récupérer</em>  et <em style="color: green">faire appel</em>  au <em style="color: red">module exporté</em>, créer un fichier <em style="color: red">app.js</em> ayant le contenu suivant:

```js
//Import the module that was exported
const firstModule = require('./export');
//call the module
firstModule();
```
Exécutez le fichier <em style="color: red">app.js</em> pour voir le résultat:
```bash
node app.js
```
<nsv>
<em style="color: blue">4. process</em> <br/>
L’objet <em style="color: green">process</em> correspond à <em style="color: green">l’instance</em> de l’environnement Node en <em style="color: green">cours</em> d’exécution.<br/>
Le plus utilisé est <em style="color: #01B0F0">process.env.VARIABLE_NAME</em>, il permet de déclarer <em style="color: red">les variables d'environnement</em> .<br/>
Dans la fichier <em style="color: red">test.js</em> rajouter cette ligne:
```js
console.log(process.env.TEST)
```
Puis exécuter le fichier:

```bash
TEST=1 node test.js
```
<nsv>
<em style="color: blue">5. setTimeout, setInterval et setImmediate(1/2)</em> <br/>
Node fournit des implémentations de <em style="color: red">setTimeout</em>  , de <em style="color: red">setInterval</em> et de <em style="color: red">setImmediate</em>.
Exemple:

```js
//creation d'une fonction print()
const print = (message) => {
    return () => {
        console.log(message);//(1)(2)(3)
    };
};
/**
 * faire appel à la fonction print en lui passant à chaque appel 
 des parametres differents
 */
const timer = setInterval(print('interval'), 2500);
setTimeout(print('timeout'), 2000);
setImmediate(print('immediate'));
```
<nsv>
<em style="color: blue">5. setTimeout, setInterval et setImmediate(2/2)</em> <br/>
<em style="color: red">Le résultat d'exécution:</em> <br/>
* <em style="color: red">(1)</em> Affichera d’abord <em style="color: green">immediate…</em> ;
* <em style="color: red">(2)</em> … suivi de timeout environ <em style="color: green">2000ms plus tard</em>… ;
* <em style="color: red">(3)</em> … puis <em style="color: green">interval environ 500ms plus tard</em> et <em style="color: red">ce</em>,
 <em style="color: green">toutes les 2500ms </em>tant que le programme ne sera pas arrêté ou que clearTimeout n’annulera pas l’intervalle.

Pour exécuter:
```bash
node time.js
```
