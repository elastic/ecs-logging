#!/usr/bin/env bash

set -uexo pipefail

readonly REPO_NAME=${1}
readonly SPECS_FILEPATH=${2}
readonly REPO_DIR=".ci/${REPO_NAME}"

git clone "https://github.com/elastic/${REPO_NAME}" "${REPO_DIR}"

SPECS_DIR=$(dirname "${SPECS_FILEPATH}")
mkdir -p "${REPO_DIR}/${SPECS_DIR}"

echo "Copying files to the ${REPO_NAME} repo"
cp -f spec/spec.json "${REPO_DIR}/${SPECS_FILEPATH}"

cd "${REPO_DIR}"
git config user.email
git checkout -b "update-spec-files-$(date "+%Y%m%d%H%M%S")"
git add "${SPECS_FILEPATH}"
git commit -m "synchronize ecs-logging spec"
git --no-pager log -1
