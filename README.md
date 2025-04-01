# Mykanban Monorepo

This is monorepository combining both mykanban and mykanban api. You can build full app through docker compose here

## Build Steps

1. Clone this repo
2. Specify enviroment variables (Placing them inside .env in this directory will do):

    ```env
    APP_PORT=3000 # port on which web app will work
    API_PORT=7501 # port on which api will work
    MYSQL_ROOT_PASSWORD=your-secret-password # password for mysql database
    ```

3. Run docker compose

    ```bash
    docker compose up
    ```
