Pod::Spec.new do |s|
  s.name = 'GcLog'
  s.version = '1.3'
  s.license = 'MIT'
  s.summary = 'Log shareable cURL to Developer Console, to Messenging Program (e.g. Telegram, Slack), and more (https://getcurl.app)'
  s.homepage = 'https://github.com/docsion/GcLogSwift'
  s.source           = { :git => 'https://github.com/docsion/GcLogSwift.git', :tag => s.version.to_s }
  s.author           = { 'thinhx' => 'ngocthinhdp@gmail.com' }
  s.documentation_url = 'https://github.com/docsion/GcLogSwift'
  s.social_media_url = 'https://twitter.com/GETCURL_APP'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.3', '5.4', '5.5']

  s.source_files = 'Sources/*.swift'
end
