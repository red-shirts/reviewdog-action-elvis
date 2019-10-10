# GitHub Action: Run elvis with reviewdog

[![Docker Image CI](https://github.com/hauleth/reviewdog-action-elvis/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/hauleth/reviewdog-action-elvis/actions)
[![Release](https://img.shields.io/github/release/hauleth/reviewdog-action-elvis.svg?maxAge=43200)](https://github.com/hauleth/reviewdog-action-elvis/releases)

This action runs [elvis](https://github.com/inaka/elvis) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

## Inputs

### `github_token`

**Required**. Must be in form of `github_token: ${{ secrets.github_token }}`'.

### `level`

Optional. Report level for reviewdog [info,warning,error].
It's same as `-level` flag of reviewdog.

### `reporter`

Reporter of reviewdog command [github-pr-check,github-pr-review].
Default is github-pr-check.
github-pr-review can use Markdown and add a link to rule page in reviewdog reports.

## Example usage

### [.github/workflows/reviewdog.yml](.github/workflows/reviewdog.yml)

```yml
name: reviewdog
on: [pull_request]
jobs:
  elvis:
    name: runner / elvis
    runs-on: ubuntu-latest
    container:
      image: erlang:22-slim
    steps:
      - uses: actions/checkout@v1
      - name: Install Dependencies
        run: |
          rebar3 do get-deps, compile
      - name: elvis
        uses: hauleth/reviewdog-action-elvis@v1
        with:
          github_token: ${{ secrets.github_token }}
          reporter: github-pr-review # Change reporter.
```
