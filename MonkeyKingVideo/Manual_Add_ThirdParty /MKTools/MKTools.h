//
//  MKTools.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/21/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKTools : NSObject
@property (nonatomic , assign) BOOL _isReloadRequest;    //是否重加载
+(MKTools *)shared;
-(UIWindow *)getCurrentWindow;
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC;
#pragma mark ---------------- 获取设备比例 -----------------
///获取设备比例
-(float)deviceScaleMetod;
///获取真实设备比例
-(float)deviceRealScaleMetod;
#pragma mark ---------------- 精度缺失的問題解決 -----------------
+(NSString *)reviseString:(NSString *)str;
#pragma mark ---------------- 图片样式 -----------------
///圆角图片
+(void)mkSetStyleImageViewWithCorner:(UIImageView *)mkImageView;
///背景图片
+(void)mkSetStyleBackImageViewWith:(UIImageView *)mkImageView;
///圆的图片
+(void)mkSetStyleImageviewCorner:(UIImageView *)mkImageView;
///默认图片
+(void)mkSetStyleDefalutImageview:(UIImageView *)mkImageView;
///下一步图片
+(void)mkSetStyleNextImageview:(UIImageView *)mkImageView;
#pragma mark ---------------- 文本样式 ----------------
+(void)mkSetStyleLabel28:(UILabel *)mkLabel;
+(void)mkSetStyleLabel27:(UILabel *)mkLabel;
+(void)mkSetStyleLabel26:(UILabel *)mkLabel;
+(void)mkSetStyleLabel25:(UILabel *)mkLabel;
+(void)mkSetStyleLabel24:(UILabel *)mkLabel;
+(void)mkSetStyleLabel23:(UILabel *)mkLabel;
+(void)mkSetStyleLabel22:(UILabel *)mkLabel;
+(void)mkSetStyleLabel21:(UILabel *)mkLabel;
+(void)mkSetStyleLabel20:(UILabel *)mkLabel;
+(void)mkSetStyleLabel19:(UILabel *)mkLabel;
+(void)mkSetStyleLabel18:(UILabel *)mkLabel;
+(void)mkSetStyleLabel17:(UILabel *)mkLabel;
+(void)mkSetStyleLabel16:(UILabel *)mkLabel;
+(void)mkSetStyleLabel15:(UILabel *)mkLabel;
+(void)mkSetStyleLabel14:(UILabel *)mkLabel;
+(void)mkSetStyleLabel13:(UILabel *)mkLabel;
+(void)mkSetStyleLabel12:(UILabel *)mkLabel;
+(void)mkSetStyleLabel11:(UILabel *)mkLabel;
+(void)mkSetStyleLabel10:(UILabel *)mkLabel;
+(void)mkSetStyleLabel08:(UILabel *)mkLabel;
+(void)mkSetStyleLabel07:(UILabel *)mkLabel;
#pragma mark ---------------- loading加載圈 ----------------
///添加上传加载圈
- (void)addLoadingInViewForUploadWithText:(NSString *)textstr;
- (void)dimssLoadingHUB;


#pragma mark ----------------  设置背景色 ----------------
// 设置渐变色
- (UIColor *)getColorWithColor:(UIColor *)beginColor andCoe:(double)coe  andEndColor:(UIColor *)endColor;
//#242A37
+(UIColor*)BackGroundColor;
//0x20242F
+(UIColor*)BackGroundColor2;
///时间和当前时间比较
+(NSString *)backgroundTimeIsEqualCurrentDateWith:(NSString *)dateSt;

///获取点赞数
+(NSString *)mkGetZanNumberWithZanCode:(NSString *)zanCode;
///清除网页缓存
-(void)cleanCacheAndCookie;
///随机数字
+(NSString*)getRandomNumber:(NSInteger)index;
#pragma mark -  跳转微信
+(void)openWechatWith:(UIView*)superView;
#pragma mark - 跳转QQ
+(void)openQQWith:(UIView*)superView;

+(void)openSafariWith:(NSURL*)url;

+(void)openGoToPotatol;;

///
+(void)saveImageUrlTo:(NSString *)imageStr WithView:(UIView*)superView;
///
+(void)saveImageFullScrrenTo:(NSString *)imageStr WithView:(UIView*)superView;

+(NSString *)getTimeFromTimestamp:(double)time;
#pragma mark - 登录相关
/// isNeedLogin  是否需要登录 NO 不需要登录 ｜ YES 需要登录
/// @param viewVC 所在控制器
/// Return  YES 已经登录 ｜ NO 没有等录
+ (Boolean)mkLoginIsYESWith:(UIViewController *)viewVC WithiSNeedLogin:(BOOL)isNeedLogin;

/// isNeedLogin   YES 需要登录，默认填充
/// @param viewVC 所在控制器
/// Return  YES 已经登录 ｜ NO 没有等录
+(Boolean)mkLoginIsYESWith:(UIViewController *)viewVC;

#pragma - mark 提示更新
- (void)versionTip:(UIView *)view
     VisionContent:(NSString *)visionContent
       versionCode:(NSString *)versionCode
            appUrl:(NSString *)appUrl;

///  NO 已经登录 ｜  YES   没有登录
+(Boolean)mkLoginIsLogin;
/*
    字符串转字典
 */
+ (NSDictionary *)dicWithJsonStr:(NSString *)str;

#pragma mark - 调试用log
/// 开始 🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀
+ (void)testOpenStart:(NSString *)testContent;
/// 结束🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥
+ (void)testOpenEnd:(NSString *)testContent;
/// 成功❌❌❌❌❌❌❌❌❌❌❌
+ (void)testOpenResultFaliue:(NSString *)testContent;
/// 失败🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆🏆
+ (void)testOpenResultSucess:(NSString *)testContent;


#pragma mark - 字符串处理
- (NSString *)getHopeStringWithSourceStr:(NSString *_Nonnull)sourcestr WithDeleteStr:(NSString *_Nonnull)deleteStr;

#pragma mark - 我的关注｜ 我的粉丝  关注按钮样式
- (void)setAtttionStyle:(BOOL)isSelect ToButton:(UIButton*)sender;
+ (NSString *)getNetType;
/// 统计字符个数
+ (NSInteger )mkCountCharNumber:(NSString *)str;
/// 过滤表情
/// 在这个方法中处理  - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
+ (BOOL)isContainsTwoEmoji:(NSString *)string;
///  判断字符串是不是空的  YES 空的 NO 非空
+ (BOOL)isBlankString:(NSString *)string;
///  判断字符串中是不是有空格的  YES 有空格的 NO 没有空格
+ (BOOL)isBlankNULL:(NSString*)string;
/// 统计汉字个数
+ (NSInteger )mkHanziCountCharNumber:(NSString *)str;
/// 统计字母个数
+ (NSInteger )mkAlphaCountCharNumber:(NSString *)str;

#pragma mark - 当前登录用户当次使用时，关注列表
/// 当前登录用户当次使用时，操作关注列表
+ (NSMutableDictionary *)mkGetAttentionArrayOfCurrentLogin;
/// 当前登录用户当次使用时，操作关注列表：插入
+ (BOOL)mkHanderInsertAttentionOfCurrentLoginWithUseId:(NSMutableString *)userId WithBool:(BOOL)isAtteion;
/// 当前登录用户当次使用时，操作关注列表：删除
+ (BOOL)mkHanderDeleteAttentionOfCurrentLoginWithUseId:(NSMutableString *)userId WithBool:(BOOL)isAtteion;
/// 当前登录用户当次使用时，操作关注列表 退出登录清空 AttentionList 中的关注数据
+ (void)mkGetAttentionArrayOfCurrentLoginAllDelete;

#pragma mark - 当前登录用户当次使用时，喜欢列表
/// 当前登录用户当次使用时，操作喜欢列表
+ (NSMutableDictionary *)mkGetLikeVideoArrayOfCurrentLogin;

/// 当前登录用户当次使用时，操作喜欢列表：插入
+ (BOOL)mkHanderInsertLikeVideoOfCurrentLoginWithVideoId:(NSMutableString *)videoId WithBool:(BOOL)priase WithNumber:(NSInteger)priaseInt;
/// 当前登录用户当次使用时，操作喜欢列表：删除
+ (BOOL)mkHanderDeleteLikeVideoOfCurrentLoginWithVideoId:(NSMutableString *)videoId  WithBool:(BOOL)priase WithNumber:(NSInteger)priaseInt;
/// 当前登录用户当次使用时，操作喜欢列表
+ (void)mkGetLikeVideoArrayOfCurrentLoginAllDelete;

/// 判断数组是不是空的
/// @param array NO 非空表数组  YES 空数组
+ (BOOL)mkArrayEmpty:(NSMutableArray *)array;
/// 判断数组是不是空的
/// @param array NO 非空表数组  YES 空数组
+ (BOOL)mkSingleArrayEmpty:(NSArray *)array;
/// 判断字典是不是空的
/// @param dict NO 非空字典  YES 空字典
+ (BOOL)mkDictionaryEmpty:(NSMutableDictionary *)dict;
/// 字符串部分加密，用于身份证、名字
+ (NSString *)replaceStringWithAsterisk:(NSString *)originalStr startLocation:(NSInteger)startLocation lenght:(NSInteger)lenght;
@end

NS_ASSUME_NONNULL_END
