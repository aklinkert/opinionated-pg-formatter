# opinionated-pg-formatter

A docker file containing [pgFormatter](https://github.com/darold/pgFormatter) with an opinionated default config and
support for ignored files. Simple, easy to use, and works with a default set of configuration out of the box.

## Usage

Assuming you have a directory called `migrations` with your SQL files in it, run:

```shell
docker run -v "./migrations:/workdir" --rm ghcr.io/aklinkert/opinionated-pg-formatter
```

## License

```
MIT License

Copyright (c) 2025 - present Alex Klinkert
```
