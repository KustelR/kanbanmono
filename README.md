# Mykanban Monorepo

This is monorepository combining every part of mykanban. You can build full app through docker compose here

## Build Steps

1. Clone this repo
2. Specify enviroment variables (Placing them inside .env in this directory will do):

    ```env
    APP_PORT=3000 # web app exposed port
    API_PORT=7501 # api exposed port
    MYSQL_ROOT_PASSWORD=your-secret-password # root password for mysql database
    ```

3. Run docker compose

    ```bash
    docker compose up
    ```
