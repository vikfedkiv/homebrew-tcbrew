vikfedkiv/tcbrew 'sequel' do
  version '1.1.2'
  sha256 "88d4baeee461da524212ac703fff90d510eb8c9cb07b42ba5bf1ab1f54eaa8ba"
  url "http://10.10.4.242/sequel-pro-release-1.1.2.tar.gz"

  name 'Seqeul Pro'
  homepage 'https://flyingmeat.com/acorn/'

  app 'Sequel Pro.app'

  zap trash: [
               '~/Library/Application Support/Sequel Pro',
               '~/Library/Caches/com.sequelpro.SequelPro',
               '~/Library/Preferences/com.sequelpro.SequelPro.plist',
               '~/Library/Saved Application State/com.sequelpro.SequelPro.savedState',
	     ]

end