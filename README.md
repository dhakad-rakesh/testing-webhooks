# Bet Backend

## Deployment and build

This project uses Docker to run separate containers on machine. Here are the major steps involving usage of docker

### Step 1: Build new docker image

- You can use docker build command to create new image.
- Devise secret and target environment must be passed as build arguments
- Each new image must be tagged in the format like `1.0.0` which is above the previous tag
- NOTE: If you don't pass the tag, image would be tagged with default `latest` tag.

```
sudo docker build \
  --build-arg rails-env=<YOUR_TARGET_ENVIRONMENT> \
  --build-arg devise-secret=<YOUR_DEVISE_SECRET> .
  -t ketansaxena/bwinner-app:<NEW_TAG>
```

### Step 2: Push new docker image
- Next step is to push new image to our private registry
- NOTE: You must first configure the docker account in your local machine by using `docker login`

```
sudo docker push ketansaxena/bwinner-app:<NEW_TAG>
```

### Step 3: Deploy new image on server
- ssh into the server by command
```
ssh -i <PATH_TO_PEM_FILE> ubuntu@ec2-3-13-199-159.us-east-2.compute.amazonaws.com
```


- kill the previous container
```
sudo docker kill bwinner_rails_app
```

- run new container with new image
```
sudo docker run -d -p 80:3000 ketansaxena/bwinner-app:<NEW_TAG> --name bwinner_rails_app
```

## Application Cheat Sheet

#### Enable GameService API(Goal Serve, Betradar)
Run : `GameService.activate(:GS) OR GameService.activate(:BR)`

#### Create Markets and Outcomes
Run : `rake market_and_outcomes:create`


# Deployment
#### Staging Server(For user requests)
- Run command, `mina staging deploy --trace`

#### Staging Sidekiq Server(For sidekiq and other processes)
- Deployment command
- Run command, `mina staging_sidekiq deploy --trace`

#### Other commands
- Run command, `mina sidekiq:restart`, to restart sidekiq.
- Run command, `puma:phased_restart`, to restart puma.
