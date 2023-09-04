#
# Be sure to run `pod lib lint TaniwhaTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TaniwhaTextField'
  s.version          = '1.5.2'
  s.summary          = 'TaniwhaTextField is a lightweight and beautiful swift textfield framework. And also you can highly customize it.'
  s.description      = 'TaniwhaTextField is a lightweight and beautiful swift textfield framework. And also you can highly customize it. Long-term support for sure.'

  s.homepage         = 'https://github.com/iceman201/TaniwhaTextField'
  #s.screenshots     = 'github.com/iceman201/TaniwhaTextField/blob/master/Example/taniwhaTextfield.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liguo jiao' => 'liguo@jiao.co.nz' }
  s.source           = { :git => 'https://github.com/iceman201/TaniwhaTextField.git', :tag => s.version.to_s }
  s.social_media_url = 'https://liguo.jiao.co.nz'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  s.source_files = 'TaniwhaTextField/Classes/TaniwhaTextField.swift'
  s.frameworks = 'UIKit'
end
