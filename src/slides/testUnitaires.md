#### <em style="color: red">Tests unitaires jasmine</em>
Jasmine est un framework de test Javascript puissant utilisé par les développeurs pour tester leurs applications.

<nsv>
<em style="color: blue">Utilisation</em> <br/>
* Ecrire les <em style="color: green">spécifications </em>  de votre code *.js dans le <em style="color: red">répertoire spec/</em>.
* Les tests vont se <em style="color: green">baser </em> sur le <em style="color: red">code status</em> des requêtes HTTP ou bien sur le <em style="color: red">contenu du body</em>
* Vos fichiers de spécification doivent être <em style="color: green">nommés *spec.js</em>, ce qui correspond à l'<em style="color: red">expression</em> régulière <em style="color: magenta">/spec\.(js|coffee|litcoffee)$/</em><br/>
* Exemple:<br/>
sampleSpecs.js -->écriture <em style="color: red">fausse</em>.<br/>
sampleSpec.js -->écriture <em style="color: red">correcte</em>.

<nsv>
<em style="color: blue">Installation</em> <br/>
Installer les modules suivants, puis initialiser jasmine:<br/>

```bash
npm install -g jasmine
npm install --save-dev jasmine 
npm install --save request
npm install --save http-status-codes 
jasmine init
```
* Mettez à la <em style="color: green">racine</em> du projet le <em style="color: green">fichier</em> de configuration qui se trouve dans <em style="color: red">spec/support/jasmine.json</em>
* <em style="color: green">Supprimer</em> le dossier support, <em style="color: green">sans toucher</em> le dossier spec. 

<nsv>
<em style="color: blue">Mise en place des tests</em> <br/>
Créer un fichier <em style="color: red">exemple_spec.js</em> dans le dossier <em style="color: red">spec/</em>, ayant le code suivant:

```js
const request = require('request'),
    HttpStatus = require('http-status-codes');

const server = require('./app'); 

const options = {
    method: 'GET',
    uri: 'http://127.0.0.1:3000/users/5'
};

describe('users', () => {
    describe('GET /', () => {
        it('should returns status code 200', (done) => {
           request.get(options,
            (error, response) => {
               expect(response.statusCode).toEqual(HttpStatus.OK);
               done();
            });
        });
    });
});
```

<nsv>
<em style="color: blue">Intégration de l'application node avec jasmine</em> <br/>
Dans la <em style="color: red">package.json</em> mettez à jour le <em style="color: green">script</em> de démarrage
```json
  "scripts": {
    "start": "pm2 start ./bin/www  --no-autorestart --no-daemon --watch  --log-date-format=\"YYY-MM-DD HH:mm Z\" --name starter",
    "dev": "pm2-dev start ./bin/www --auto-exit --timestamp",
    "stop": "pm2 stop  starter --watch 0",
    "test": "jasmine JASMINE_CONFIG_PATH=./jasmine.json"
    
  }
```
Puis <em style="color: red">lancez</em> les test:

```bash
npm test
``` 
<em style="color: magenta">Remarque: </em>Si vous exécutez les tests sous windows vous risquerez de tomber sur des erreurs dues au proxy