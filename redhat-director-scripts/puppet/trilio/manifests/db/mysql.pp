# == Class: trilio::db::mysql
#
# The trilio::db::mysql class creates a MySQL database for trilio datamover.
# It must be used on the MySQL server
#
# === Parameters
#
# [*password*]
#   (Required) password to connect to the database.
#
# [*dbname*]
#   (Optional) name of the database.
#   Defaults to 'dmapi'.
#
# [*user*]
#   (Optional) user to connect to the database.
#   Defaults to 'dmapi'.
#
# [*host*]
#   (Optional) the default source host user is allowed to connect from.
#   Defaults to 'localhost'
#
# [*allowed_hosts*]
#   (Optional) other hosts the user is allowed to connect from.
#   Defaults to undef.
#
# [*charset*]
#   (Optional) the database charset.
#   Defaults to 'utf8'
#
# [*collate*]
#   (Optional) the database collation.
#   Defaults to 'utf8_general_ci'
#
class trilio::db::mysql (
  $password,
  $dbname        = 'dmapi',
  $user          = 'dmapi',
  $host          = '127.0.0.1',
  $allowed_hosts = undef,
  $charset       = 'utf8',
  $collate       = 'utf8_general_ci',
) {


  include ::trilio::deps
  validate_legacy(String, 'validate_string', $password)

  ::openstacklib::db::mysql { 'trilio':
    user          => $user,
    password_hash => mysql::password($password),
    dbname        => $dbname,
    host          => $host,
    charset       => $charset,
    collate       => $collate,
    allowed_hosts => $allowed_hosts,
  }

  Anchor['trilio::db::begin']
  ~> Class['trilio::db::mysql']
  ~> Anchor['trilio::db::end']
}