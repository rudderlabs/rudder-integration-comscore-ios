require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

comscore_version = '~> 6.0'
rudder_sdk_version = '~> 1.23'

Pod::Spec.new do |s|
  s.name             = 'Rudder-Comscore'
  s.version          = package['version']
  s.summary          = 'Privacy and Security focused Segment-alternative. Comscore Native SDK integration support.'

  s.description      = <<-DESC
Rudder is a platform for collecting, storing and routing customer event data to dozens of tools. Rudder is open-source, can run in your cloud environment (AWS, GCP, Azure or even your data-centre) and provides a powerful transformation framework to process your event data on the fly.
                       DESC

  s.homepage         = 'https://github.com/rudderlabs/rudder-integration-comscore-ios'
  s.license          = { :type => "Apache", :file => "LICENSE.md" }
  s.author           = { 'RudderStack' => 'sdk@rudderstack.com' }
  s.source           = { :git => 'https://github.com/rudderlabs/rudder-integration-comscore-ios.git', :tag => "v#{s.version}" }
  s.static_framework = true

  s.ios.deployment_target = '12.0'
  s.source_files = 'Rudder-Comscore/Classes/**/*'

  if defined?($ComscoreVersion)
    Pod::UI.puts "#{s.name}: Using user specified Comscore SDK version '#{$ComscoreVersion}'"
    comscore_version = $ComscoreVersion
  else
    Pod::UI.puts "#{s.name}: Using default Comscore SDK version '#{comscore_version}'"
  end
  
  if defined?($RudderSDKVersion)
      Pod::UI.puts "#{s.name}: Using user specified Rudder SDK version '#{$RudderSDKVersion}'"
      rudder_sdk_version = $RudderSDKVersion
  else
      Pod::UI.puts "#{s.name}: Using default Rudder SDK version '#{rudder_sdk_version}'"
  end

  s.dependency 'Rudder', rudder_sdk_version
  s.dependency 'ComScore', comscore_version
end
