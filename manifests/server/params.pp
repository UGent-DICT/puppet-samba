# == Class samba::server::params
#
class samba::server::params {
  case $::osfamily {
    'Redhat': { $service_name = 'smb' }
    'Debian': {
      case $::operatingsystem {
        'Debian': {
          case $::operatingsystemmajrelease {
            '8' : { $service_name = 'smbd' }
            default: { $service_name = 'samba' }
          }
        }
        'Ubuntu': {
          $service_name = 'smbd'
          $nmbd_name = 'nmbd'
        }
        default: { $service_name = 'samba' }
      }
    }
    'Gentoo': { $service_name = 'samba' }
    'Archlinux': {
      $service_name = 'smbd'
      $nmbd_name = 'nmbd'
    }
    default: { fail("${::osfamily} is not supported by this module.") }
  }
}
