class Sequel < Formula
  desc ""
  homepage ""
  url "http://10.10.4.242/sequel-pro-1.1.2.dmg"

  app 'Sequel Pro.app'

  zap trash: [
               '~/Library/Application Support/Sequel Pro',
               '~/Library/Caches/com.sequelpro.SequelPro',
               '~/Library/Preferences/com.sequelpro.SequelPro.plist',
               '~/Library/Saved Application State/com.sequelpro.SequelPro.savedState',
	     ]
end