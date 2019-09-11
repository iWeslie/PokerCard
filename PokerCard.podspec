Pod::Spec.new do |s|
  s.name         = "PokerCard"
  s.version      = "0.0.1"
  s.summary      = "A new generation of Alert View with fluid design."
  s.homepage     = "https://github.com/iWeslie/PokerCard"
  s.license      = "MIT"
  s.author             = { "iWeslie" => "iwesliechen@gmail.com" }
  s.social_media_url   = "http://www.iweslie.com/index.php/archives/122/"
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.source       = { :git => "https://github.com/iWeslie/PokerCard.git", :tag => s.version.to_s }
  s.source_files = 'Sources/**/*'
  s.framework  = "UIKit"
end
