#### <em style="color: red">Gestion des erreurs Winston</em>
Winston est une <em style="color: green">bibliothèque </em> de <em style="color: green">logging</em> la plus populaire disponible pour nodejs.
Elle offre <em style="color: green">deux</em> possibilités: 
* Utiliser le <em style="color: #01B0F0">logger par défaut</em>.
* Instancier <em style="color: #01B0F0">votre propre logger</em>.

<nsv>
<em style="color: blue">Installation</em> <br/>

<em style="color: red">Winston</em> est disponible dans le <em style="color: green">gestionnaire</em> de pacquets <em style="color: red">npm</em>:
```bash
npm install --save winston
```

<nsv>
<em style="color: blue">Utilisation du logger par défaut</em> <br/>
* Le logger par <em style="color: red">défaut</em> est <em style="color: green">accessible</em> directement via le module <em style="color: green">winston</em>, dans ce mode on trouve que le <em style="color: red">transport</em> sur la <em style="color: red">console</em> qui est pris en <em style="color: green">charge</em>. 

```js
const logger = require('winston');
//print in the console
logger.info('I use winston logger')
logger.error('I use winston logger')
```
* Vous pouvez lui <em style="color: red">rajouter</em> le mode <em style="color: green">transport</em> vers un <em style="color: red">fichier</em> comme suit:
```js
logger.add(logger.transports.File, { filename: 'somefile.log' });
```
* Vous pouvez faire des <em style="color: magenta">tests</em> dans le  fichier <em style="color: magenta">app.js</em>.
<nsv>
<em style="color: blue">Instancier votre propre Logger(1/3)</em> <br/>
* <em style="color: red">Initialisation</em> du <em style="color: green">logger</em> avec deux <em style="color: red">moyens</em> de <em style="color: green">transports</em>(console & file), créer le fichier <em style="color: red">logger.js</em> ayant le code suivant:

```js
const winston = require('winston');
//put log levels here
let logger = new (winston.Logger)({
    transports: [
      new (winston.transports.Console)(),
      new (winston.transports.File)({ filename: 'somefile.log' })
    ]
  });
```

<nsv>
<em style="color: blue">Instancier votre propre Logger(2/3)</em> <br/>
<em style="color: red">Configuration</em> du mode <em style="color: green">Console</em> et du mode <em style="color: green">File</em>:

* <em style="color: magenta">Console</em> : On active le mode <em style="color: #01B0F0">debug</em> et les <em style="color: #01B0F0">exceptions</em> 
```js
new winston.transports.Console({
            level: 'debug',
            handleExceptions: true,
            humanReadableUnhandledException: true,
            timestamp: true,
            json: false,
            colorize: true
        }),
```
<nsv>
<em style="color: blue">Instancier votre propre Logger(3/3)</em> <br/>

* <em style="color: magenta">File</em>: Pour un meilleur rendu on met <em style="color: #01B0F0">json = false</em> 

```js
new winston.transports.File({
            level: 'info',
            filename:"C:/Temp/all-logs.log",
            timestamp: true,
            handleExceptions: true,
            humanReadableUnhandledException: true,
            json: false,
            maxsize: 5242880, //5MB
            maxFiles: 5,
            colorize: false
        }),
```