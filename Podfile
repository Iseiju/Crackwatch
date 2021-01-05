# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Crackwatch' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Crackwatch
  pod 'Alamofire', '~> 5.4.0'
  pod 'Kingfisher', '~> 5.15.7'
  pod 'R.swift', '~> 5.2.2'
  
  post_install do |pi|
      pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
      end
  end

  target 'CrackwatchTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CrackwatchUITests' do
    # Pods for testing
  end

end
