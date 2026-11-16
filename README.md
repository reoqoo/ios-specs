# ios-specs

CocoaPods spec 仓库，收录技威（Gwell）iOS SDK 的 podspec。

## 收录的库

| Pod | 版本 | 来源 |
|---|---|---|
| `GWIoTKit` | 1.13.0.0 ~ 1.13.0.3 | 二进制托管于 https://gwiotkit-ios.reoqoo.com |
| `AFNetworking` | 4.0.1-gwell.1 | 源码 https://github.com/reoqoo/iOS （Xcode 26 兼容修复） |

## 使用方式

```ruby
platform :ios, '15.0'

source 'https://cdn.cocoapods.org/'
source 'https://github.com/reoqoo/ios-specs.git'

target 'YourApp' do
  use_frameworks! :linkage => :static

  pod 'GWIoTKit', '1.13.0.3', :subspecs => ['Core', 'RQIAPKit']
  pod 'AFNetworking', '4.0.1-gwell.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
```

首次使用需要注册仓库：

```bash
pod repo add ios-specs https://github.com/reoqoo/ios-specs.git
```

## 注意事项

- **AFNetworking 必须写死版本号**。因为 CocoaPods 官方 trunk 上也有 `AFNetworking 4.0.1`，
  不写版本会被官方版本抢走。
  正确：`pod 'AFNetworking', '4.0.1-gwell.1'`
  错误：`pod 'AFNetworking'` → 会装成官方 4.0.1（无 Xcode 26 修复）

- **GWIoTKit 版本须 ≥ 1.13.0.1**。`1.13.0.0` 在官方 trunk 上也有同名版本，
  同时配置两个 source 时会报 `Found multiple specifications`。
