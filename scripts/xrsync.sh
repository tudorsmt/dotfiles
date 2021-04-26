#!/usr/bin/env bash

set -euo pipefail

CUR_DIR=$(pwd)


main() {
    local rsync_base="rsync -ahvP --stats"
    local destination=""
    local source=""

    read_args "${@}"

    info "Will sync ${CUR_DIR}"

    # sanity check
    if [ "${source}" = "" ] && [ "${destination}" = "" ]; then
        err_exit "Please specify --to or --from parameters"
    fi

    if [ "${source}" != "" ] && [ "${destination}" != "" ]; then
        err_exit "Specify only --to or --from. The arguments are mutually exclusive."
    fi
    # / sanity check

    if [ "${source}" != "" ]; then
        ${rsync_base} "${source}":"${CUR_DIR}" "$(dirname "${CUR_DIR}")"
    fi

    if [ "${destination}" != "" ]; then
        ${rsync_base} "${CUR_DIR}" "${destination}":"$(dirname "${CUR_DIR}")"
    fi
}

read_args() {
    local arg=
    while [[ $# -gt 0 ]]; do
        arg=$1
        case "$arg" in
            -h|--help)
                set +x
                usage
                exit 0
                ;;
            -n|--dry-run)
                rsync_base+=" -n"
                ;;
            --exclude)
                exclude=${2:-}
                if [ "${exclude}" = "" ]; then
                    err_exit "Expected argument after ${arg}"
                fi
                rsync_base+=" --exclude ${exclude}"
                shift
                ;;
            --delete)
                rsync_base+=" --delete"
                ;;
            --to)
                destination=${2:-}
                if [ "${destination}" = "" ]; then
                    err_exit "Expected argument after ${arg}"
                fi
                shift
                ;;
            --from)
                source=${2:-}
                if [ "${source}" = "" ]; then
                    err_exit "Expected argument after ${arg}"
                fi
                shift
                ;;
            *)
                logger::err_exit "Invalid argument: $arg"
        esac
        shift
    done
}

info() {
    echo "[INFO] ${@}"
}

error() {
    echo "[ERROR] ${@}"
}

error_exit() {
    error ${@}
    exit 1
}

usage() {
    echo "TBD"
}

main "${@}"
