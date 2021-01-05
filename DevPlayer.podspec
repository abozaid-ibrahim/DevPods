Pod::Spec.new do |s|

  s.name             = 'DevPlayer'
  s.version          = '0.0.1'
  s.summary          = 'A short description of Network.'
  s.swift_version    = '5.0'


  s.description      = "this is a group of extensions for apps, used as private pod, it contains extensions for Foundation, UIKit, AVFoundation,...etc you could add to these extensions whatever you want while you develop your app"

  s.homepage         = 'https://github.com/abuzeid-ibrahim/DevPods.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'abuzeid-ibrahim' => 'abuzeid7@gmail.com' }
  s.source           = { :git => 'https://github.com/abuzeid-ibrahim/DevPods.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.source_files = 'DevPlayer/*.{swift,h,m}'
  
 s.dependency 'RxSwift'
 s.dependency 'RxCocoa'
 # s.dependency 'DevExtensions', :path => './DevExtensions.podspec'
end