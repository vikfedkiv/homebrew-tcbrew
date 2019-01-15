class Photoshop < Cask

  url do
    require_relative 'url'
    $url+'/Adobe%20Photoshop.dmg'
  end
  homepage 'https://testtc.com'
  version '201901'  
  no_checksum
  link 'Photoshop.app'
end