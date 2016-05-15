#
# Be sure to run `pod lib lint SCRatingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SCRatingView"
  s.version          = "0.1.0"
  s.summary          = "A nice and simple rating view with multiple rating images"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A nice and simple rating view with multiple rating images.Inspired by TPFloatRatingView
                       DESC

  s.homepage         = "https://github.com/devsujith/SCRatingView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "devsujith" => "dev.sujithchandran@gmail.com" }
  s.source           = { :git => "https://github.com/devsujith/SCRatingView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://www.linkedin.com/in/sujith-chandran-173b3727'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SCRatingView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SCRatingView' => ['SCRatingView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
