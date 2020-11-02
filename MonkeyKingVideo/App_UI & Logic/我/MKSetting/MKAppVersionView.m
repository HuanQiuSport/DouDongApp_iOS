//
//  MKAppVersionView.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/28/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKAppVersionView.h"
@interface MKAppVersionView()
/// 版本信息
@property (strong,nonatomic) UILabel *mkVersionLable;
@end

@implementation MKAppVersionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self mkAddSubView];
        
        [self mkLayOutView];
    }
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    [self addSubview:self.mkVersionLable];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mkVersionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.centerY.equalTo(self);
        
    }];
}
- (UILabel *)mkVersionLable{
    
    if (!_mkVersionLable) {
        
        _mkVersionLable = [[UILabel alloc]init];
        _mkVersionLable.textColor = RGBCOLOR(94, 94, 94);
        _mkVersionLable.font = [UIFont systemFontOfSize:15];
    }
    
    return _mkVersionLable;
}
- (void)getVersionInfo{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//获取app版本信息

    NSLog(@"%@",infoDictionary);
    //这里会得到很对关于app的相关信息

//    下面，我们开始取需要的字段：

    // app名称

    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];

    // app版本

    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    // app build版本

    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];

    //手机序列号

    NSString * identifierNumber = [[UIDevice currentDevice] identifierForVendor];
//    [[UIDevice currentDevice] uniqueIdentifier];

    NSLog(@"手机序列号: %@",identifierNumber);

    //手机别名： 用户定义的名称

    NSString* userPhoneName = [[UIDevice currentDevice] name];

    NSLog(@"手机别名: %@", userPhoneName);

    //设备名称

    NSString* deviceName = [[UIDevice currentDevice] systemName];

    NSLog(@"设备名称: %@",deviceName );

    //手机系统版本

    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];

    NSLog(@"手机系统版本: %@", phoneVersion);

    //手机型号

    NSString* phoneModel = [[UIDevice currentDevice] model];

    NSLog(@"手机型号: %@",phoneModel );

    //地方型号  （国际化区域名称）

    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];

    NSLog(@"国际化区域名称: %@",localPhoneModel );


    // 当前应用名称

    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];

    NSLog(@"当前应用名称：%@",appCurName);

    // 当前应用软件版本  比如：1.0.1
    
    

    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    NSLog(@"当前应用软件版本:%@",appCurVersion); // version
    
    
    self.mkVersionLable.text = [NSString stringWithFormat:@"抖动版本 %@",appCurVersion];

    // 当前应用版本号码  int类型

    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];

    NSLog(@"当前应用版本号码：%@",appCurVersionNum);// build
}
@end
