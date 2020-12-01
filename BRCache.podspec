Pod::Spec.new do |s|
  s.name         = "BRCache"
  s.version      = "1.0.0"
  s.summary      = "A type-safe key-value cache written in Swift."
  s.description  = <<-DESC
    BRCache is a key-value cache written in Swift.

    - Link caches with different key and value types.
    - Protocol based API. Create and combine caches as needed.
    - Clean, single-purpose implementation. Does caching and nothing else.
  DESC
  s.homepage     = "https://github.com/BjornRuud/BRCache"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Yr" => "brcache@bjornruud.net" }
  s.social_media_url   = ""
  s.ios.deployment_target = "12.0"
  s.osx.deployment_target = "10.12"
  s.watchos.deployment_target = "4.0"
  s.tvos.deployment_target = "12.0"
  s.source       = { :git => "https://github.com/BjornRuud/BRCache.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
