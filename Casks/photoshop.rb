class Photoshop < Cask
  url do
    require 'open-uri'
    base_url = open('url.txt') { |f| f.read }
    file = Adobe%20Photoshop.dmg
    "#{base_url}#{file}"
  end
  homepage 'https://testtc.com'
  version '201901'  
  no_checksum
  link 'Photoshop.app'
end