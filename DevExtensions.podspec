#
# Be sure to run `pod lib lint DevExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name             = 'DevExtensions'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DevExtensions.'
  s.swift_version    = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "this is a group of extensions for apps, used as private pod, it contains extensions for Foundation, UIKit, AVFoundation,...etc you could add to these extensions whatever you want while you develop your app"

  s.homepage         = 'https://github.com/abuzeid-ibrahim/DevPods.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'abuzeid-ibrahim' => 'abuzeid7@gmail.com' }
  s.source           = { :git => 'https://github.com/abuzeid-ibrahim/DevPods.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files = 'DevExtensions/DevExtensions/Classes/**/*'
  

  
  # s.resource_bundles = {
  #   'DevExtensions' => ['DevExtensions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
