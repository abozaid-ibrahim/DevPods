Pod::Spec.new do |s|

  s.name             = 'DevNetwork'
  s.version          = '0.0.21'
  s.summary          = 'A short description of Network.'
  s.swift_version    = '5.0'


  s.description      = "this is a group of extensions for apps, used as private pod, it contains extensions for Foundation, UIKit, AVFoundation,...etc you could add to these extensions whatever you want while you develop your app"

 
  s.homepage         = 'https://github.com/abozaid-ibrahim/DevPods.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'abozaid-ibrahim' => 'abozaid.ibrahim11@gmail.com' }
  s.source           = { :git => 'https://github.com/abozaid-ibrahim/DevPods.git', :tag => s.version.to_s }
  s.default_subspec = "Core"
  s.ios.deployment_target = '11.0'
  #s.source_files = 'DevNetwork/*.{swift,h,m}'
 

 s.subspec "Core" do |ss|
    ss.source_files   = 'DevNetwork/Core/*.{swift,h,m}'
  end

  s.subspec "Rx" do |rx|
    rx.source_files   = 'DevNetwork/Rx/*.{swift,h,m}'
    rx.dependency 'RxSwift', '6.0.0'
    rx.dependency 'RxCocoa', '6.0.0'
    rx.dependency 'DevNetwork/Core'
  end

  s.subspec "Combine" do |cm|
    cm.source_files   = 'DevNetwork/Combine/*.{swift,h,m}'
    cm.dependency 'DevNetwork/Core'
    cm.ios.deployment_target = '13.0'
  end
end
