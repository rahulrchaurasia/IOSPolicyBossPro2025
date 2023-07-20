# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'policyBoss' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for policyBoss

  #  target 'policyBossTests' do
  #  inherit! :search_paths
    # Pods for testing
    # end

    #  target 'policyBossUITests' do
    # Pods for testing
    # end

   pod 'KYDrawerController'
   pod 'Alamofire', '4.9.1'
   pod 'SwiftyJSON'
   pod 'AlamofireImage'
   pod 'CustomIOSAlertView'
   pod 'TTGSnackbar'
   pod 'PopupDialog', '~> 0.5'
   pod 'CobrowseIO'
   pod 'SDWebImage/WebP'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
    # some older pods don't support some architectures, anything over iOS 11 resolves that
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
