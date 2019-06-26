#
#  Be sure to run `pod spec lint CKHCrashPreventor.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = 'CKHCrashPreventor'
  s.version      = '1.0.6'
  s.summary      = 'Crash Preventor and print log'
  s.homepage     = 'https://github.com/KenwayCen/CKHCrashPreventor'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'KC' => '1250578320@qq.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/KenwayCen/CKHCrashPreventor.git', :tag => 'v1.0.6' }
  s.social_media_url   = 'https://github.com/KenwayCen/CKHCrashPreventor'
  s.source_files  = 'CKHCrashPreventor/CrashPreventor/*.{h,m}'
  s.requires_arc = true
  s.requires_arc = ['CKHCrashPreventor/CrashPreventor/*']
  s.description  = <<-DESC
                    iOS 中常见的Crash 类型，利用runtime 进行过滤处理
                   DESC

end
