cask 'photoshop' do
  version :latest
  sha256 :no_check

  url do
    require "open-uri"
    html = open("http://10.10.0.134/url.txt").read
    "#{html}test.dmg"
  end

  name 'Photoshop'
  homepage 'https://www.testtc.com/'

  app 'Photoshop.app'
end
