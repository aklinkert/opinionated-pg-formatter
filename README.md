# opinionated-pg-formatter

[![test](https://github.com/aklinkert/opinionated-pg-formatter/actions/workflows/test.yml/badge.svg)](https://github.com/aklinkert/opinionated-pg-formatter/actions/workflows/test.yml)

A docker file containing [pgFormatter](https://github.com/darold/pgFormatter) with an opinionated default config and
support for ignored files. Simple, easy to use, and works with a default set of configuration out of the box.

## Usage

Assuming you have a directory called `migrations` with your SQL files in it, run:

```shell
docker run -v "./migrations:/workdir" --rm ghcr.io/aklinkert/opinionated-pg-formatter
```

Every `*.sql` file below the mounted directory is formatted in place (`linux/amd64` and `linux/arm64` images are
published). Image tags: Semver tags (`1`, `1.3`, `1.3.0`) and `sha-<commit>`.

### Configuration

The formatter runs `pg_format` with fixed options: upper-case keywords, functions and types (`--keyword-case 2
--function-case 2 --type-case 2`), `--keep-newline` and `--nogrouping`. See [format.sh](format.sh).

To skip a file, put this line verbatim in it:

```sql
-- +disable-pg-format
```

## Development

The pgFormatter version is pinned in the `Dockerfile` (`PG_FORMATTER_VERSION`) and updated by Renovate. CI builds the
image, formats the files in [tests/fixtures](tests/fixtures) and diffs them against [tests/expected](tests/expected).
Run it locally (needs Docker; the temp dir must be shareable with the Docker VM):

```shell
docker build -t opinionated-pg-formatter:test . && tests/run.sh
```

When pgFormatter changes its output, regenerate `tests/expected` and review the diff.

## License

```
MIT License

Copyright (c) 2025 - present Alex Klinkert
```
