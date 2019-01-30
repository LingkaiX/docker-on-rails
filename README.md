# README
**This is an example ruby on rails (version 5.2) app for *docker* usage.**

### To start the development envirment (after setup) just simply input: `docker-compose up`

#### To set up the development envirment:
1. Install git, docker and docker-compose
2. `git clone https://github.com/LingkaiX/docker-on-rails.git`
3. `cd docker-on-rails`
4. `docker-compose build`
5. `docker-compose up`

#### If dependencies (i.e. Gemfile ot Gemfile.lock) changed, please rebuild the docker image: `docker-compose build`

#### To interact with the alive docker container:
1. Look for the *CONTAINER ID* by: `docker container ls -a`
2. Then: `docker exec -it [CONTAINER ID] bash`
3. PS: Also can run a one-time command by: `docker-compose run [SERVICE NAME] [COMMAND]`, for example: `docker-compose run app rake db:migrate`

Try to visit: [homepage](http://localhost:3000) or [users](http://localhost:3000/users)



test-commit: c1 ->> true!