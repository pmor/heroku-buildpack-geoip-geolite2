#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

afterSetUp() {
  env 'LIBMAXMINDDB_INSTALL' 'false'
}

testNeedsLicence() {
  env_unset 'MAXMIND_LICENSE_KEY'
  env_unset 'GEOLITE_DB_NAME'
  compile
  assertCapturedError "-----> You need to set the environment variable MAXMIND_LICENSE_KEY to be your accounts license key."
}

testNeedsName() {
  env 'MAXMIND_LICENSE_KEY' 'gAZR7U6DdeZa70y9'
  env_unset 'GEOLITE_DB_NAME'
  compile
  assertCapturedError "-----> You need to set the environment variable GEOLITE_DB_NAME to either City or Country."
}

testSuccessCity()
{
  env 'MAXMIND_LICENSE_KEY' 'gAZR7U6DdeZa70y9'
  env 'GEOLITE_DB_NAME' 'City'
  compile
  assertCapturedSuccess
}

testSuccessCountry()
{
  env 'MAXMIND_LICENSE_KEY' 'gAZR7U6DdeZa70y9'
  env 'GEOLITE_DB_NAME' 'Country'
  compile
  assertCapturedSuccess
}

env() {
  local var="${1}"
  local val="${2}"
  if [ -z "${var}" ]; then
    fail "set env var w/o specifying name"
    exit 1
  fi

  echo "${val}" > "${ENV_DIR}/${var}"
}

env_unset() {
  local var="${1}"

  if [ -f "${ENV_DIR}/${var}" ]; then
    rm "${ENV_DIR}/${var}"
  fi
}
