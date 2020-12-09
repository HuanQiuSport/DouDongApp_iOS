//
//  Manual_Add_ThirdParty.h
//  My_BaseProj
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Corp. All rights reserved.
//

#ifndef Manual_Add_ThirdParty_h
#define Manual_Add_ThirdParty_h

#import <objc/runtime.h>
#import <VideoToolbox/VideoToolbox.h>//FFmpeg 需要
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "AABlock.h"
#import "YBNotificationManager.h"//通知名字定义
#import "APIKey.h"
#import "SkinManager.h"

#pragma mark —— 各项宏定义
#import "MacroDef_App.h"//加密体系
#import "MacroDef_Cor.h"//加密体系
#import "MacroDef_Func.h"//加密体系
#import "MacroDef_Size.h"//加密体系
#import "MacroDef_Sys.h"//加密体系

#import "ModelManager.h"//数据模型层
#pragma mark —— 网络请求相关的配置
#import "DataManager.h"//存取页面数据
#import "URL_Manager.h"//接口
#import "RequestTool.h"//请求的公共配置文件
#import "NetworkingAPI.h"//App 的所有网络请求Api

#pragma mark —— BaseCustomizeUIKit
//👌UITableViewHeaderFooterView
#import "ViewForFooter.h"
#import "ViewForHeader.h"
//CALayer
#import "CALayer+Anim.h"
#import "CALayer+Transition.h"
//NSArray
#import "NSArray+Extend.h"
#import "NSArray+Extension.h"
//NSObject
//TimeModel
#import "TimeModel.h"
//NSObject+Others
#import "NSObject+AFNReachability.h"
#import "NSObject+Extras.h"
#import "NSObject+Measure.h"
#import "NSObject+OpenURL.h"
#import "NSObject+Random.h"
#import "NSObject+RichText.h"
#import "NSObject+Shake.h"
#import "NSObject+Sound.h"
#import "NSObject+Time.h"
//NSObject+Login
#import "NSObject+Login.h"
//NSObject+Alert
#import "NSObject+SYSAlertController.h"
#import "NSObject+SPAlertController.h"
//NSString
#import "NSString+Extras.h"
#import "NSString+Time.h"
//RedefineSys
#import "DeleteSystemUITabBarButton.h"
//UIButton
#import "UIButton+CountDownBtn.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIButton+Block.h"//要对其进行废弃
//UICollectionViewFlowLayout
#import "HQCollectionViewFlowLayout.h"
#import "LMHWaterFallLayout.h"
//UIColor
#import "UIColor+Hex.h"
//UIGestureRecognizer
#import "UIView+JHGestureBlock.h"
//UIImage
#import "LoadingImage.h"
#import "UIImage+Overlay.h"
#import "UIImage+Tailor.h"
#import "UIImage+Extras.h"
#import "UIImage+YBGIF.h"
#import "UIImage+SYS.h"
//UIImageView
#import "UIImageView+GIF.h"
//UINavigationBar
#import "NavigationBar.h"
//UINavigationController
#import "BaseNavigationVC.h"
//UITableView
#import "BaseTableViewer.h"
//UITableViewCell
#import "TBVCell_style_01.h"
#import "TBVCell_style_02.h"
#import "UITableViewCell+WhiteArrows.h"
//UITextField
//CJTextField
#import "CJTextField.h"
//HQTextField
#import "HQTextField.h"
//JobsMagicTextField
#import "JobsMagicTextField.h"
//UITextField+Extend
#import "UITextField+Extend.h"
//ZYTextField
#import "ZYTextField.h"
//UIView
#import "UIView+Animation.h"
#import "UIView+Gradient.h"
#import "UIView+Measure.h"
#import "UIView+SuspendView.h"
#import "UIView+Extras.h"
#import "UIView+Chain.h"
//UIViewController
//BaseViewController
#import "BaseViewController.h"
//UIViewController+Category
//UIViewController + Others
#import "UIViewController+BackBtn.h"
#import "UIViewController+BaseVC.h"
#import "UIViewController+BRPickerView.h"
#import "UIViewController+BWShareView.h"
#import "UIViewController+GifImageView.h"
#import "UIViewController+JPImageresizerView.h"
#import "UIViewController+MJRefresh.h"
#import "UIViewController+NavigationBar.h"
#import "UIViewController+Shake.h"
//UIViewController+JXCategory
#import "UIViewController+JXCategoryListContentViewDelegate.h"
#import "UIViewController+JXPagerViewListViewDelegate.h"
//UIViewController+TZImagePickerController
#import "UIViewController+TZImagePickerController.h"
#import "UIViewController+TZImagePickerControllerDelegate.h"
#import "UIViewController+TZLocationManager.h"

#pragma mark —— 手动添加的第三方
#import "MKBtnAddBadge.h"//池塘红点
#import "ZBNetworking.h"//即将上位的网络请求
#import "ZFMRACNetworkTool.h"//即将废弃的网络请求
#import "IrregularBtn.h"//不规则多边形按钮
#import "UIImage+Crop.h"//图片剪辑(头像)
#import "MKDIYLoopProgressView.h"//环形动画01
#import "MKLoopProgressHUD.h"//环形动画02
#import "LCRegExpTool.h"//正则表达式
#import "ImageCodeView.h"//图形验证码
#import "WGradientProgressView.h"//水平进度条01
#import "WGradientProgress.h"//水平进度条02
#import "TimerManager.h"//时间管理大师
#import "LZBTabBarVC.h"//替换系统的UITabBarViewController
#import "ShowAvailableFont.h"//iOS打印全员字体
#import "MonitorNetwoking.h"//网络数据实时监测
//Suspend 悬浮系列
#import "suspendBtn.h"
#import "SuspendLab.h"
#import "SuspendView.h"
#import "UIViewController+InteractivePushGesture.h"
#import "EmptyView.h"//空白占位
#import "UIBarButtonItem+Badge.h"//可以移除
#import "UIButton+Badge.h"//可以移除
#import "FileFolderHandleTool.h"//文件夹操作
#import "RBCLikeButton.h"//高仿抖音点赞动画
#import "YYTimer+Block.h"
#import "LBLaunchImageAdView.h"
#import "NSObject+LBLaunchImage.h"
//评论列表
//取消悬停
#import "HoveringHeaderView.h"
#import "NonHoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"
//TBVCell
#import "InfoTBVCell.h"
#import "LoadMoreTBVCell.h"
//高度自定义的按钮
//最新的
#import "UIButton+ImageTitleSpacing.h"
//即将废弃的
#import "FSCustomButton.h"
#import "MKTools.h"//一定要废弃掉
#import "PopUpVC.h"//弹窗小控件（高仿今日头条App评论弹窗框架）
#import "BWShareView.h"//分享控件
#import "LGiOSBtn.h"//高仿iOS长按删除+抖动
//加密体系 ====
#import "SearchView.h"
#import "ECAuthorizationTools.h"//鉴权
#import "SoundBtn.h"//带有按键音的按钮
#import "UIControl+XY.h"
#import "UIButton+CountDownBtn.h"//验证码按钮单例封装

#pragma mark —— Pods不进去的
#import "XHLaunchAd.h"

//UserInfo
#import "MKPublickDataManager.h"
#import "MKLoginModel.h"

//登录 * 注册 * 忘记密码
#import "JobsAppDoorVC_Style1.h"//登录 * 注册
//#import "ForgetCodeVC.h"//忘记密码
//个人中心
#import "MKSingeUserCenterVC.h"

#import "VideoCell.h"

#endif /* Manual_Add_ThirdParty_h */
