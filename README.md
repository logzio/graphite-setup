# Graphite Setup

This reposistory is for dokcer images of graphite and the associated carbon daemons: 
carbon-cache and carbon-relay.
It represents what we believe to be the best practices for running a graphite cluster.
Forked from: [banno/graphite-setup](https://github.com/Banno/graphite-setup.git)


## Build

- docker and docker-compose must be installed
- `rake -T` will explain most everything

## Example docker-compose.yml

The [docker-compose.yml][] file is an example of a multi-node graphite cluster with each node running mulitple `carbon-cache`s.

## Contributing

Fork away, commit, and send a pull request.

[docker-compose.yml]: ./docker-compose.yml
