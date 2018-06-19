#### <em style="color: red">Les files systèmes</em>
Node.js <em style="color: #01B0F0">inclut</em> le module <em style="color: #01B0F0">fs</em> pour <em style="color: green">accéder</em> au système de fichiers physique. Le module fs est responsable de toutes les <em style="color: #01B0F0">opérations d'E/S</em> de fichiers <em style="color: green">asynchrones</em> ou <em style="color: green">synchrones</em>.

<nsv>
<em style="color: blue">synchrone vs asynchrone(1/2)</em> <br/>
* En mode <em style="color: red">synchrone(bloquant)</em>, le processus appelant <em style="color: green">attend</em> que le processus appelé <em style="color: #01B0F0">ait renvoyé sa réponse</em> pour<em style="color: magenta"> continuer à s'exécuter</em>.
* En mode <em style="color: red">asynchrone(non-bloquant)</em>, le processus appelant <em style="color: green">continue à travailler</em> pendant que le processus appelé <em style="color: magenta">exécute le traitement demandé</em> et <em style="color: #01B0F0">gère</em> via un <em style="color: #01B0F0">événement</em> - ou éventuellement via une <em style="color: #01B0F0">instruction de synchronisation</em> - <em style="color: green">le(s) retour(s) du processus appelé</em>.

<nsv>
<em style="color: blue">synchrone vs asynchrone(2/2)</em> <br/>
![](./src/images/bloquantVSnonbloquant.png)

<nsv>
<em style="color: blue">Read file synchrone vs asynchrone(1/2)</em> <br/>
Créer un fichier <em style="color: red">bloquantVsN-bloquant.js</em> ayant le contenu du fichier <em style="color: red">myFirstCB.js</em>, puis rajouter ces lignes(à la place du commentaire <em style="color: green">TODO</em>):

```js
// Synchronous read
console.log(`-->Debut execution Synchrrone`);
let data = fs.readFileSync('input2.txt');
console.log(`Synchronous read: ${data.toString()}`)
console.log(`-->Fin Execution Synchrone`);
```
<nsv>
<em style="color: blue">Read file synchrone vs asynchrone(2/2)</em> <br/>
Créer un fichier <em style="color: red">input2.txt</em> ayant le contenu suivant:

```
Express est une infrastructure d'applications Web Node.js minimaliste et flexible qui fournit un ensemble de fonctionnalités robuste pour les applications Web et mobiles.

```
Exécuter <em style="color: red">bloquantVsN-bloquant.js</em> pour voir le résultat:

```bash
node bloquantVsN-bloquant.js
```

<nsv>
<em style="color: blue">Méthodes importantes du module fs(1/3)</em> <br/>

| <em style="color: red">Méthode</em>          |   <em style="color: red"> Description</em>     |
|----------------------------------------------|:----------------------------------------------:|
| <em style="color: #01B0F0">readFile()</em>   | Lit un fichier existant                        |
| <em style="color: #01B0F0">writeFile()</em>  | Ecrit dans un fichier, le remplace s'il existe |
| <em style="color: #01B0F0">open()</em>       | Ouvre un fichier pour lire ou écrire           |
| <em style="color: #01B0F0">rename()</em>     | Renomme un fichier existant.                   |
| <em style="color: #01B0F0">appendFile()</em> | Ajouter un nouveau contenu au fichier existant |

<nsv>
<em style="color: blue">Méthodes importantes du module fs(2/3)</em> <br/>

| <em style="color: red">Méthode</em>          |   <em style="color: red"> Description</em>     |
|----------------------------------------------|:----------------------------------------------:|
| <em style="color: #01B0F0">rmdir()</em>      | Supprime un répertoire existant                |
| <em style="color: #01B0F0">mkdir()</em>      | Crée un nouveau répertoire                     |
| <em style="color: #01B0F0">readdir</em>      | Lit le contenu du répertoire spécifié          |
| <em style="color: #01B0F0">rename()</em>     | Renomme le répertoire existant                 |
| <em style="color: #01B0F0">existe()</em>     | Détermine si le fichier spécifié existe ou non |
| <em style="color: #01B0F0">unlink()</em>     | Supprime un fichier existant                   |

<nsv>
<em style="color: blue">Méthodes importantes du module fs(3/3)</em> <br/>
* <em style="color: red">Remarque</em><br/>
Toutes les méthodes precédentes sont <em style="color: green">asynchrones</em>, elles ont presque toutes un <em style="color: green">equivalent</em> en mode <em style="color: green">synchrone</em>.<br/>
* <em style="color: red">Exemple:</em><br/>
il suffit de rajouter <em style="color: blue">Sync</em> à la fin de la méthode:

| <em style="color: red">Asynchrone</em>       |   <em style="color: red"> Synchrone</em>       |
|----------------------------------------------|:----------------------------------------------:|
| <em style="color: #01B0F0">readFile</em>     | <em style="color: magenta">readFileSync</em>   |