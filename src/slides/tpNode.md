#### <em style="color: red">TP Node.js (1/3)</em>
* <em style="color: magenta">Créer</em> un <em style="color: green">serveur</em> en Nodejs.
* <em style="color: magenta">Externaliser</em> le <em style="color: #01B0F0">PORT</em> d'écoute de l'application.
* <em style="color: magenta">Récupérer</em> le nom du <em style="color: green">fichier html</em> passé via <em style="color: #01B0F0">l'url</em>, ici <em style="color: blue">index.html</em> (http://127.0.0.1:3000/index.html)
* <em style="color: green">Utiliser</em> le module <em style="color: green">url</em> et la  <em style="color: magenta">méthode parse</em> afin de récupérer l'url et <em style="color: green">faire le tri</em> avec la <em style="color: green">méthode substr</em> pour récupérer le mot <em style="color: red">index.html</em>.
<nsv>
#### <em style="color: red">TP Node.js (2/3)</em>
* Lire le fichier <em style="color: blue">index.html</em> dont le contenu est:<br/>

```html
<html>
<head>
    <link rel="icon" href="data:,">
    <title>TP1 Nodejs</title>
</head>
<body>
    les grandes entreprises optent pour Node.js: Microsoft, IBM, Yahoo!, Netflix, Groupon ou encore PayPal qui, en 2013, migrait ses applications de Java vers Node.js.
</body>
</html>
``` 
* Ecrire <em style="color: green">l'entête de la réponse</em>  avec comme <em style="color: #01B0F0">Content-Type</em>:  <em style="color: magenta">'Content-Type': 'text/html'</em>.<br/>

<nsv>
#### <em style="color: red">TP Node.js (3/3)</em>
Pour réaliser ce tp vous pouvez vous inspirer/utiliser du/le code disponible dans les fichiers:
* <em style="color: green">main.js</em>  
* <em style="color: green">myFirstCB.js</em> 

<nsv>
### <em style="color: blue">Solution</em>
<em style="color: magenta">Etape 1</em>
* Créer un fichier <em style="color: red">tpNode.js</em>
* <em style="color: green">Importer/installer</em>(npm install --save modulename) les modules que vous aurez besoin, dans cette exemple on aura besoin de 3 modules: <em style="color: #01B0F0">http</em>, <em style="color: #01B0F0">fs</em>, <em style="color: #01B0F0">url</em>.<br/>

```js
//imoort required modules
const http = require('http'),
    fs = require('fs'),
    url = require('url');

```
Externaliser le PORT:

```js
let port = (process.env.PORT || '3000')
```
<nsv>
<em style="color: magenta">Etape 2</em><br/>
Créer un serveur:

```js
// Create a server
http.createServer((request, response) => {
    //put the code here
}).listen(port);
```
Analyser la requête contenant le nom de fichier:

```js
    let pathname = url.parse(request.url).pathname;
    console.log(`Request for ${pathname} received`);
    //extact the file name
    let input = pathname.substr(1);
    console.log(`str ${input}`);
```

<nsv>
<em style="color: magenta">Etape 3</em><br/>
<em style="color: red">Creér</em> un fichier <em style="color: red">index.html</em> ayant le contenu suivant:

```html
<html>
<head>
    <link rel="icon" href="data:,">
    <title>TP1 Nodejs</title>
</head>
<body>
    les grandes entreprises optent pour Node.js: Microsoft, IBM, Yahoo!, Netflix, Groupon ou encore PayPal qui, en 2013, migrait ses applications de Java vers Node.js.
</body>
</html>
```
<nsv>
<em style="color: magenta">Etape 4</em><br/>
Utiliser le module <em style="color: red">fs</em> pour lire le fichier html précédemment crée:

```js
    fs.readFile(input, (err, data) => {
        if (err) {
            response.writeHead(404, {'Content-Type':'text/html'});
        } else {
            response.writeHead(200, {'Content-Type':'text/html'});
            response.write(data);
        }
        // Send the response body
        response.end();
    });
```

<nsv>
<em style="color: magenta">Etape 5</em><br/>
* Exécutez maintenant le <em style="color: red">tpNode.js</em> pour démarrer le serveur comme suit:

```bash
PORT=3010 node tpNode.js
```

* Sur votre navigateur appelez cette <em style="color: red">URL</em>:
http://127.0.0.1:3010/index.html

