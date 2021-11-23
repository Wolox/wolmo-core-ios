Pod::Spec.new do |spec|

  spec.name         = "WolmoCore"
  spec.version      = "6.0.0"
  spec.summary      = "Extensions and utilities for iOS commonly used at Wolox."
  spec.description  = <<-DESC
WOLMO Core iOS is a framework which provides extensions and utilities for iOS commonly used at Wolox.

At Wolox, we complement this framework with Wolmo - Reactive Core.
                   DESC
  spec.homepage     = "https://github.com/Wolox/wolmo-core-ios/"
  spec.license      = { :type => "MIT", :file => "LICENSE.txt" }
  spec.author             = "Wolox"
  spec.ios.deployment_target = "12.0"
  spec.source       = { :git => "https://github.com/Wolox/wolmo-core-ios.git", :tag => "v#{spec.version}" }
  spec.source_files  = "WolmoCore/**/*.{h,m,swift}"
  spec.exclude_files = "WolmoCoreDemo", "AnimationDemo", "WolmoCoreTests"
  spec.swift_versions = "5.0"

end