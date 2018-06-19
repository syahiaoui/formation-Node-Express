#### <em style="color: red">Installation de Node.js (1/2)</em>
* Télécharger la dernière version de nodejs  [<img src="./src/images/installation.PNG">](https://nodejs.org/en/download/)

<nsv>
#### <em style="color: red">Installation de Node.js (2/2)</em>
* Vous pouvez aussi installer Node.js en utilisant le package manager <em style="color: green">RPM</em> disponible sur le site officiel de Node.js(Environnement Linux) [https://nodejs.org/en/download/package-manager/](https://nodejs.org/en/download/package-manager/)

<nsv>
#### <em style="color: red">Configuration de npm</em>


* Editer votre fichier <em style="color: #01B0F0">*.npmrc*</em>, en utilisant la commande suivante:

```bash
npm config edit
```
avec le contenu:
```txt
registry=http://XXXXXXXXXX/repository/npm_all/
proxy=http://XXXXXXXXXXX:80/
http_proxy=http://XXXXXXXXXXX:80/
https_proxy=http://XXXXXXXXXXX:80
```

* Assurer vous d'avoir git avec la commande *git --version*<!-- .element: style="color: blue"-->.

* Pour le télécharger [https://git-scm.com/downloads](https://git-scm.com/downloads)
<nsv>
#### <em style="color: red">Visual Studio Code</em>
* Editeur de code développé par Microsoft, peut être installé sur Windows, Linux et macOS
* Téléchargement sur https://code.visualstudio.com/

<nsv>
#### <em style="color: red">Postman</em>
Pour faire des <em style="color: green">tests</em> sur votre <em style="color: green">application</em> on va utiliser <em style="color: blue">Postman</em>.<br/>
Le lien pour ajouter l’<em style="color: magenta">extension à chrome </em>:<br/>
https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop

Vous pouvez aussi utiliser <em style="color: green">insomnia</em>, qui offre plus de possibiltés que postman 
<nsv>
#### <em style="color: red">Vérification de l'installation</em>
* Créez un répertoire puis à l'interieur de ce dernier un fichier <em style="color: red">.js</em> nommé <em style="color: green">test.js</em> ayant le code suivant:

```javascript
/* Hello, World! program in node.js */
console.log("Hello, World!")

```
* Pour voir le résultat exécutez <em style="color: green">test.js</em> en utilisant l'interpréteur Node.js :

```bash
node test.js
```

