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
  pod 'AFNetworking', '4.0.1-gwell.1'   # ← 这一行不能省，见下方说明
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
```

仓库是 public，`pod install` 会自动 clone，**不需要** `pod repo add`。

## ⚠️ 必须写 `pod 'AFNetworking', '4.0.1-gwell.1'`

**这是最容易踩的坑，漏掉会导致编译失败。**

GWIoTKit 内部声明了 `s.dependency 'AFNetworking', '~> 4.0'`，
而三个版本的优先级是：

```
4.0.1-gwell.1  <  4.0.1  <  4.0.1.1
   (prerelease，优先级最低)   (官方 trunk)
```

`~> 4.0` 同时满足三者，CocoaPods 会选**版本号最大**的 = 官方 `4.0.1`。
官方版没有 Xcode 26 修复，编译时报错：

```
error: Use of private header from outside its module: 'netinet6/in6.h'
(in target 'AFNetworking' from project 'Pods')
```

因为 `4.0.1-gwell.1` 是 prerelease，**只有显式写死版本号才能选中**：

| 写法 | 结果 |
|---|---|
| `pod 'AFNetworking', '4.0.1-gwell.1'` | ✅ 正确 |
| `pod 'AFNetworking', '>= 4.0.1-gwell.1'` | ✅ 正确 |
| 不写 AFNetworking 这一行 | ❌ 装成官方 4.0.1，编译失败 |

检查方式：`pod install` 后确认输出里有
`Installing AFNetworking (4.0.1-gwell.1)`，而不是 `4.0.1`。

## 其他注意事项

- **GWIoTKit 版本须 ≥ 1.13.0.1**。`1.13.0.0` 在官方 trunk 上也有同名版本，
  会报 `Found multiple specifications`。

- **Xcode 26 需关闭 User Script Sandboxing**。命令行构建加
  `ENABLE_USER_SCRIPT_SANDBOXING=NO`，Xcode 里在 Build Settings 搜
  "User Script Sandboxing" 设为 `NO`。

- **模拟器 arm64 被排除**。podspec 配了
  `EXCLUDED_ARCHS[sdk=iphonesimulator*] = arm64`，
  Apple Silicon 上调试需用真机。
