#### <em style="color: red">npm</em>
NPM (Node Package Manager) est un package manager spécialement conçu pour Node.js. Il facilite la création, le partage et l'installation de modules.

NPM est livré avec Node.js. Pour vérifier que <em style="color: red">npm</em> est installé,
Ouvrez la console et tapez la commande suivante:

```bash
npm --version
```
<nsv>
![Exemple de package](./src/images/module-npm.png)

<nsv>
<em style="color: blue">1. Mise à jour de npm</em> <br/>
Si vous utilisez une <em style="color: red">ancienne version</em> de NPM, il est assez facile de la <em style="color: green">mettre à jour</em>.<br/>
Ouvrez <em style="color: red">la console à partir de la racine</em> en tant que <em style="color: green">administrateur</em> et tapez la commande suivante:

```bash
npm install npm -g
```
<nsv>
<em style="color: blue">2. Initialisation d'un projet(1/2)</em> <br/>
Indispensable pour pouvoir <em style="color: red">utiliser</em> npm avec votre projet. La commande <em style="color: magenta">npm init</em> va <em style="color: red">générer</em> un fichier <em style="color: green">package.json </em>qui décrit la configuration de votre projet.

Les attributs du Package.json

```json
name: (project-name) project-name
version: (0.0.0) 0.0.1
description: The Project Description
entry point: //leave empty
test command: //leave empty
git repository: //the repositories url
keywords: //leave empty
author: // your name
license: N/A
```
<nsv>
<em style="color: blue">2. Initialisation d'un projet(2/2)</em> <br/>
Maintenant pour générer votre <em style= "color: red"> package.json</em>, sur votre console tapez cette commande:
```bash
npm init
```
Exemple de package.json:

```json
{
  "name": "myapp",
  "version": "1.0.0",
  "description": "Formation node-express",
  "scripts": {
    "start":"main.js",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git@gitlabXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  },
  "author": "syahiaoui",
  "license": "ISC"
}
```

<nsv>
<em style="color: blue">3. Installation de modules à l'aide de NPM</em> <br/>
Pour installer un module Node.js il suffit d'executer une de ces commandes suivantes:

```bash
npm install (with no args, in package dir)
npm install -g express@latest
npm install --save express
npm install --save express@4.15.3

alias: npm i
common options: [-P|--save-prod|-D|--save-dev|-O|--save-optional] [-E|--save-exact] [-B|--save-bundle] [--no-save] [--dry-run] 
[-g |--global]
```
Les modules installés seront regroupés dans le dossier <em style="color: red">node_modules</em> 

<nsv>
<em style="color: blue">3. Mise à jour & désinstallation d'un module NPM</em>

* Pour mettre à jour un module:

```
npm update --save express  
aliases: up, upgrade
```

* Supprimer un module:

```
npm uninstall --save express 
[<@scope>/]<pkg>[@<version>]... [-S|--save|-D|--save-dev|-O|--save-optional|--no-save]

aliases: remove, rm, r, un, unlink
```

<nsv>
<em style="color: blue">4. La version des modules dans le package.json</em><br/>
Vous pouvez spécifier les types de mises à jour que votre application peut accepter dans le fichier package.json.   
MAJEUR.MINEUR.CORRECTIF => (SemVer - (http://semver.org/lang/fr/))

```
Patch releases: 1.0 or 1.0.x or ~1.0.4
Minor releases: 1 or 1.x or ^1.0.4
Major releases: * or x
```