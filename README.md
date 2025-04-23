## General flow of release and deployment

Build phase
1) Build docker image for python app
2) Tag the docker image
3) Upload it to GCP artifact registry

Release
1) Every server uses puppet to pull docker image from artifact registry
2) Create container with docker image and installs on server

## Assumptions
1) Servers run on GCP
2) Servers os is debian and package manager is apt

## Run locally
```
cd docker

#build image and run
docker build -t helloworld-api .
docker run -d -p 8000:8000 helloworld-api

#curl result
curl http://localhost:8000/helloworld
```

## Upload image to GCP Artifact Registry

Note: you will have to setup your own Artifact Registry
```
cd docker

#Build image, tag, upload to gcp artifact registry
docker build -t helloworld-api .

#tag
docker tag helloworld-api \
  us-central1-docker.pkg.dev/{projectId}/{repo}/{image}:{tag}

#push
docker push us-central1-docker.pkg.dev/{projectId}/{repo}/{image}:{tag}
```

## Download and Install image
```
you will need to scp puppet and setup directory to server

# install puppet and docker. chmod 777 if needed
./setup/puppet-docker-install.sh

# run puppet config
puppet apply helloworld_api.pp
```

## Tradeoff
container vs non-container setup of api source code

### Docker
 - Pro: Isolated enviornement, container runs with its own dependencies.
 - Con: need extra component to host docker image such as Artifact registry.

### Non-container setup
 - Pro: No need for container. Works directly on the host machine.
 - Con: Packages can conflict. Need to implement versioning strategies for release
