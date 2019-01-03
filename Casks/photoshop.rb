cask 'photoshop' do
#  version '1.1.2'
  sha256 '3cb3be0b2e5278d4eb27b3265a4a67044a2c1e11bc902fc15a6a237833dcc6e8'

  # github.com/sequelpro/sequelpro was verified as official when first introduced to the cask
  url "http://10.10.4.242/Adobe%20Photoshop.dmg"
#  appcast 'https://github.com/sequelpro/sequelpro/releases.atom'
  name 'Adobe Photoshop'
  homepage 'https://www.sequelpro.com/'

  depends_on macos: '>= :leopard'

  app 'Adobe Photoshop.app'

end
