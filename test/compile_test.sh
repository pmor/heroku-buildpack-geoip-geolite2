#!/bin/sh

. ${BUILDPACK_TEST_RUNNER_HOME}/lib/test_utils.sh

testNeedsLicence() {
  compile
  assertCapturedError "-----> You need to set the environment variable MAXMIND_LICENSE_KEY to be your accounts license key."
}

testNeedsName() {
  MAXMIND_LICENSE_KEY=gAZR7U6DdeZa70y9
  compile
  assertCapturedError "-----> You need to set the environment variable GEOLITE_DB_NAME to either City or Country."
}

testSuccessCity()
{
  MAXMIND_LICENSE_KEY=gAZR7U6DdeZa70y9
  GEOLITE_DB_NAME=City
  compile
  assertCapturedSuccess
}

testSuccessCountry()
{
  MAXMIND_LICENSE_KEY=gAZR7U6DdeZa70y9
  GEOLITE_DB_NAME=Country
  compile
  assertCapturedSuccess
}
