#!/bin/bash -e

# -------------------------------------------------------------------------------------------------------------------- #
# CONFIGURATION.
# -------------------------------------------------------------------------------------------------------------------- #

# Vars.
SRC_REPO="${1}"
SRC_USER="${2}"
SRC_TOKEN="${3}"
DST_REPO="${4}"
DST_USER="${5}"
DST_TOKEN="${6}"

# Apps.
git="$( command -v git )"

# Dirs.
d_src="/root/git/src"

# -------------------------------------------------------------------------------------------------------------------- #
# INITIALIZATION.
# -------------------------------------------------------------------------------------------------------------------- #

init() {
  mirror
}

# -------------------------------------------------------------------------------------------------------------------- #
# GIT: MIRROR.
# -------------------------------------------------------------------------------------------------------------------- #

mirror() {
  echo "--- [GIT] CLONE: ${SRC_REPO#https://}"

  SRC="https://${SRC_USER}:${SRC_TOKEN}@${SRC_REPO#https://}"
  DST="https://${DST_USER}:${DST_TOKEN}@${DST_REPO#https://}"

  ${git} clone --mirror "${SRC}" "${d_src}" \
    && _pushd "${d_src}" || exit 1
  ${git} remote add 'dst' "${DST}"
  ${git} push -f --mirror 'dst'

  _popd || exit 1
}

# -------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------< COMMON FUNCTIONS >------------------------------------------------ #
# -------------------------------------------------------------------------------------------------------------------- #

# Pushd.
_pushd() {
  command pushd "$@" > /dev/null || exit 1
}

# Popd.
_popd() {
  command popd > /dev/null || exit 1
}

# -------------------------------------------------------------------------------------------------------------------- #
# -------------------------------------------------< INIT FUNCTIONS >------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

init "$@"; exit 0