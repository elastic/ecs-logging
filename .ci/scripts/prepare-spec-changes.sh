#!/usr/bin/env bash

set -uexo pipefail

readonly REPO_NAME=${1}
readonly SPECS_TYPE=${2} # json
readonly SPECS_DIR=${3}
readonly REPO_DIR=".ci/${REPO_NAME}"

EXTENSION="feature"
if [[ "${SPECS_TYPE}" == "json" ]]; then
    EXTENSION="json"
fi

git clone "https://github.com/elastic/${REPO_NAME}" "${REPO_DIR}"

mkdir -p "${REPO_DIR}/${SPECS_DIR}"
echo "Copying ${EXTENSION} files to the ${REPO_NAME} repo"
cp spec/*.${EXTENSION} "${REPO_DIR}/${SPECS_DIR}"

cd "${REPO_DIR}"
git config user.email
git checkout -b "update-spec-files-$(date "+%Y%m%d%H%M%S")"
git add "${SPECS_DIR}"
git commit -m "test: synchronizing ${SPECS_TYPE} specs"
git --no-pager log -1
