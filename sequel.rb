  url "https://github.com/sequelpro/sequelpro/releases/download/release-#{version}/sequel-pro-#{version}.dmg"
  appcast 'https://github.com/sequelpro/sequelpro/releases.atom'
  name 'Sequel Pro'
  homepage 'https://www.sequelpro.com/'

  depends_on macos: '>= :leopard'

  app 'Sequel Pro.app'

  zap trash: [
               '~/Library/Application Support/Sequel Pro',
               '~/Library/Caches/com.sequelpro.SequelPro',
               '~/Library/Preferences/com.sequelpro.SequelPro.plist',
               '~/Library/Saved Application State/com.sequelpro.SequelPro.savedState',
             ]
end
