cask 'photoshop' do
  version :latest
  sha256 :no_check

  url do
    require_relative './url.txt'
    $url+'test.dmg'
  end

  name 'Photoshop'
  homepage 'https://www.testtc.com/'

  app 'Photoshop.app'
end
