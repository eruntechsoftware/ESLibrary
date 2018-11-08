
Pod::Spec.new do |s|

  s.name         = "ESLibrary"

  s.version      = "1.2.8"

  s.summary      = "A ESLibrary to use ourself"

  s.homepage = "https://github.com/eruntechsoftware/ESLibrary"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "信软科技" => "eruntechsoftware@126.com" }

  s.platform     = :ios
s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/eruntechsoftware/ESLibrary.git", :tag => s.version }
s.frameworks = "Foundation", "UIKit"
  s.library   = "sqlite3"
s.dependency 'MJRefresh'
s.dependency 'Toast'
s.dependency 'ReactiveObjC'
s.dependency 'SDWebImage'

  #s.public_header_files = "ESLibrary/Base/ViewController/ESLibraryHeaderFiles.h"

  s.source_files  = "ESLibrary/**/*.{h,m}"

  s.requires_arc = true

  s.dependency "MJRefresh"

end
