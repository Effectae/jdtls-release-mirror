#!/usr/bin/bash

set -euo pipefail

: "${TMP:=$(pwd)/tmp}"

fetch_download_page()
{
    local MANIFEST_PATH="${TMP}/milestones"
    # cache the manifest
    [[ -e "$MANIFEST_PATH" ]] || curl -f 'https://download.eclipse.org/jdtls/milestones/' -o "${MANIFEST_PATH}"
    cat "${MANIFEST_PATH}"
}

get_versions(){
    fetch_download_page | \
        grep -oE "<a href='/jdtls/milestones/([0-9]+[0-9.]+)'> \1" | \
        grep -oE "[0-9.]+$"
}

: "${VERSIONS_PATH:=$TMP/versions}"

get_versions > "${VERSIONS_PATH}"
