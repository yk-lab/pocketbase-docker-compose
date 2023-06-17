# PocketBase Docker Compose Example

## Usage

```shell-session
$ docker compose up -d
```

## Latest Version

```yaml:compose.yml
services:
  pb:
    image: ghcr.io/yk-lab/pocketbase:latest
    volumes:
      - pb_data:/pb_data
    ports:
      - "${PORT:-8090}:8090"

volumes:
  pb_data:
```

## Specify Version

```yaml:compose.yml
services:
  pb:
    build:
      context: .
      args:
        - VERSION=0.16.5
        - PORT=${PORT:-8090}
    volumes:
      - pb_data:/pb_data
    ports:
      - "${PORT:-8090}:${PORT:-8090}"

volumes:
  pb_data:
```

OR

```yaml:compose.yml
services:
  pb:
    image: ghcr.io/yk-lab/pocketbase:0.16.5
    volumes:
      - pb_data:/pb_data
    ports:
      - "${PORT:-8090}:8090"

volumes:
  pb_data:
```

## Run Update

```shell-session
$ docker compose run --rm pb ./pocketbase update
```
