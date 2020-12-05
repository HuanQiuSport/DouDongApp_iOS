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

@property (strong,nonatomic) NSMutableDictionary  *mkPlayRecord;

@property (strong,nonatomic) MKCircularProgressView *mkProgressView;

@property (strong,nonatomic) UIImageView *mkImageView;

@property (strong,nonatomic) MKHomeCoinView *mkHomeCoinView;
- (void)resetTime;
- (void)opencoin;
-(void)clearCoin;

-(void)updateCurentPlayerTime:(NSTimeInterval)time assetUrl:(NSString *)assetUrl;

// 设置刷币金额2
- (void)mkSetRedpackCoinNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber;
@end

NS_ASSUME_NONNULL_END
