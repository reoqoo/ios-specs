Pod::Spec.new do |s|
    s.name             = 'GWIoTKit'
    s.version          = '1.13.0.3'
    s.summary          = 'Frameworks of Gwell surveillances functions packaging'

    s.description      = 'Gwell surveillances functions packaging'
    s.homepage         = 'https://github.com/reoqoo/gwiotapi.git'
    s.author           = { 'Gwell' => 'ios@gwell.cc' }
    s.source           = { :http => "https://gwiotkit-ios.reoqoo.com/Frameworks-#{s.version}.zip", :type => "zip" }
    s.ios.deployment_target = '15.0'
    s.static_framework = true
    s.libraries        = 'c++', 'xml2'
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    s.swift_versions = "5.1"

    s.frameworks = 'CoreAudio', 'AudioToolbox', 'VideoToolbox', 'CoreBluetooth', 'Combine'

    s.dependency 'SDWebImage', '~> 5.18.12'
    s.dependency 'lottie-ios', '~> 4.5.2'
    s.dependency 'SnapKit', '~> 5.7.1'
    s.dependency 'AFNetworking', '~> 4.0'
    s.dependency 'SSZipArchive', '~> 2.4.3'
    s.dependency 'Then', '~> 3.0.0'
    s.dependency 'R.swift', '~> 7.8.0'
    s.dependency 'CombineCocoa', '~> 0.4.1'
    s.dependency 'CombineExt', '~> 1.8.0'
    s.dependency 'Kingfisher', '~> 8'
    s.dependency 'CryptoSwift', '~> 1.8.3'
    s.dependency 'EmptyDataSet-Swift', '~> 5.0.0'
    s.dependency 'Codextended', '~> 0.3.0'
    s.dependency 'MJRefresh', '~> 3.7.9'
    s.dependency 'MBProgressHUD', '~> 1.2.0'
    s.dependency 'RTRootNavigationController', '~> 0.8.1'
    s.dependency 'Popover', '~> 1.3.0'
    s.dependency 'SwiftyJSON', '~> 5.0.2'
    s.dependency 'QCloudCore', '~> 6.5.1'
    s.dependency 'QCloudCOSXML', '~> 6.5.1'
    s.dependency 'QTEventBus', '~> 0.4.1'
    s.dependency 'ReactiveCocoa', '~> 12.0.0'
    s.dependency 'ReactiveSwift', '~> 7.2.1'
    s.dependency 'CZImagePreviewer'
    s.dependency 'FMDB', '~> 2.7.12'
    s.dependency 'Realm', '~> 20.0.3' # 数据库
    s.dependency 'RealmSwift', '~> 20.0.3' # 数据库
    s.dependency 'MMKV', '~> 2.2.4'

    s.subspec 'Core' do |ss|
        ss.vendored_frameworks = 'Frameworks/required_frameworks/**/*.framework', 
                                 'Frameworks/GWIoTApi/**/*.xcframework',
                                 'Frameworks/GWStatistics/**/*.xcframework',
                                 'Frameworks/gwxlog/**/*.xcframework',
                                 'Frameworks/xt-GWWebrtc/**/*.framework',
                                 'Frameworks/ASAisr/**/*.framework',
                                 'Frameworks/composeApp/**/*.xcframework'

        ss.vendored_libraries = 'Frameworks/gw_openssl/**/*.a',
                                'Frameworks/gw-opencore-amr/**/*.a',
                                'Frameworks/libp2p/**/*.a',
                                'Frameworks/GWFFmpeg/**/*.a',
                                'Frameworks/curl/**/*.a',
                                'Frameworks/IoTVideo/**/*.a'

        ss.resource = 'Frameworks/**/*.bundle'
    end

    s.subspec 'RQIAPKit' do |ss|
        ss.vendored_frameworks = 'Frameworks/optional_frameworks/RQIAPKit/**/*.framework'
    end

    s.subspec 'ReoqooKit' do |ss|
        ss.vendored_frameworks = 'Frameworks/optional_frameworks/ReoqooKit/**/*.framework'
    end

    s.default_subspec = 'Core'

  end


