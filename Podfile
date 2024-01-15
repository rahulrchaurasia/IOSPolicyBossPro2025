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
   pod 'WebEngage'
   
   pod 'WEPersonalization'
   pod 'WebEngageBannerPush'
   pod 'WebEngageAppEx/ContentExtension'
   
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
    # some older pods don't support some architectures, anything over iOS 11 resolves that
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      
      xcconfig_relative_path = "Pods/Target Support Files/#{target.name}/#{target.name}.#{config.name}.xcconfig"
         file_path = Pathname.new(File.expand_path(xcconfig_relative_path))
         next unless File.file?(file_path)
         configuration = Xcodeproj::Config.new(file_path)
         next if configuration.attributes['LIBRARY_SEARCH_PATHS'].nil?
         configuration.attributes['LIBRARY_SEARCH_PATHS'].sub! 'DT_TOOLCHAIN_DIR', 'TOOLCHAIN_DIR'
         configuration.save_as(file_path)
    end
  end
end
