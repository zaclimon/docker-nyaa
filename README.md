# docker-nyaa

Simple dockerization for nyaa.si
More info is available here: https://github.com/nyaadevs/nyaa

## Prerequisites

- Docker
- Docker Compose

## How to build an nyaa image
1. Download the source:
``` git clone https://github.com/zaclimon/docker-nyaa```
2. Build the image
``` docker build .```
3. Profit!

## Start an instance (Basic)
You can start an instance of nyaa by simply doing this command
```docker run -d <docker-image-sha>```
It will by default, run itself using an SQLite database.

## Start an instance (External database)
You might have an external MySQL/MariaDB database you might want to use. If that's the case, this command might help you a bit more:
```docker run -d <docker-image-sha> -e MYSQL_HOST="address-of-database" -e MYSQL_USER="user" -e MYSQL_PASS="pass"```

Note: As per nyaa's recommendation, the database should be named "nyaav2"

## Docker Compose instance
If for some reason, you don't feel like creating a custom image manually, you can use
Docker Compose to get everything set up in a short amount of time. Only run the following
command:

``` docker-compose up```

**Note: The default port for nyaa is 5500.**

## Environment Variables
Environment variables can be set to further define the behavior of the wanted container. They can be
set using the ```-e``` argument when using ```docker run```.

### MYSQL_HOST
Defines the host/server for an external database instance. There is an fallback to internal SQLite if not defined.

### MYSQL_DATABASE
Defines the database name used to store the information about the website. Defaults to "nyaav2" if not defined.

### MYSQL_USER
Defines the user having access to the said external database. Defaults to "test" if not defined

### MYSQL_PASS
Defines the password to be used by MYSQL_USER. Defaults to "test123" if not defined

### SITE_FLAVOR
Defines the variant of the website. (Whether it is nyaa or sukebei) Defaults to nyaa if not defined.

## Future plans

- Add a docker-compose environment for easier setup
- Add environment variables for external elastic search instances
- Database migration (On container updates for example)
- Container creation based on a specific commit (To pinpoint bugs for example)
- Upload an image to the Docker Library or any other repository (Depends on a stable release from nyaa first)