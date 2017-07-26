# SDG Platform

Platform with information on UN Sustainable Development Goals and a database of social development projects adding to the fullfilment of each goal. 

## Development setup

Instructions for setting up a development environment.

1. Install ruby 2.3.1. If using rbenv, run:
    ```bash
    $ rbenv install 2.3.1
    $ rbenv shell 2.3.1
    $ gem install bundler
    ```

2. Install project dependencies
    ```bash
    $ bundle install
    ```

3. Create Postgres database
    ```bash
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    ```

4. Optionally run seeds for default users, Argentina provinces, and population groups
    ```bash
    $ bundle exec rake db:seed
    ```

5. Start the server and open a browser at `localhost:3000`
    ```bash
    $ bundle exec rails server
    ```

## Deployment

A Docker image is available at https://hub.docker.com/r/instedd/raci/.
