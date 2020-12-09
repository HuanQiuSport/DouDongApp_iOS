//
//  MKShuaCoinView.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/4/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKShuaCoinView.h"
//#import "MZTimerLabel.h"
#import "MKKeyAndSecreetTool.h"

#import "MKProgressView.h"
//@interface MKShuaCoinView()//<MZTimerLabelDelegate>
@interface MKShuaCoinView()

//@property (nonatomic, assign)double count;
@property (strong,nonatomic) UILabel *lblTimerExample3;
@property (strong,nonatomic) MKProgressView *processView;
@property (assign,nonatomic) NSTimeInterval playerLastTime;
@property (assign,nonatomic) NSTimeInterval countTotalTime;
@property (copy,nonatomic) NSString *assetUrl;
@property (assign,nonatomic) double timeNAL;
@end
@implementation MKShuaCoinView
#pragma mark - 定时器
- (void)dealloc {
    
}
- (void)removeFromSuperview{
    self.countTotalTime = 0;
    [self.processView drawProgress:0]; // 退出清0
    [super removeFromSuperview];
}
- (void)starTimer{

}

- (void)action
{

}
-(void)updateCurentPlayerTime:(NSTimeInterval)time assetUrl:(NSString *)assetUrl {
    NSTimeInterval dur = 0;
    if([self.assetUrl isEqual:assetUrl]) {
        dur = MAX(time - self.playerLastTime,0);
    } else {
        dur = time;
    }
    self.assetUrl = assetUrl;
    self.playerLastTime = time;
    if(self.timeNAL == 0) {
        return;
    }
    self.countTotalTime += dur;
    [self.processView drawProgress:(self.countTotalTime/self.timeNAL)];
    if(self.countTotalTime >= self.timeNAL) {
        [self opencoin];
        self.countTotalTime = 0;
    }
}

// 开始
- (void)startAddCoin{
    NSLog(@"startAddCoin");
}
- (void)resetAddCoin{
}
//暂停定时器(只是暂停,并没有销毁timer)
-(void)stopAddCoin{

}
//继续计时
-(void)cotinueAddCoin{
    NSLog(@"cotinueAddCoin");
}
// 定时器销毁
-(void)clearCoin{
    NSLog(@"开始定时器销毁");
    self.countTotalTime = 0;
    [self.processView drawProgress:0]; // 退出清0
    [super removeFromSuperview];
}
#pragma - 接口控制开启定时器
- (void)mkSetRedpackCoinNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber{
//    timeFloatNumber = @"15.00"; // 测试用

    [self mkSetCoinNumber:floatNumber]; // 金币数
    if (self.timeNAL == 0) {
        NSLog(@"初始化时间重置");
        self.timeNAL = timeFloatNumber.doubleValue; // 时间
    }else{
        if(self.timeNAL == timeFloatNumber.doubleValue){ // 时间没有变化的时候
            return;
        }
        self.timeNAL = timeFloatNumber.doubleValue;
    }
}
#pragma - 打开红包
- (void)opencoin{
    NSLog(@"MKCanCoinNotification");
    [[NSNotificationCenter defaultCenter] postNotificationName:MKCanCoinNotification object:nil];
    @weakify(self)
    self.mkHomeCoinView.hidden = NO;
    self.timeNAL = 0; // 开箱清0
    [MKAnimations moveUp:self.mkHomeCoinView andAnimationDuration:1.0 andWait:YES andLength:20];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        self.mkHomeCoinView.frame = CGRectMake(0, 0,100,30);
        self.mkHomeCoinView.hidden = YES;
        [self.processView drawProgress:0]; // 开箱清0
    });
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"初始化self.count");
        [self mkAddSubView];
        [self mkLayOutView];
    }
    return self;
}
- (MKHomeCoinView *)mkHomeCoinView{
    
    if (!_mkHomeCoinView) {
        
        _mkHomeCoinView = [[MKHomeCoinView alloc]init];
    }
    return _mkHomeCoinView;
}



#pragma mark - 添加子视图
- (MKProgressView *)processView
{
    if (!_processView) {
        _processView = [[MKProgressView alloc]initWithFrame:CGRectMake(-5*1,18*1, 46*1, 46*1)];
        [self addSubview:_processView];
    }
    return _processView;
}
- (void)mkAddSubView{
    [self addSubview: self.lblTimerExample3];
    _mkProgressView = [[MKCircularProgressView alloc]initWithFrame:CGRectMake(-5*1,18*1, 46*1, 46*1) backColor: RGBA_COLOR(0, 0, 0, 0.1) progressColor:[UIColor redColor] lineWidth:1.3];
    _mkProgressView.backgroundColor = RGBA_COLOR(0, 0, 0, 0.54);
    _mkProgressView.layer.cornerRadius = 46*1/2.0;
    [self addSubview:self.mkProgressView];
    
    [self addSubview:self.mkImageView];
    
    [self addSubview:self.mkHomeCoinView];
    

    
    self.mkHomeCoinView.hidden = YES;
    
}
- (void)mkSetCoinNumber:(NSString *)floatNumber{
    self.mkHomeCoinView.mkCoinNumberLabel.text = [NSString stringWithFormat:@"+%@",floatNumber];
}
- ( UIImageView*)mkImageView{
    
    if (!_mkImageView) {
        
        _mkImageView = [[UIImageView alloc]init];
    }
    return _mkImageView;
}
- (NSMutableDictionary *)mkPlayRecord{
    
    if (!_mkPlayRecord) {
        
        _mkPlayRecord = [[NSMutableDictionary alloc]init];
    }
    return _mkPlayRecord;
}
#pragma mark - 布局子视图
-(void)mkLayOutView{
    
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(-22*1);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.equalTo(@(29*1));
        
        make.height.equalTo(@(23*1));
        
    }];
    
    self.mkHomeCoinView.frame = CGRectMake(0, 0,100,30);
  
}

- (void)resetTime{
    NSLog(@"进废弃方法resetTime");
}
- (void)resetTime:(CGFloat)time{
   NSLog(@"进废弃方法resetTime");
//    self.timeNAL = (double)time;
    self.lblTimerExample3 = [[UILabel alloc]init];
    [self addSubview:self.lblTimerExample3];
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(-22*1);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.equalTo(@(29*1));
        
        make.height.equalTo(@(23*1));
        
    }];
//     self.timerExample3 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample3 andTimerType:MZTimerLabelTypeTimer];
//     self.timerExample3.tag = 102;
//    [ self.timerExample3 setCountDownTime:self.timeNAL]; //** Or you can use [timer3 setCountDownToDate:aDate];
//
//    [self.timerExample3 start];
    self.lblTimerExample3.hidden = NO;
//     self.timerExample3.delegate = self;
//     self.timerExample3.timeFormat = @"ss";
//
//     self.timerExample3.resetTimerAfterFinish = YES;
//    [ self.timerExample3 startWithEndingBlock:^(NSTimeInterval countTime) {
//
//    }];
}

- (void)reloadSetTime:(double)time{
    NSLog(@"进废弃方法reloadSetTime");
}
//-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
//    if(timerLabel.tag == 102){
//        NSLog(@"MKCanCoinNotification");
//        [[NSNotificationCenter defaultCenter] postNotificationName:MKCanCoinNotification object:nil];
//        @weakify(self)
//        self.mkHomeCoinView.hidden = NO;
//
//
//        [MKAnimations moveUp:self.mkHomeCoinView andAnimationDuration:1.0 andWait:YES andLength:20];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            @strongify(self)
//            self.mkHomeCoinView.frame = CGRectMake(0, 0,100,30);
//            self.mkHomeCoinView.hidden = YES;
//
//
//        });
////        [self cotinueAddCoin];
//        [[NSNotificationCenter defaultCenter]removeObserver:self name:MKCanCoinNotification object:nil];
//    }
//    if(timerLabel.tag == 102){
//        return;
//    }
//}
//-(void)timerLabel:(MZTimerLabel*)timerLabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType{
//
//    if (timerLabel.tag == 101) {
//        return;
//    }
//    if (timerLabel.tag == 102) {
//
//        self.mkProgressView.progress = 1.00 - time/self.timeNAL;
//
//    }
//
//}

- (void)mkSetCoinNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber{
    NSLog(@"进废弃方法mkSetCoinNumber");
//    [self mkSetCoinNumber:floatNumber];
////    NSLog(@"%@",timeFloatNumber);
//
//    if (self.timeNAL == 0) {
//         self.timeNAL = timeFloatNumber.doubleValue;
//        [self resetTime:timeFloatNumber.doubleValue];
//
//    }else{
//        if(self.timeNAL == timeFloatNumber.doubleValue){ // 时间没有变化的时候
//            return;
//        }
//        double check = MAX(self.timeNAL,timeFloatNumber.doubleValue) - MIN(self.timeNAL, timeFloatNumber.doubleValue);
////        NSLog(@"相差几秒%f",check);
//        double timeReal = MAX(self.timeNAL - check,0) == 0?-check:check;
////        [self.timerExample3 addTimeCountedByTime:MAX(self.timeNAL - check,0) == 0?-check:check];
//        self.timeNAL = timeFloatNumber.doubleValue;
//        NSLog(@"mkSetCoinNumber");
////        [self.timerExample3 start];
//    }
    
    
//        [self mkSetCoinNumber:floatNumber]; // 金币数
//        if (self.timeNAL == 0) {
//             self.timeNAL = timeFloatNumber.doubleValue; // 时间
//            self.count = 0;//self.timeNAL; 初始化时间重置
//        }else{
//            if(self.timeNAL == timeFloatNumber.doubleValue){ // 时间没有变化的时候
//                return;
//            }
//            double check = MAX(self.timeNAL,timeFloatNumber.doubleValue) - MIN(self.timeNAL, timeFloatNumber.doubleValue);
//            self.timeNAL = timeFloatNumber.doubleValue;
//        }
    
        
}

    



//- (void)playFlash
//{
//    [self flashScreenUsingFlashColor:[NSColor whiteColor] inDuration:0.01 outDuration:0.5];
//}
//
//-(void)flashScreenUsingFlashColor:(NSColor *)flashColor
//                       inDuration:(NSTimeInterval)inDuration
//                      outDuration:(NSTimeInterval)outDuration{
//
//    CGDisplayFadeReservationToken fadeToken;
//    NSColor *colorToUse = [flashColor colorUsingColorSpaceName: NSCalibratedRGBColorSpace];
//
//    CGError error = CGAcquireDisplayFadeReservation (inDuration + outDuration, &fadeToken);
//    if (error != kCGErrorSuccess){
//        NSLog(@"Error aquiring fade reservation. Will do nothing.");
//        return;
//    }
//
//    CGDisplayFade (fadeToken, inDuration, kCGDisplayBlendNormal, 0.5, colorToUse.redComponent, colorToUse.greenComponent, colorToUse.blueComponent, true);
//    CGDisplayFade (fadeToken, outDuration, 0.5, kCGDisplayBlendNormal,colorToUse.redComponent, colorToUse.greenComponent, colorToUse.blueComponent, false);
//
//}

@end
