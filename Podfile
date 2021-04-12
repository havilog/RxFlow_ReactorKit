# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Practice_RxFlow' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Practice_RxFlow

  pod 'RxFlow'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'ReactorKit'

  target 'Practice_RxFlowTests' do
    inherit! :search_paths
    # Pods for testing

    pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest']

  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
