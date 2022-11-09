# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'here-draw-ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for here-draw-ios
  pod 'Alamofire', '~> 5.2'
  pod 'ImageSlideshow'
  pod 'KakaoSDK'
  pod 'Kingfisher'
  pod 'lottie-ios'
  pod 'Pageboy'
  pod 'SnapKit'
  pod 'Tabman'
  pod 'Then'
  pod 'IQKeyboardManager'
  pod 'StompClientLib'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
  end

end
