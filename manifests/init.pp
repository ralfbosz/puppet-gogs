class gogs (

  Stdlib::Ensure::Service    $service_ensure,
  String                     $service_name,
  Boolean                    $manage_packages,
  Boolean                    $enable_puppetstats,
  String                     $version,
  Stdlib::Unixpath           $installation_directory,
  Stdlib::Unixpath           $repository_root,
  Boolean                    $manage_user,
  Boolean                    $manage_home,
  String                     $owner,
  String                     $group,
  Optional[Stdlib::Unixpath] $home,
  Optional[Hash]             $app_ini,
  Optional[Hash]             $app_ini_sections,
  Optional[Hash]             $sysconfig,
  Optional[Stdlib::Unixpath] $log_path,
) {

  puppetstats { 'kschu91-gogs': enabled => $enable_puppetstats }

  if !($facts['os']['name'] in [ 'RedHat', 'OracleLinux', 'CentOS', 'Debian', 'Ubuntu' ]) {
    warning("${facts['os']['name']} not supported yet: Gogs might not running as expected!")
  }

  anchor { 'gogs::begin': }
  -> class { '::gogs::variables': }
  -> class { '::gogs::packages': }
  -> class { '::gogs::user': }
  -> class { '::gogs::install': }
  -> class { '::gogs::app_ini': }
  -> class { '::gogs::service': }
  -> anchor { 'gogs::end': }
}

