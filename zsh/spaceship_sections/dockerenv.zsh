#
# Docker ENV
#
# Displays currently connected Docker ENV

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_DOCKERENV_SHOW="${SPACESHIP_DOCKERENV_SHOW=true}"
SPACESHIP_DOCKERENV_PREFIX="${SPACESHIP_DOCKERENV_PREFIX="on "}"
SPACESHIP_DOCKERENV_SUFFIX="${SPACESHIP_DOCKERENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_DOCKERENV_SYMBOL="${SPACESHIP_DOCKERENV_SYMBOL="🐳 "}"
SPACESHIP_DOCKERENV_COLOR="${SPACESHIP_DOCKERENV_COLOR="cyan"}"
SPACESHIP_DOCKERENV_VERBOSE="${SPACESHIP_DOCKERENV_VERBOSE=false}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current Docker version and connected machine
spaceship_dockerenv() {
  [[ $SPACESHIP_DOCKERENV_SHOW == false ]] && return

  spaceship::exists docker || return

  local docker_host=$DOCKER_HOST
  [[ -z $docker_host ]] && return

  spaceship::section \
    "$SPACESHIP_DOCKERENV_COLOR" \
    "$SPACESHIP_DOCKERENV_PREFIX" \
    "${SPACESHIP_DOCKERENV_SYMBOL}${docker_host}" \
    "$SPACESHIP_DOCKERENV_SUFFIX"
}
