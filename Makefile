DOCKER_REGISTRY_INTEG_URL=docker-app.registry.XXXXXXX
DOCKER_REGISTRY_PROD_URL=docker-app.registry.XXXXXXXXXXXXX

DOCKER_TAG_NAME=/formation-node-express
DOCKER_TAG_VERSION=latest

build: build-integ

build-integ:
	docker build -t $(DOCKER_REGISTRY_INTEG_URL)/$(DOCKER_TAG_NAME):$(DOCKER_TAG_VERSION) .
	
publish-integ: build-integ
	docker push $(DOCKER_REGISTRY_INTEG_URL)/$(DOCKER_TAG_NAME):$(DOCKER_TAG_VERSION)
	
build-prod:
	docker build -t $(DOCKER_REGISTRY_PROD_URL)/$(DOCKER_TAG_NAME):$(DOCKER_TAG_VERSION) .
	
publish-prod: build-prod
	docker push $(DOCKER_REGISTRY_PROD_URL)/$(DOCKER_TAG_NAME):$(DOCKER_TAG_VERSION)
