#!/usr/bin/bash

set -euo pipefail

VERSION="$1"

echo Fetching... $VERSION

TMP="$(mktemp)"

curl -o "${TMP}" \
    "https://download.eclipse.org/jdtls/milestones/${VERSION}/"

export JDTLS_DOWNLOAD_URL=$(cat "${TMP}" | \
    grep -o  "https://www\.eclipse\.org/downloads/download\.php?file=/jdtls/milestones/${VERSION}/jdt-language-server-${VERSION}-[0-9]\+\.tar\.gz")

echo "${JDTLS_DOWNLOAD_URL}"

export JDTLS_OUTPUT=$(basename "${JDTLS_DOWNLOAD_URL}")

echo "${JDTLS_OUTPUT}"

JDTLS_HASH=$(cat "${TMP}" | \
    grep -o "${VERSION}/jdt-language-server-${VERSION}-[0-9]\+\.tar\.gz\.\(sha\)\?256")

export JDTLS_HASH_URL="https://download.eclipse.org/jdtls/milestones/${JDTLS_HASH}"

echo "${JDTLS_HASH_URL}"

export JDTLS_HASH_OUTPUT=$(basename "${JDTLS_HASH_URL}")

rm "${TMP}"
