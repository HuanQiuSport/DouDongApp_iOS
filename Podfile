# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# 下面两行是指明依赖库的来源地址
source 'https://github.com/CocoaPods/Specs.git'# 使用官方默认地址（默认）
source 'https://github.com/Artsy/Specs.git'# 使用其他来源地址

# install! 只走一次，多次使用只以最后一个标准执行
# deterministic_uuids 解决与私有库的冲突
# generate_multiple_pod_projects 可以让每个依赖都作为一个单独的项目引入，大大增加了解析速度；cocoapods 1.7 以后支持
# disable_input_output_paths ？？？
# 需要特别说明的：在 post_install 时，为了一些版本的兼容，需要遍历所有 target，调整一部分库的版本；但是如果开启了 generate_multiple_pod_projects 的话，由于项目结构的变化，installer.pod_targets 就没办法获得所有 pods 引入的 target 了
install! 'cocoapods',:deterministic_uuids=>false,generate_multiple_pod_projects: true,disable_input_output_paths: true

platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
#pod 'CocoaAsyncSocket'
# 特别说明：Ruby对大小写敏感，所以方法名不要用大写，否则执行失败

# 调试框架
def debugPods
  pod 'DoraemonKit' # https://github.com/didi/DoraemonKit 滴滴打车出的工具 NO_SMP
#  pod 'CocoaDebug' # https://github.com/CocoaDebug/CocoaDebug NO_SMP
  pod 'FLEX'  # https://github.com/Flipboard/FLEX 调试界面相关插件 NO_SMP
  pod 'JJException' # https://github.com/jezzmemo/JJException 保护App,一般常见的问题不会导致闪退，增强App的健壮性，同时会将错误抛出来，根据每个App自身的日志渠道记录 NO_SMP
  pod 'FBRetainCycleDetector' # https://github.com/facebook/FBRetainCycleDetector
  end
# 几乎每个App都会用到的
def appCommon
  pod 'Masonry' # https://github.com/SnapKit/Masonry NO_SMP
  pod 'AFNetworking' # https://github.com/AFNetworking/AFNetworking YES_SMP
  pod 'Reachability'  # https://github.com/tonymillion/Reachability 检查联网情况 NO_SMP
  pod 'IQKeyboardManager' # https://github.com/hackiftekhar/IQKeyboardManager Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more.  YES_SMP
  pod 'ReactiveObjC' # https://github.com/ReactiveCocoa/ReactiveObjC NO_SMP
  pod 'MJRefresh' # https://github.com/CoderMJLee/MJRefresh NO_SMP
  pod 'MJExtension' # https://github.com/CoderMJLee/MJExtension NO_SMP
  pod 'SDWebImage' # https://github.com/SDWebImage/SDWebImage YES_SMP
  pod 'YYKit' # https://github.com/ibireme/YYKit NO_SMP
=======
target 'MonkeyKingVideo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
#  pod 'FLEX'  # https://github.com/Flipboard/FLEX 调试界面相关插件
#  pod 'YYText'
#  pod 'SDWebImage/WebP' # https://github.com/SDWebImage/SDWebImageWebPCoder A WebP coder plugin for SDWebImage, use libwebp
#  pod 'BSYKeyBoard' # https://github.com/baishiyun/BSYKeyBoard
#  pod 'BRPickerView' # https://github.com/91renb/BRPickerView 该组件封装的是iOS中常用的选择器组件，主要包括：日期选择器、时间选择器（DatePickerView）、地址选择器（AddressPickerView）、自定义字符串选择器（StringPickerView）。支持自定义主题样式，适配深色模式，支持将选择器组件添加到指定容器视图。
#  pod 'FMDB/SQLCipher' # 数据库加解密
#  pod 'PureLayout'
#  pod 'MyLayout'
#  pod 'RQShineLabel'  # https://github.com/zipme/RQShineLabel 一个类似Secret文字渐变效果的开源库
#  pod 'LBXScan' # https://github.com/MxABC/LBXScan iOS 二维码、条形码
#  pod 'LBXScan/LBXNative'
#  pod 'LBXScan/LBXZXing'
#  pod 'LBXScan/LBXZBar'
#  pod 'LBXScan/UI'
#  pod 'MLeaksFinder'
  pod 'WXSTransition' # https://github.com/alanwangmodify/WXSTransition 这是一个界面转场动画集。 目前只支持纯代码 已支持手势返回
  pod 'TWPageViewController'  # https://github.com/Easence/TWPageViewController 一个支持懒加载的PageViewController，用于替换iOS系统的UIPageViewController。可以用来实现类似腾讯新闻、今日头条的效果
  pod 'SocketRocket'  # https://github.com/facebookarchive/SocketRocket
  pod 'ReactiveObjC'  # https://github.com/ReactiveCocoa/ReactiveObjC 重量级框架
  pod 'FLAnimatedImageView+RGWrapper' # https://github.com/RengeRenge/FLAnimatedImageView-RGWrapper FLAnimatedImage是适用于iOS的高性能动画GIF引擎
  pod 'GKNavigationBar', '1.3.0'  # https://github.com/QuintGao/GKNavigationBar GKNavigationBarViewController的分类实现方式，耦合度底，使用更加便捷
  pod 'Masonry' # https://github.com/SnapKit/Masonry 布局
  pod 'AFNetworking'  # https://github.com/AFNetworking/AFNetworking A delightful networking framework for iOS, macOS, watchOS, and tvOS.
  pod 'Reachability'  # https://github.com/tonymillion/Reachability 检查联网情况
  pod 'MJRefresh' # https://github.com/CoderMJLee/MJRefresh An easy way to use pull-to-refresh
  pod 'MJExtension' # https://github.com/CoderMJLee/MJExtension A fast, convenient and nonintrusive conversion framework between JSON and model. Your model class doesn't need to extend any base class. You don't need to modify any model file.
  pod 'YYKit' # https://github.com/ibireme/YYKit A collection of iOS components.
  pod 'TXFileOperation' # https://github.com/xtzPioneer/TXFileOperation
  pod 'SDWebImage','5.9.4'  # https://github.com/SDWebImage/SDWebImage Asynchronous image downloader with cache support as a UIImageView category
  pod 'IQKeyboardManager' # https://github.com/hackiftekhar/IQKeyboardManager Codeless drop-in universal library allows to prevent issues of keyboard sliding up and cover UITextField/UITextView. Neither need to write any code nor any setup required and much more.

  pod 'OpenUDID'  # https://github.com/ylechelle/OpenUDID Open source initiative for a universal and persistent UDID solution for iOS
  end
## GK一族
def gk
  pod 'GKNavigationBar' # https://github.com/QuintGao/GKNavigationBar NO_SMP
  end
## JX一族
def jx
  pod 'JXCategoryView' # https://github.com/pujiaxin33/JXCategoryView NO_SMP
  pod 'JXPagingView/Pager' # https://github.com/pujiaxin33/JXPagingView NO_SMP
  end
## 提示框
def alert
  pod 'SPAlertController'# https://github.com/SPStore/SPAlertController 深度定制AlertController NO_SMP
  pod 'TFPopup'# https://github.com/shmxybfq/TFPopup 不耦合view代码,可以为已创建过 / 未创建过的view添加弹出方式;只是一种弹出方式;
  end
# UI相关
def ui
  pod 'SFProgressCircle'
  pod 'DZNEmptyDataSet'
  pod 'JDStatusBarNotification' # 网络提示--> 网络监听显示，主要是展示状态
  pod 'HBDNavigationBar'  # https://github.com/listenzz/HBDNavigationBar 自定义UINavigationBar，用于在各种状态之间平滑切换，包括条形样式，条形色调，背景图像，背景alpha，条形隐藏，标题文本属性，色调颜色，阴影隐藏...
  pod 'UICountingLabel' # https://github.com/dataxpress/UICountingLabel Lable上的默认值持续变动到指定值 Adds animated counting support to UILabel.
  pod 'AYCheckVersion'  # https://github.com/AYJk/AYCheckVersion 提示更新 Check version from AppStore / 从AppStore检查更新
  pod 'DDProgressView'  # https://github.com/ddeville/DDProgressView 加载状态显示 A custom UIProgressView à la Twitter for iPhone
  pod 'HCSStarRatingView' # https://github.com/hsousa/HCSStarRatingView 星级评分显示 Simple star rating view for iOS written in Objective-C
  pod 'TXScrollLabelView' # https://github.com/tingxins/TXScrollLabelView “走马灯”效果 TXScrollLabelView, the best way to show & display information such as adverts / boardcast / onsale e.g. with a customView.
  pod 'BEMCheckBox' # https://github.com/Boris-Em/BEMCheckBox 复选框 更炫 Tasteful Checkbox for iOS
  pod 'WXSTransition' # https://github.com/alanwangmodify/WXSTransition 这是一个界面转场动画集。 目前只支持纯代码 已支持手势返回
  pod 'MGSwipeTableCell' # https://github.com/MortimerGoro/MGSwipeTableCell 滑动tableViewCell
  pod 'Shimmer' # Facebook 推出的一款具有闪烁效果的第三方控件
  pod 'RQShineLabel'  # https://github.com/zipme/RQShineLabel 一个类似Secret文字渐变效果的开源库
  pod 'SZTextView' # https://github.com/glaszig/SZTextView SZTextView 用于替代内置的 UITextView，实现了 placeholder
  pod 'BRPickerView'  # https://github.com/91renb/BRPickerView 该组件封装的是iOS中常用的选择器组件，主要包括：日期选择器、时间选择器（DatePickerView）、地址选择器（AddressPickerView）、自定义字符串选择器（StringPickerView）。支持自定义主题样式，适配深色模式，支持将选择器组件添加到指定容器视图。
  pod 'LYEmptyView' # https://github.com/dev-liyang/LYEmptyView iOS一行代码集成空白页面占位图(无数据、无网络占位图)

#  pod 'ZZCircleProgress' # https://github.com/zhouxing5311/ZZCircleProgress 可以高度自定义的环形进度条 我用手动pods管理
  pod 'FLAnimatedImageView+RGWrapper' # https://github.com/RengeRenge/FLAnimatedImageView-RGWrapper FLAnimatedImage是适用于iOS的高性能动画GIF引擎
  pod 'PPBadgeView' # https://github.com/jkpang/PPBadgeView iOS自定义Badge组件, 支持UIView, UITabBarItem, UIBarButtonItem以及子类 NO_SMP
  pod 'WHToast' # https://github.com/remember17/WHToast 一个轻量级的提示控件，没有任何依赖 NO_SMP
#  pod 'WMZBanner' # https://github.com/wwmz/WMZBanner WMZBanner - 最好用的轻量级轮播图+卡片样式+自定义样式 NO_SMP 我用手动pods管理
  gk # GK一族
  jx # JX一族
  alert # 提示框
  
  end
# 视频相关
def videoFunc
  pod 'GPUImage'
  pod 'ZFPlayer'
  pod 'ZFPlayer/ControlView'
  pod 'ZFPlayer/AVPlayer'
  pod 'ZFPlayer/ijkplayer'
=======
#  pod 'TZImagePickerController' # https://github.com/banchichen/TZImagePickerController 一个支持多选，选原图和视频的图片选择器，同时有预览，裁剪功能，支持iOS6 +。一个UIImagePickerController的克隆，支持挑选多张照片，原始照片，视频，还允许预览照片和视频，支持iOS6 +
  pod 'JPImageresizerView','1.7.7' # https://github.com/Rogue24/JPImageresizerView 一个专门裁剪图片、GIF、视频的轮子，简单易用，功能丰富（高自由度的参数设定、支持旋转和镜像翻转、蒙版、压缩等），能满足绝大部分裁剪的需求。
  pod 'LYXAlertController' # https://github.com/liuyunxinok/LYXAlertController 为解决UIAlertController的UI（字体颜色，action背景色,字体大小等）设置局限，故自己封装一个YXAlertController，可以随意进行颜色和字体设置。样式大小，title和message的行距缩进与系统样式保持一致。
  pod 'SPAlertController'# https://github.com/SPStore/SPAlertController 深度定制AlertController
  pod 'DZNEmptyDataSet'
#  pod 'FBMemoryProfiler' # https://github.com/facebook/FBMemoryProfiler An iOS library providing developer tools for browsing objects in memory over time, using FBAllocationTracker and FBRetainCycleDetector.
  pod 'JJException' # https://github.com/jezzmemo/JJException Protect the objective-c application(保护App不闪退)
#  pod 'KSYMediaPlayer_iOS', :path => './LocalLib/download/' # https://github.com/ksvc/KSYMediaPlayer_iOS
  pod 'ksyhttpcache'
  pod 'JSONModel'
  pod 'GPUImage'
  pod 'SZTextView' # https://github.com/glaszig/SZTextView SZTextView 用于替代内置的 UITextView，实现了 placeholder 功能。, '~> 1.3'
  pod 'LKDBHelper','2.5.5' # https://github.com/li6185377/LKDBHelper-SQLite-ORM
  pod 'YQImageCompressor' # https://github.com/976431yang/YQImageCompressor iOS端简易图片压缩工具
  pod 'SVProgressHUD' # https://github.com/SVProgressHUD/SVProgressHUD 是一个弹出提示层，用来提示 网络加载 或 提示对错 A clean and lightweight progress HUD for your iOS and tvOS app
  pod 'lottie-ios','2.5.3'
  pod 'SFProgressCircle'
#  pod 'ZZCircleProgress'
#  pod 'WMZBanner'
  pod 'PPBadgeView' #https://github.com/jkpang/PPBadgeView iOS自定义Badge组件, 支持UIView, UITabBarItem, UIBarButtonItem以及子类
  pod 'XHLaunchAd' # https://github.com/CoderZhuXH/XHLaunchAd 开屏广告、启动广告解决方案-支持静态/动态图片广告/mp4视频广告
  pod 'KTVHTTPCache', '~> 2.0.0'
#  pod 'ZFPlayer'
#  pod 'ZFPlayer/ControlView'
#  pod 'ZFPlayer/AVPlayer'
#  pod 'ZFPlayer/ijkplayer'

#  pod 'KTVHTTPCache' # 边下边播
#  pod 'VIMediaCache' # https://github.com/vitoziv/VIMediaCache 边下边播
  end
# 一些功能性
def func
  pod 'TXFileOperation' # 文件夹操作
  pod 'TZImagePickerController'## 相册选择
  pod 'JPImageresizerView' # https://github.com/Rogue24/JPImageresizerView 一个专门裁剪图片、GIF、视频的轮子，简单易用，功能丰富（高自由度的参数设定、支持旋转和镜像翻转、蒙版、压缩等），能满足绝大部分裁剪的需求。
  pod 'lottie-ios', '~> 2.5.3' # 这是OC终极版本
  pod 'YQImageCompressor' # https://github.com/976431yang/YQImageCompressor iOS端简易图片压缩工具
  pod 'JSONModel'
  videoFunc # 视频相关
  end
# 基础的公共配置
def cocoPodsConfig
  target 'MonkeyKingVideoTests' do
    inherit! :search_paths # abstract! 指示当前的target是抽象的，因此不会直接链接Xcode target。与其相对应的是 inherit！
    # Pods for testing
    end
  
  target 'MonkeyKingVideoUITests' do
    inherit! :search_paths
    # Pods for testing
    end
  
  # 当我们下载完成，但是还没有安装之时，可以使用hook机制通过pre_install指定要做更改，更改完之后进入安装阶段。 格式如下：
  pre_install do |installer|
      # 做一些安装之前的更改
    end
  
  # 这个是cocoapods的一些配置,官网并没有太详细的说明,一般采取默认就好了,也就是不写.
  post_install do |installer|
    installer.pods_project.targets.each do |target|

      # 当我们安装完成，但是生成的工程还没有写入磁盘之时，我们可以指定要执行的操作。 比如，我们可以在写入磁盘之前，修改一些工程的配置：

      puts "!!!! #{target.name}"
      end
    end
  end

# 由上而下编译，不像OC那么智能，故只能先写定义后调用
target 'MonkeyKingVideo' do
  # Pods for UBallLive
  debugPods # 调试框架
  appCommon # 几乎每个App都会用到的
  ui # UI相关
  func # 一些功能性
  
  cocoPodsConfig # 基础的公共配置
end

