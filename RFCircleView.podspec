#
# Be sure to run `pod lib lint RFCircleView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RFCircleView'
  s.version          = '0.1.0'
  s.summary          = 'Universal Circle View for iOS, written in Swift & Autolayout'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Universal Circle View for iOS, written in Swift 3.0 & Autolayout. Uses Core Graphics Drawing and provides flexible appearance settings
                       DESC

  s.homepage         = 'https://github.com/filiroman/RFCircleView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'filiroman' => 'filiroman.tsu@gmail.com' }
  s.source           = { :git => 'https://github.com/filiroman/RFCircleView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RFCircleView/Classes/**/*'

  # s.resource_bundles = {
  #   'RFCircleView' => ['RFCircleView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
