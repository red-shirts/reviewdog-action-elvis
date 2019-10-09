#!/bin/sh

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

elvis rock --output-format parsable \
    | reviewdog -efm="%f:%l:%m" -name="elvis" -reporter="${INPUT_REPORTER:-'github-pr-check'}" -level="${INPUT_LEVEL}"
