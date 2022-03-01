# == Class samba::server::params
#
class samba::server::params {
  case $facts['os']['family'] {
    'Redhat': {
      $service_name = 'smb'
      $nmbd_name = undef
    }
    'Debian': {
      case $facts['os']['name'] {
        'Debian': {
          case $facts['os']['release']['major'] {
            '7' : {
              $service_name = 'samba'
            }
            default: {
              $service_name = 'smbd'
            }
          }
          $nmbd_name = undef
        }
        'Ubuntu': {
          $service_name = 'smbd'
          $nmbd_name = 'nmbd'
        }
        default: {
          $service_name = 'smbd'
          $nmbd_name = undef
        }
      }
    }
    'Gentoo': {
      $service_name = 'samba'
      $nmbd_name = undef
    }
    'Archlinux': {
      $service_name = 'smbd'
      $nmbd_name = 'nmbd'
    }
    default: {
      fail("${facts['os']['family']} is not supported by this module.")
    }
  }
}
