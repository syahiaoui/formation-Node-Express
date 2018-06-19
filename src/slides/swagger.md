#### <em style="color: red">Swagger</em>
Swagger est une spécification pour décrire, la production, la consommation, les tests et la visualisation d'une API RESTful.

<nsv>
<em style="color: blue">Génération du Swagger Spec</em> <br/>
Vous pouvez générer la documentation d'une application de deux façons:
  * En utilisant [l'éditeur de swagger ](https://editor.swagger.io/) à la fin vous aurez un fichier <em style="color: red">swagger.json</em> .
  * En utilisant le module <em style="color: red">swagger-jsdoc</em>, en ajoutant à <em style="color: red">l'entête</em>  de chaque route sa <em style="color: red">description</em>.


<nsv>
<em style="color: blue">Exemple d'utilisation de swagger-jsdoc(1/6)</em> <br/>
<em style="color: red">Définir le model</em>, dans l'exemple on va utiliser l'<em style="color: magenta">objet orders:</em>

```yaml
/**
 * @swagger
 *  definitions:
 *   orders:
 *    properties:
 *     order_id:
 *       type: integer
 *     customer_id:
 *       type: integer
 *     order-total:
 *       type: integer
 *     order-timestamp:
 *       type: string
 *       format: date
 *     user_id:
 *       type: integer
 */


```
<nsv>
<em style="color: blue">Exemple d'utilisation de swagger-jsdoc(2/6)</em> <br/>
<em style="color: red">GET ALL</em>

```js
/** 
 * @swagger
 * /v1/orders:
 *   get:
 *     tags:
 *       - orders
 *     description: returns all orders
 *     produces:
 *       - application/json
 *     responses:
 *       200:
 *         description: success
 */
  router.get('/orders', (req, res) => {});
```

<nsv>
<em style="color: blue">Exemple d'utilisation de swagger-jsdoc(3/6)</em> <br/>
<em style="color: red">GET One</em>

```js
/**
 * @swagger
 * /v1/orders/{id}:
 *   get:
 *     tags:
 *       - orders
 *     description: Returns a single order
 *     produces:
 *       - application/json
 *     parameters:
 *       - name: id
 *         description: order's id
 *         in: path
 *         required: true
 *         type: integer
 *     responses:
 *       200:
 *         description: A single order
 */
 router.get('/orders/:id', (req, res) => {});
```
<nsv>
<em style="color: blue">Exemple d'utilisation de swagger-jsdoc(4/6)</em> <br/>
<em style="color: red">POST</em>

```js
/**
 * @swagger
 * /v1/orders:
 *   post:
 *     tags:
 *       - orders
 *     description: Creates a new orders
 *     produces:
 *       - application/json
 *     parameters:
 *       - name: orders
 *         description: orders object
 *         in: body
 *         required: true
 *         schema:
 *           $ref: '#/definitions/orders'
 *     responses:
 *       200:
 *         description: Successfully created
 */
  router.post('/orders', (req, res) => {});
```

<nsv>
<em style="color: blue">Exemple d'utilisation de swagger-jsdoc(5/6)</em> <br/>
<em style="color: red">PUT</em>

```js
/**
 * @swagger
 * /v1/orders/{id}:
 *   put:
 *     tags:
 *       - orders
 *     description: Update a single order
 *     produces:
 *       - application/json
 *     parameters:
 *       - name: id
 *         description: order's id
 *         in: path
 *         required: true
 *         type: integer
 *       - name: orders
 *         description: orders object
 *         in: body
 *         required: true
 *         schema:
 *           $ref: '#/definitions/orders'
 *     responses:
 *       200:
 *         description: update a single order
 *         schema:
 *           $ref: '#/definitions/orders'
 */
 router.put('/orders/:id', (req, res) => {});
```

<nsv>
<em style="color: blue">Exemple d'utilisation de swagger-jsdoc(6/6)</em> <br/>
<em style="color: red">DELETE</em>

```js
/**
 * @swagger
 * /v1/orders:
 *   delete:
 *     tags:
 *       - orders
 *     description: Deletes a single orders
 *     produces:
 *       - application/json
 *     parameters:
 *       - name: id
 *         description: order's id
 *         in: query
 *         required: true
 *         type: integer
 *     responses:
 *       200:
 *         description: Successfully deleted
 */

router.delete('/orders', (req, res) => {});
```