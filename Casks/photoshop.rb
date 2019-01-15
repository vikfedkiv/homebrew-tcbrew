cask 'photoshop' do
  version :latest
  sha256 :no_check

  url do
    require 'open-uri'
    base_url = open('url.txt') { |f| f.read }
    file = test.dmg
    "#{base_url}#{file}"
  end

  name 'Photoshop'
  homepage 'https://www.testtc.com/'

  app 'Photoshop.app'
end
