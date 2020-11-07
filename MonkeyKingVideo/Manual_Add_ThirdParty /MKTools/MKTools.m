//
//  MKTools.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/21/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKTools.h"
#import "SceneDelegate.h"
#import <UIKit/UIKit.h>
#pragma mark - Loading  Lottie
#import <Lottie/Lottie.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "MKLoopProgressHUD.h"
@interface MKTools()

@end

@implementation MKTools

static MKTools *_tools = nil;
+ (MKTools *)shared{
    @synchronized(self){
        if (!_tools) {
            _tools = MKTools.new;
        }
    }return _tools;
}

- (instancetype)init{
    if (self = [super init]) {
        __isReloadRequest = YES;
    }return self;
}

- (UIWindow *)getCurrentWindow{
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        window = [SceneDelegate sharedInstance].window;
    }else{
        window = UIApplication.sharedApplication.delegate.window;
    }
    return window;
}
#pragma mark ---------------- 获取设备比例 -----------------
///获取设备比例
-(float)deviceScaleMetod {
    float scale = kScreenWidth / 375;
    float heightScale = kScreenHeight / 667;
    if (kScreenHeight == 480) {
        return heightScale;
    }
    
    if (scale>1.3) {
        return 1.3;
    }
    //    if (scale<0.88) {
    //        return 0.88;
    //    }
    return scale;
}
///获取真实设备比例
-(float)deviceRealScaleMetod {
    float scale = kScreenWidth / 375;
    float heightScale = kScreenHeight / 667;
    if (kScreenHeight == 480) {
        return heightScale;
    }
    //    if (scale>1.3) {
    //        return 1.3;
    //    }
    //    if (scale<0.88) {
    //        return 0.88;
    //    }
    return scale;
}
#pragma mark ---------------- 精度缺失的問題解決 -----------------
+(NSString *)reviseString: (NSString *)str{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%.3lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
#pragma mark ---------------- 图片样式 -----------------
///圆角图片
+ (void)mkSetStyleImageViewWithCorner:(UIImageView *)mkImageView{
    mkImageView.image = [UIImage imageNamed:@"icon"];
    mkImageView.contentMode = UIViewContentModeRedraw;
//    mkImageView.layer.cornerRadius = mkImageView.bounds.size.width/2;
//    mkImageView.layer.masksToBounds = YES;
}
///背景图片
+ (void)mkSetStyleBackImageViewWith:(UIImageView *)mkImageView{
    mkImageView.image = [UIImage imageNamed:@"mk_back"];
    mkImageView.contentMode = UIViewContentModeScaleAspectFill;
}
///圆的图片
+ (void)mkSetStyleImageviewCorner:(UIImageView *)mkImageView{
    mkImageView.layer.cornerRadius = mkImageView.frame.size.width/2;
    mkImageView.layer.masksToBounds = YES;
}
///默认图片
+ (void)mkSetStyleDefalutImageview:(UIImageView *)mkImageView{
    mkImageView.image = [UIImage new];
    mkImageView.contentMode = UIViewContentModeRedraw;
}
///下一步图片
+ (void)mkSetStyleNextImageview:(UIImageView *)mkImageView{
    mkImageView.image = [UIImage imageNamed:@"next"];
}
#pragma mark ---------------- 文本样式 ----------------
+ (void)mkSetStyleLabel28:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:28 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel27:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:27 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel26:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:26 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel25:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel24:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel23:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel22:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel21:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:21 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel20:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel19:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel18:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel17:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel16:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel15:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    mkLabel.textColor = [UIColor lightGrayColor];
}
+ (void)mkSetStyleLabel14:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel13:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel12:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel11:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel10:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel9:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:9 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel08:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:8 weight:UIFontWeightMedium];
}
+ (void)mkSetStyleLabel07:(UILabel *)mkLabel{
    mkLabel.font = [UIFont systemFontOfSize:7 weight:UIFontWeightMedium];
}
#pragma mark ---------------- loading加載圈 ----------------
///添加加载圈
- (void)showLoadingView:(UIView *)view{
    if (!view){
//        view = self.view;
    }
    if ([view viewWithTag:8888]) {
        //如果已有加载圈，就不需要加载了
        return;
    }
    dispatch_async(dispatch_get_main_queue() , ^{
        //加载圈
       MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        //MBProgressHUDModeLottie
        hud.tag  = 8888;
//        [MBProgressHUD showHUDAddedTo:view animated:YES];
    });
}

///添加加载圈
- (void)addLoadingInView:(UIView *)view{
    if (!view){
        return;
    }
    dispatch_async(dispatch_get_main_queue() , ^{
        //加载圈
        MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeCustomView;
        UIView * bgview = [[UIView alloc] initWithFrame:CGRectMake(0,0,50,50)];
        hud.customView = bgview;
        hud.alpha = 0.5;
//        hud
        hud.square = NO;
        hud.dimBackground = YES;
        hud.margin = 0;
        hud.labelText = @"加载中";
        NSString *oath = [[NSBundle mainBundle] pathForResource:@"LottieAnimationm" ofType:@"bundle"];
        NSBundle *bu = [NSBundle bundleWithPath: oath];
        LOTAnimationView* animation = [LOTAnimationView animationNamed:@"loadingB" inBundle:bu];
        [bgview addSubview:animation];
        animation.backgroundColor = [UIColor clearColor];
        bgview.backgroundColor = [UIColor clearColor];
//        [animation setContentMode:UIViewContentModeScaleToFill];
//        hud.customView = animation;
        [animation mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(80 *KDeviceScale));
            
            make.height.equalTo(@(80 *KDeviceScale));
            
            make.centerX.equalTo(bgview.mas_centerX);
            
            make.centerY.equalTo(bgview.mas_centerY);
            
        }];
        animation.loopAnimation = YES;
        [animation playWithCompletion:^(BOOL animationFinished) {}];
    });
}

///添加加载圈 用于上传/下载
- (void)addLoadingInViewForUploadWithText:(NSString *)textstr{
    MKLoopProgressHUD *hud = [MKLoopProgressHUD shareInstance];
    hud.radius = 34;
    hud.width = 267;
    hud.height = 76;
    hud.imge = KIMG(@"icon_upload_imge");
    hud.strokeColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(50, 25)]]; //圆环底色
    [hud shows:textstr];
}
///隐藏上传/下载加载圈
- (void)dimssLoadingHUB
{
    dispatch_async(dispatch_get_main_queue() , ^{
        [[MKLoopProgressHUD shareInstance] dismiss];
    });
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
      
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
      
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
      
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
      
    return result;
}
///隐藏加载圈
- (void) dissmissLoadingInView:(UIView *)view animated:(BOOL)animated{
    if (!view){
        return;
    }
    dispatch_async(dispatch_get_main_queue() , ^{
        [MBProgressHUD hideHUDForView:view animated:YES];
        
    });
}
/**
* 加载圈
* @param view  加载圈父及时图
* @param text 文本
* @param time 加载时间
*/
- (void)showMBProgressViewOnlyTextInView:(UIView *)view
                                    text:(NSString *)text
                      dissmissAfterDeley:(NSTimeInterval)time{
    if (view == nil) {
        view = [[MKTools shared] getCurrentWindow].window;
    }
    
    dispatch_async(dispatch_get_main_queue() , ^{
        //隐藏加载圈
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = text;
        hud.detailsLabelFont = kFontSize(12.0);
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;

        [hud hide:YES afterDelay:time];
    });
}
#pragma mark ----------------  设置背景色 ----------------
/**
 得到一个颜色的原始值 RGBA
 
 @param originColor 传入颜色
 @return 颜色值数组
 */
- (NSArray *)getRGBDictionaryByColor:(UIColor *)originColor {
    CGFloat r = 0,g = 0,b = 0,a = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [originColor getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(originColor.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    return @[@(r),@(g),@(b)];
}

/**
 得到两个值的色差
 
 @param beginColor 起始颜色
 @param endColor 终止颜色
 @return 色差数组
 */
- (NSArray *)transColorBeginColor:(UIColor *)beginColor andEndColor:(UIColor *)endColor {
    NSArray<NSNumber *> *beginColorArr = [self getRGBDictionaryByColor:beginColor];
    NSArray<NSNumber *> *endColorArr = [self getRGBDictionaryByColor:endColor];
    return @[@([endColorArr[0] doubleValue] - [beginColorArr[0] doubleValue]),@([endColorArr[1] doubleValue] - [beginColorArr[1] doubleValue]),@([endColorArr[2] doubleValue] - [beginColorArr[2] doubleValue])];
}

/**
 传入两个颜色和系数
 
 @param beginColor 开始颜色
 @param coe 系数（0->1）
 @param endColor 终止颜色
 @return 过度颜色
 */

- (UIColor *)getColorWithColor:(UIColor *)beginColor andCoe:(double)coe  andEndColor:(UIColor *)endColor {
    NSArray *beginColorArr = [self getRGBDictionaryByColor:beginColor];
    NSArray *marginArray = [self transColorBeginColor:beginColor andEndColor:endColor];
    double red = [beginColorArr[0] doubleValue] + coe * [marginArray[0] doubleValue];
    double green = [beginColorArr[1] doubleValue] + coe * [marginArray[1] doubleValue];
    double blue = [beginColorArr[2] doubleValue] + coe * [marginArray[2] doubleValue];
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+(UIColor*)BackGroundColor{
    return HEXCOLOR(0x242A37);
}

+(UIColor*)BackGroundColor2{
    return HEXCOLOR(0x20242F);
}
///时间和当前时间比较
+ (NSString *)backgroundTimeIsEqualCurrentDateWith:(NSString *)dateStr{
//    NSString *str = @"2017-06-25 17:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设置时间格式
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    tomorrow = [today dateByAddingTimeInterval: -secondsPerDay*2];//前天
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];//昨天
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
//[date description]返回的是时间，比当前时间少八个小时，这并不影响时间的判断
    NSString *hourAndMin = [dateStr substringWithRange:NSMakeRange(11, 5)];
    if ([dateString isEqualToString:todayString]) {
        return [NSString stringWithFormat:@"今天 %@", hourAndMin];
    } else if ([dateString isEqualToString:yesterdayString]) {
        return [NSString stringWithFormat:@"昨天 %@", hourAndMin];
    }else if ([dateString isEqualToString:tomorrowString]){
        return [NSString stringWithFormat:@"前天 %@", hourAndMin];
    }else {
        [dateFormatter setDateFormat:@"MM-dd"];
        dateStr = [dateFormatter stringFromDate:date];
        return dateStr;
    }
}


+ (NSString *)getTimeFromTimestamp:(double)time{
    // 1504667976
    //将对象类型的时间转换为NSDate类型
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];

    //设置时间格式

    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    //将时间转换为字符串

    NSString *timeStr=[formatter stringFromDate:myDate];

    return timeStr;

}
/*
*  isNeedLogin  是否需要登录 NO 不需要登录 ｜ YES 需要登录
* @param viewVC 所在控制器
* Return  YES 已经登录 ｜ NO 没有等录
*/
+ (Boolean)mkLoginIsYESWith:(UIViewController *)viewVC WithiSNeedLogin:(BOOL)isNeedLogin{
    if ([self mkLoginIsLogin]) {
        if (isNeedLogin) {
            [NSObject Login];
        }else{
            
        }
        return NO;
    }else{
        return YES;
    }
}
/*
* isNeedLogin YES 需要登录 默认的填充
* @param viewVC 所在控制器
* Return  YES 已经登录 ｜ NO 没有等录
*/
+ (Boolean)mkLoginIsYESWith:(UIViewController *)viewVC{
    
   return [self mkLoginIsYESWith:viewVC WithiSNeedLogin:YES];
    
}

///  NO 已经登录 ｜  YES   没有登录
+(Boolean)mkLoginIsLogin{
    
    return [NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
   
}
///获取点赞数
+ (NSString *)mkGetZanNumberWithZanCode:(NSString *)zanCode{
    NSString *zanStr;
    zanStr = [NSString stringWithFormat:@"%.1f",[zanCode floatValue]];
    return zanStr;
}
///清除网页缓存
- (void)cleanCacheAndCookie{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}
///随机数字
+ (NSString*)getRandomNumber:(NSInteger)index{
    return [NSString stringWithFormat:@"%u",arc4random_uniform([@(index) intValue])];
}
///跳转微信
+(void)openWechatWith:(UIView*)superView{
    NSURL * url = [NSURL URLWithString:@"wechat://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){//打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [MBProgressHUD wj_showPlainText:@"未安装微信" view:superView];
    }
}
///跳转QQ
+(void)openQQWith:(UIView*)superView{
    NSURL * url = [NSURL URLWithString:@"mqq://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){//打开QQ
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [MBProgressHUD wj_showPlainText:@"未安装QQ" view:superView];
    }
}
+ (void)openGoToPotatol{
    //
    NSURL * url = [NSURL URLWithString:@"https://t.me/doudong"];
    [[UIApplication sharedApplication] openURL:url];
}
+(void)openSafariWith:(NSURL*)url{
    
     [[UIApplication sharedApplication] openURL:url];
    
}

+ (void)saveImageUrlTo:(NSString *)imageStr WithView:(UIView*)superView{
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithBase64EncodedString:imageStr]];
    BOOL boolStr = NO;
    UIImageWriteToSavedPhotosAlbum(image,
                                   self,
                                   @selector(image:didFinishSavingWithError:contextInfo:),
                                   &boolStr);//@selector(image:didFinishSavingWithError:contextInfo:)
    if (boolStr) {
         [MBProgressHUD wj_showPlainText:@"保存成功" view:superView];
    }else{
         [MBProgressHUD wj_showPlainText:@"保存失败" view:superView];
    }
}
///
-(void)image:(UIImage *)image
didFinishSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo{
//    NSString *msg = nil ;
//    if(error){
//        contextInfo = YES;
//    }else{
//        contextInfo = NO;
//    }
}
///
+ (void)saveImageFullScrrenTo:(NSString *)imageStr
                     WithView:(UIView*)superView{
    UIImage *newImage = [UIImage rendImageWithView:superView];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
          [PHAssetChangeRequest creationRequestForAssetFromImage:newImage];
      } completionHandler:^(BOOL success,
                            NSError * _Nullable error) {
        NSString *tip;
        NSString *tip2;
        if (error) {
            NSLog(@"%@",@"保存失败");
            tip2 = @"保存失败";
            tip = [NSString stringWithFormat:@"保存失败 \n%@",@"相册权限未打开"];//[NSString stringWithFormat:@"保存失败 \n:%@",error];
        } else {
            NSLog(@"%@",@"保存成功");
            tip2 = @"已保存至相册";
            tip = @"由于微信分享限制，请到微信上传图片来分享。";
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
//                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
//
//                // Configure for text only and offset down
//                hud.mode = MBProgressHUDModeText;
//                hud.detailsLabelText = tip;
//                hud.detailsLabelFont = kFontSize(12.0);
//                hud.margin = 10.f;
//                hud.removeFromSuperViewOnHide = YES;
//
//                [hud hide:YES afterDelay:1.5f];
                MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:superView animated:YES];
                hud.mode = MBProgressHUDModeCustomView;
                
                UIView * grbgview = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
                [grbgview addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
                    NSLog(@"");
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES];
                }];
                grbgview.layer.backgroundColor = RGBA_COLOR(0, 0, 0, 0.1).CGColor;
                hud.customView = grbgview;
                
                UIView * bgview = UIView.new;//[[UIView alloc] initWithFrame:CGRectMake(0,0,327*KDeviceScale,160*KDeviceScale)];
                [grbgview addSubview:bgview];
                [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(grbgview);
                    make.centerY.equalTo(grbgview);
                    make.height.offset(160*KDeviceScale);
                    make.width.offset(327*KDeviceScale);
                }];
                hud.square = NO;
                hud.dimBackground = YES;
                hud.margin = 0;
                bgview.backgroundColor = kWhiteColor;
                bgview.layer.cornerRadius = 10;
                
                UILabel *lab = UILabel.new;
                [bgview addSubview:lab];
                [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(bgview).offset(22);
                    make.left.equalTo(bgview).offset(0);
                    make.right.equalTo(bgview).offset(0);
                }];
                lab.textColor = RGBCOLOR(58, 58, 58);
                lab.textAlignment = NSTextAlignmentCenter;
                lab.text =tip2;
                lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
                
                UIView *line = UIView.new;
                [bgview addSubview:line];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lab.mas_bottom).offset(22);
                    make.left.equalTo(bgview).offset(0);
                    make.right.equalTo(bgview).offset(0);
                    make.height.offset(0.5f);
                }];
                line.backgroundColor = RGBCOLOR(222, 222, 222);
                
                UILabel *lab2 = UILabel.new;
                [bgview addSubview:lab2];
                [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(line).offset(22);
                    make.left.equalTo(bgview).offset(42);
                    make.right.equalTo(bgview).offset(-42);
                }];
                lab2.text = tip;
                lab2.numberOfLines = 0;
                lab2.textColor = RGBCOLOR(58, 58, 58);
                lab2.textAlignment = NSTextAlignmentLeft;
                lab2.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
                
                UIButton *btn = UIButton.new;
                [bgview addSubview:btn];
                [btn setImage:KIMG(@"icon_HUB_close") forState:UIControlStateNormal];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(bgview).offset(8);
                    make.right.equalTo(bgview).offset(-12);
                    make.height.offset(30);
                    make.width.offset(27);
                }];
                [btn addAction:^(UIButton *btn) {
                    hud.removeFromSuperViewOnHide = YES;
                    [hud hide:YES];
                }];
            });
        });

      }];
}
#pragma - mark 提示更新
- (void)versionTip:(UIView *)view
     VisionContent:(NSString *)visionContent
       versionCode:(NSString *)versionCode
            appUrl:(NSString *)appUrl{

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//        });
//    });
    if(visionContent == nil) {
        visionContent = @"";
    }
    if(versionCode == nil) {
        versionCode = @"";
    }
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    
    UIView * grbgview = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_W,SCREEN_H)];
    grbgview.layer.backgroundColor = kClearColor.CGColor;
    hud.customView = grbgview;
    
    UIView * bgview = UIView.new;//[[UIView alloc] initWithFrame:CGRectMake(0,0,327*KDeviceScale,160*KDeviceScale)];
    bgview.backgroundColor = kClearColor;
    [grbgview addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grbgview);
        make.centerY.equalTo(grbgview);
        make.height.offset(304*KDeviceScale);
        make.width.offset(253*KDeviceScale);
    }];
    hud.square = NO;
    hud.dimBackground = YES;
    hud.margin = 0;
    bgview.layer.cornerRadius = 10;
    
    
    UIImageView *imge = UIImageView.new;
    [bgview addSubview:imge];
    [imge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    imge.image = KIMG(@"imge_versionTip");
    
    UILabel *lab = UILabel.new;
    [bgview addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgview).offset(109);
        make.left.equalTo(bgview).offset(17);
        make.right.equalTo(bgview).offset(0);
    }];
    lab.textColor = RGBCOLOR(58, 58, 58);
    lab.text = [NSString stringWithFormat:@"V%@",versionCode];
    lab.font = [UIFont systemFontOfSize:11];
    
    
    
    UITextView *contentView = UITextView.new;
    [bgview addSubview:contentView];
    
//    contentView.text = content;
    contentView.editable = NO;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];

    paragraphStyle.lineSpacing = 13;// 字体的行间距

    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:11],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    contentView.typingAttributes = attributes;
    contentView.attributedText =  [[NSAttributedString alloc] initWithString:visionContent attributes:attributes];
    
    UIButton *btn = UIButton.new;
    [bgview addSubview:btn];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgview).offset(-24);
        make.right.equalTo(bgview).offset(-30);
        make.height.offset(24);
        make.width.offset(84);
    }];
    btn.layer.cornerRadius = 12;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"更新" forState:UIControlStateNormal];
    [btn addAction:^(UIButton *btn) {
        [MBProgressHUD hideHUDForView:view animated:true];
        if(appUrl != nil) {
            NSURL * url = [NSURL URLWithString:appUrl];
            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
            //先判断是否能打开该url
            if(canOpen) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(10);
        make.left.equalTo(bgview).offset(17);
        make.right.equalTo(bgview).offset(-17);
        make.bottom.equalTo(btn.mas_top).offset(-30);
    }];
    
    UIButton *btn2 = UIButton.new;
    [bgview addSubview:btn2];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setTitleColor:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(40), 30)]] forState:UIControlStateNormal];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgview).offset(-24);
        make.left.equalTo(bgview).offset(30);
        make.height.offset(24);
        make.width.offset(84);
    }];
    btn2.layer.cornerRadius = 12;
    btn2.layer.masksToBounds = YES;
    btn2.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(40), 30)]].CGColor;
    btn2.layer.borderWidth = 1;
    [btn2 setTitle:@"取消" forState:UIControlStateNormal];
    [btn2 addAction:^(UIButton *btn) {
        [MBProgressHUD hideHUDForView:view animated:true];
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset(10);
        make.left.equalTo(bgview).offset(17);
        make.right.equalTo(bgview).offset(-17);
        make.bottom.equalTo(btn.mas_top).offset(-30);
    }];
    
}
#pragma mark - 字符串转字典
 
+ (NSDictionary *)dicWithJsonStr:(NSString *)str
{
    if (str == nil) {
        return nil;
    }
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"json解析失败 %@",error);
        return nil;
    }
    
    return dic;
}
+ (void)testOpenStart:(NSString *)testContent{
    NSLog(@"🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀%@",testContent);
}
+ (void)testOpenEnd:(NSString *)testContent{
    NSLog(@"🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥%@",testContent);
}
+ (void)testOpenResultFaliue:(NSString *)testContent{
    NSLog(@"❌❌❌❌❌❌❌❌❌❌❌%@",testContent);
}
+ (void)testOpenResultSucess:(NSString *)testContent{
    NSLog(@"🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆%@",testContent);
}

- (NSString *)getHopeStringWithSourceStr:(NSString *_Nonnull)sourcestr WithDeleteStr:(NSString *_Nonnull)deleteStr{
    NSRange range = [sourcestr rangeOfString:deleteStr];
    
    return [sourcestr substringWithRange:NSMakeRange(range.length ,sourcestr.length - range.length)];
}

- (void)setAtttionStyle:(BOOL)isSelect ToButton:(UIButton*)sender{
    if (isSelect) {
        
        [sender setBackgroundImage:[UIImage imageWithColor:MKBakcColor] forState:UIControlStateNormal];
        
        sender.layer.cornerRadius = 13.5 *KDeviceScale;
        
         sender.layer.masksToBounds = YES;
        
        sender.layer.borderColor = MKBorderColor.CGColor;
        
        sender.layer.borderWidth = 1;
    
    }else{
        [sender setBackgroundImage:KIMG(@"画板") forState:UIControlStateNormal];
        
        sender.layer.cornerRadius = 13.5 *KDeviceScale;
        
        sender.layer.masksToBounds = YES;
        
        sender.layer.borderColor = MKBorderColor.CGColor;
        
        sender.layer.borderWidth = 0;
    }
}
+ (NSString *)getNetType
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString * netconnType;
    NSString *currentStatus = info.serviceCurrentRadioAccessTechnology;
    
    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
        
        netconnType = @"GPRS";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
        
        netconnType = @"2.75G EDGE";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
        
        netconnType = @"3.5G HSDPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
        
        netconnType = @"3.5G HSUPA";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
        
        netconnType = @"2G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
        
        netconnType = @"3G";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
        
        netconnType = @"HRPD";
    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
        
        netconnType = @"4G";
    }
    return netconnType;
}
+ (NSInteger )mkCountCharNumber:(NSString *)str{
    for(int i=0; i<str.length; i++){
//        unichar ch = [str characterAtIndex: i];
    }
    int count = 0;
    int count1 = 0;
 
    for (int i = 0; i<str.length; i++)
    {
        unichar c = [str characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            count ++;
            
        }
        else
        {
            count1 ++;
            
        }
    }
    
    NSLog(@"汉字%d字母%d",count,count1);
      return count * 2 + count1;
}

/// 过滤表情 在这个方法中处理  - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
+ (BOOL)isContainsTwoEmoji:(NSString *)string

{
    __block BOOL isEomji = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
         const unichar hs = [substring characterAtIndex:0];
         NSLog(@"hs++++++++%04x",hs);
        if (0xd800 <= hs && hs <=  0xdbff)
        {
            if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                
                const int uc = ((hs - 0xd800) *0xd400) + (ls -0xdc00) + 0x10000;
                
                if (0x1d000 <= uc && uc <= 0x1f77f)
                {
                     isEomji = YES;
                }
                 NSLog(@"uc++++++++%04x",uc);
            }
            else if(substring.length > 1){
                 
                const unichar ls = [substring characterAtIndex:1];
                
                if (ls == 0x20e3|| ls ==0xfe0f)
                {
                    isEomji = YES;
                }
                
                NSLog(@"ls++++++++%04x",ls);
            }
            else
            {
                if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b)
                {
                    isEomji = YES;
                }
                else if (0x2B05 <= hs && hs <= 0x2b07)
                {
                    isEomji = YES;
                }
                else if (0x2934 <= hs && hs <= 0x2935)
                {
                    isEomji = YES;
                }
                else if (0x3297 <= hs && hs <= 0x3299)
                {
                    isEomji = YES;
                }
                 else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a )
                 {
                     isEomji = YES;
                 }
            }
        }
    }];
    return isEomji;
}
- (BOOL)isHaveAppleEomji:(NSString *)text{
    __block BOOL isEomji = NO;
    [text enumerateSubstringsInRange:NSMakeRange(0, text.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
//        if(substring.length ==  EmojiCharacterLength){
//            isEomji = YES;
//        }
    }];
    return isEomji;
}
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
 
    return  NO;
}
+ (BOOL)isBlankNULL:(NSString*)string{
    NSRange  range = [string rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return  YES;
    }else{
        return  NO;
    }
    return NO;
}
/// 统计汉字个数
+ (NSInteger )mkHanziCountCharNumber:(NSString *)str{
    for(int i=0; i<str.length; i++){
//        unichar ch = [str characterAtIndex: i];
    }
    int count = 0;
    int count1 = 0;
 
    for (int i = 0; i<str.length; i++)
    {
        unichar c = [str characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            count ++;
            
        }
        else
        {
            count1 ++;
            
        }
    }
    
    NSLog(@"汉字%d字母%d",count,count1);
      return count;
}
/// 统计字母个数
+ (NSInteger )mkAlphaCountCharNumber:(NSString *)str{
    for(int i=0; i<str.length; i++){
//        unichar ch = [str characterAtIndex: i];
    }
    int count = 0;
    int count1 = 0;
 
    for (int i = 0; i<str.length; i++)
    {
        unichar c = [str characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5)
        {
            count ++;
            
        }
        else
        {
            count1 ++;
        }
    }
    NSLog(@"汉字%d字母%d",count,count1);
    return count1;
}
/// 当前登录用户当次使用时，操作关注列表
+ (NSMutableDictionary *)mkGetAttentionArrayOfCurrentLogin{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"AttentionList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    [dataDictionary writeToFile:myPath atomically:YES];
    return dataDictionary;
}

/// 当前登录用户当次使用时，操作关注列表：插入
+ (BOOL)mkHanderInsertAttentionOfCurrentLoginWithUseId:(NSMutableString *)userId WithBool:(BOOL)isAtteion{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"AttentionList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    if([self mkDictionaryEmpty:dataDictionary]){
        NSMutableDictionary *array = [NSMutableDictionary dictionary];
        [array setValue:@(isAtteion) forKey:userId];
        NSLog(@"当前登录用户当次使用时，操作关注列表 当前插入之后%@",array);
        [array writeToFile:myPath atomically:YES];
        NSLog(@"当前登录用户当次使用时，操作关注列表 插入之后%@",[self mkGetAttentionArrayOfCurrentLogin]);
        return NO;
    }else{
       
    }
    [dataDictionary setValue:@(isAtteion) forKey:userId];
    NSLog(@"当前登录用户当次使用时，操作关注列表 当前插入之后%@",dataDictionary);
    [dataDictionary writeToFile:myPath atomically:YES];
    NSLog(@"当前登录用户当次使用时，操作关注列表 插入之后%@",[self mkGetAttentionArrayOfCurrentLogin]);
    return NO;
}
/// 当前登录用户当次使用时，操作关注列表：删除
+ (BOOL)mkHanderDeleteAttentionOfCurrentLoginWithUseId:(NSMutableString *)userId WithBool:(BOOL)isAtteion{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"AttentionList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    [dataDictionary setValue:@(isAtteion) forKey:userId];
    [dataDictionary writeToFile:myPath atomically:YES];
    NSLog(@"当前登录用户当次使用时，操作关注列表 删除之后%@",[self mkGetAttentionArrayOfCurrentLogin]);
    return NO;
}
/// 当前登录用户当次使用时，操作关注列表 退出登录清空 AttentionList 中的关注数据
+ (void)mkGetAttentionArrayOfCurrentLoginAllDelete{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"AttentionList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    [dataDictionary removeAllObjects];
    [dataDictionary writeToFile:myPath atomically:YES];
}

#pragma mark - 当前登录用户当次使用时，喜欢列表
/// 当前登录用户当次使用时，操作喜欢列表
+ (NSMutableDictionary *)mkGetLikeVideoArrayOfCurrentLogin{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"LikeVideoList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    [dataDictionary writeToFile:myPath atomically:YES];
    return dataDictionary;
}
/// 当前登录用户当次使用时，操作喜欢列表：插入
+ (BOOL)mkHanderInsertLikeVideoOfCurrentLoginWithVideoId:(NSMutableString *)videoId WithBool:(BOOL)priase WithNumber:(NSInteger)priaseInt{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"LikeVideoList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    if([self mkDictionaryEmpty:dataDictionary]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@[@(priase),@(priaseInt)] forKey:videoId];
//        NSLog(@"当前登录用户当次使用时，操作喜欢列表 当前插入之后%@",array);
        [dic writeToFile:myPath atomically:YES];
        NSLog(@"当前登录用户当次使用时，操作喜欢列表 插入之后%@",[self mkGetLikeVideoArrayOfCurrentLogin]);
        return NO;
    }else{
       
    }
    [dataDictionary setValue:@[@(priase),@(priaseInt)]  forKey:videoId];
    [dataDictionary writeToFile:myPath atomically:YES];
    NSLog(@"当前登录用户当次使用时，操作喜欢列表 插入之后%@",[self mkGetLikeVideoArrayOfCurrentLogin]);
    return NO;
}
/// 当前登录用户当次使用时，操作喜欢列表：删除
+ (BOOL)mkHanderDeleteLikeVideoOfCurrentLoginWithVideoId:(NSMutableString *)videoId WithBool:(BOOL)priase WithNumber:(NSInteger)priaseInt{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"LikeVideoList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    
    [dataDictionary setValue:@[@(priase),@(priaseInt)] forKey:videoId];
    [dataDictionary writeToFile:myPath atomically:YES];
    NSLog(@"当前登录用户当次使用时，操作喜欢列表 删除之后%@",[self mkGetLikeVideoArrayOfCurrentLogin]);
    return NO;
}
+ (void)mkGetLikeVideoArrayOfCurrentLoginAllDelete{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path1 = [pathArray objectAtIndex:0];
    NSString *myPath = [path1 stringByAppendingPathComponent:@"LikeVideoList.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:myPath];
    [dataDictionary removeAllObjects];
    [dataDictionary writeToFile:myPath atomically:YES];
}
/// 判断数组是不是空的
/// @param array NO 非空表数组  YES 空数组
+ (BOOL)mkArrayEmpty:(NSMutableArray *)array{
    if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
        return  NO;
    }
    return  YES;
}
/// 判断数组是不是空的
/// @param array NO 非空表数组  YES 空数组
+ (BOOL)mkSingleArrayEmpty:(NSArray *)array{
    if (array != nil && ![array isKindOfClass:[NSNull class]]){
        return  NO;
    }
    return  YES;
}
/// 判断字典是不是空的
/// @param dict NO 非空字典  YES 空字典
+ (BOOL)mkDictionaryEmpty:(NSMutableDictionary *)dict{
    if (dict == nil || [dict isKindOfClass:[NSNull class]] || [dict isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}
/// 字符串部分加密，用于身份证、名字
+ (NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght

{

    NSString *newStr = originalStr;

    for (int i = 0; i < lenght; i++) {

        NSRange range = NSMakeRange(startLocation, 1);

        newStr = [newStr stringByReplacingCharactersInRange:range withString:@"*"];

        startLocation ++;

    }

    return newStr;

}
@end
