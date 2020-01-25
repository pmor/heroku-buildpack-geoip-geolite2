# Heroku Buildpack: GeoLite2 GeoIP data

[![Build Status](https://travis-ci.org/pmor/heroku-buildpack-geoip-geolite2.svg?branch=master)](https://travis-ci.org/pmor/heroku-buildpack-geoip-geolite2)

This is an unofficial [Heroku buildpack](https://devcenter.heroku.com/articles/buildpacks)
that installs the latest GeoLite2 City and Country free IP geolocation databases from
<a href="http://www.maxmind.com">MaxMind</a> along with the [libmaxminddb](https://github.com/maxmind/libmaxminddb)
C library for fast lookups in the databases.

Note an older version of the Country database is available in any Heroku deploy via the packages `geoip-bin`, `geoip-database`, and `libgeoip1` listed on https://devcenter.heroku.com/articles/stack-packages

## Usage

The GeoLite2 databases are distributed under the Creative Commons Attribution-ShareAlike 4.0 International License. The [official download page](https://dev.maxmind.com/geoip/geoip2/geolite2/) suggests the attribution requirement may be met by including the following in all advertising and documentation mentioning features of or use of the databases:

    This product includes GeoLite2 data created by MaxMind, available from
    <a href="http://www.maxmind.com">http://www.maxmind.com</a>.

From Jan-2020 users need a Maxmind account, and a valid license key. This buildpack uses the "direct download" method described in the Maxmind developer documentation (https://dev.maxmind.com/geoip/geoipupdate/#Direct_Downloads).

### Configuration options

This buildpack requires setting up two environment variables:

  - ``MAXMIND_LICENSE_KEY`` with your Maxmind licence key
  - ``GEOLITE_DB_NAME`` with either ``City`` or ``Country`` to select with Geolite database you wish to use.

#### libmaxminddb version

By default, this buildpack installs the latest version of `libmaxminddb` and will be kept updated as new versions are released.

You may set ``LIBMAXMINDDB_VERSION`` to the desired version if you want to lock a specific version. Please note that the buildpack will output a warning if you're not running the latest release of `libmaxminddb`.

#### Skip installation of libmaxminxdb

You may want to skip installation of `libmaxminddb`, i.e. if you're using the [maxminddb gem](https://github.com/yhirose/maxminddb). In that case, set ``LIBMAXMINDDB_INSTALL`` to `false`. (If ``LIBMAXMINDDB_INSTALL`` is not present, then `libmaxminddb` *will* be installed)

### Heroku

```sh
$ heroku buildpacks:add https://github.com/pmor/heroku-buildpack-geoip-geolite2.git
$ heroku config:set MAXMIND_LICENSE_KEY=<your-licence-key>
$ heroku config:set GEOLITE_DB_NAME=<'City' or 'Country'>
# optionally disable libmaxminddb installation
$ heroku config:set LIBMAXMINDDB_INSTALL='false'
# optionally set libmaxminddb version for installation
# the latest version will be installed if not set
$ heroku config:set LIBMAXMINDDB_VERSION='1.4.2'
```

The buildpack sets the variable ``GEOIP_DB_PATH`` with the path of the chosen Geolite2 database.

## Credits

&copy; 2020 Pedro Moreira

Forked from https://github.com/danstiner/heroku-buildpack-geoip-geolite2 and integrates
ideas from https://github.com/voomflights/heroku-buildpack-maxmind-geolite2

This product includes GeoLite2 data created by MaxMind, available from http://www.maxmind.com.

Released under the MIT License.
