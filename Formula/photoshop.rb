cask 'photoshop' do
  version :latest
  sha256 :no_check
  url "http://10.10.4.242:8081/test.dmg"
#  url do
#    require 'open-uri'
#    base_url = 'https://git.io/fhCUu'
#    file = open(base_url).read;
#    pack = 'test.dmg'
#    "#{file.strip}#{pack}"
#  end

  name 'Photoshop'
  homepage 'https://www.testtc.com/'

  app 'Photoshop.app'
end
