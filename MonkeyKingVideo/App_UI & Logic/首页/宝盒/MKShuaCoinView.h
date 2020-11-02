//
//  MKShuaCoinView.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/4/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKCircularProgressView.h"
//#import "MZTimerLabel.h"
#import "MKHomeCoinView.h"
#import "MKAnimations.h"
NS_ASSUME_NONNULL_BEGIN

/// 刷币视图
@interface MKShuaCoinView : UIView
///
@property (strong,nonatomic) NSMutableDictionary  *mkPlayRecord;
///
@property (strong,nonatomic) MKCircularProgressView *mkProgressView;

@property (strong,nonatomic) UIImageView *mkImageView;
//@property (strong,nonatomic) UIImageView *mkCoinImageView;
//@property (strong,nonatomic) UILabel *mkCoinNumberImageView;

@property (strong,nonatomic) MKHomeCoinView *mkHomeCoinView;
//@property (strong,nonatomic) MZTimerLabel *timerExample3;
- (void)resetTime:(CGFloat)time;
-(void)stopAddCoin;
-(void)cotinueAddCoin;
- (void)startAddCoin;
- (void)resetAddCoin;
- (void)resetTime;
- (void)reloadSetTime:(double)time;
- (void)opencoin;
-(void)clearCoin;
// 设置刷币金额
//- (void)mkSetCoinNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber;
// 设置刷币金额与时间
//- (void)mkSetCoinNumber:(NSString *)floatNumber;


// 设置刷币金额2
- (void)mkSetRedpackCoinNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber;
@end

NS_ASSUME_NONNULL_END
