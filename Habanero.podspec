Pod::Spec.new do |s|
  s.name             = 'Habanero'
  s.version          = '0.4.0'
  s.license          = { :type => 'Apache 2.0', :text => <<-LICENSE
      Copyright (c) Jarrod Parkes. All rights reserved.
      LICENSE
  }
  s.homepage         = 'https://jarrodparkes.com'
  s.summary          = 'A visual components library.'
  s.description      = <<-DESC
A library containing visual components.
                       DESC
  s.author           = { 'Jarrod Parkes' => 'parkesfjarrod@gmail.com' }
  s.source           = {
      :git => 'https://github.com/jarrodparkes/Habanero.git',
      :tag => s.version.to_s,
      :submodules => true
  }
  s.swift_versions = ['5.0']
  s.ios.deployment_target = '12.0'
  s.platform     = :ios, '12.0'
  s.static_framework = true
  s.source_files = 'Habanero/Classes/**/*.{swift}'
  s.dependency 'HorizonCalendar', '1.3.1'
  s.frameworks = 'Foundation', 'UIKit'
  s.resource_bundles = {
      'Habanero' => [
        'Habanero/Assets/**/*.{xib,xcassets,json,imageset,png,pdf,ttf}',
        'Habanero/Assets/Localization/*.lproj/*.strings'
      ]
    }
end
