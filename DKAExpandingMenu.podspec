#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "DKAExpandingMenu"
  s.version          = "1.0.0"
  s.summary          = "A button that expands to reveal more buttons for iOS."
  #s.description      = <<-DESC
  #                     An optional longer description of DKAExpandingMenu
#
 #                      * Markdown format.
  #                     * Don't worry about the indent, we strip it!
   #                    DESC
  s.homepage         = "https://github.com/kkarayannis/DKAExpandingMenu"
  s.screenshots      = "https://raw.githubusercontent.com/kkarayannis/DKAExpandingMenu/master/Assets/demo1.gif"
  s.license          = 'MIT'
  s.author           = { "Konstadinos Karayannis" => "konstadinos@karayannis.com" }
  s.source           = { :git => "https://github.com/kkarayannis/DKAExpandingMenu.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kkarayannis'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes/ios'
  #s.resources = 'Assets/*.png'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
