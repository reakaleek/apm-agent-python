#!/usr/bin/env bash

set -euo pipefail

readonly REPO_DIR=".ci/apm-data"
rm -rf "${REPO_DIR}"
mkdir -p "${REPO_DIR}"

(
cd "${REPO_DIR}"
git init
git remote add origin https://github.com/elastic/apm-data.git
git fetch --depth 1 origin "${2}"
git checkout FETCH_HEAD
)

cp "${REPO_DIR}/input/elasticapm/docs/spec" "${1}"
