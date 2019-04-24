# SDG Platform

Platform with information on UN Sustainable Development Goals and a database of social development projects adding to the fullfilment of each goal.

## Development setup

Instructions for setting up a development environment. Make sure Docker is already installed and running.
Also `docker-compose` is assumed to be available from the command line environment.

1. Install dependencies and setup the development environment:
    ```bash
    $ docker-compose run --rm app bin/setup
    ```

4. Optionally run seeds for default users, Argentina provinces, and population groups
    ```bash
    $ docker-compose run --rm app rake db:seed
    ```

5. Start the server and open a browser at `localhost:3000`
    ```bash
    $ docker-compose up
    ```

## Deployment (with Docker)

1. Build docker image:
    ```bash
    $ docker build -t instedd/raci:<optional tag> .
    ```

2. Push the image to Docker Hub
    ```bash
    $ docker push instedd/raci:<optional tag>
    ```

3. Deploy the image within a Docker environment. Here's an example configuration:
    ```yaml
    version: '2'
    services:
        app:
            image: instedd/raci
            tmpfs:
                - /app/tmp
            environment:
                DATABASE_URL: postgres://user:password@database.host/database_name
                RAILS_CONFIG__action_mailer__smtp_settings__address: smtp.host.name
                RAILS_CONFIG__action_mailer__smtp_settings__user_name: smtp_user
                RAILS_CONFIG__action_mailer__smtp_settings__password: smtp_password
                RAILS_LOG_TO_STDOUT: 'true'
                SECRET_KEY_BASE: df6031d0b421625bf84....
            volumes:
                raci-uploads:/app/public/uploads
            command:
                - /bin/bash
                - -c
                - rake db:migrate && rails server -e production -p 80
    ```

    Make sure a Postgres database is available and setup `DATABASE_URL` accordingly.

    *IMPORTANT*: Ensure the `/app/public/uploads` directory is mapped to a persistent volume.

    A random value for `SECRET_KEY_BASE` can be generated running:
    ```bash
    $ docker-compose run --rm app rake secret
    ```
