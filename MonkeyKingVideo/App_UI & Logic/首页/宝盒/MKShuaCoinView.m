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

@property (nonatomic, assign)double count;
@property (strong,nonatomic) UILabel *lblTimerExample3;
@property (strong,nonatomic) MKProgressView *processView;
/////   *timerExample3;
//@property (strong,nonatomic) MZTimerLabel *timerExample3;

///
@property (assign,nonatomic) double timeNAL;

@property (nonatomic, strong) NSTimer *timer;
@end
@implementation MKShuaCoinView
#pragma mark - 定时器
- (void)dealloc {
    if (_timer) {
        NSLog(@"定时器销毁1");
        [_timer invalidate];
        self.count = 0; // 当退出时时间重置
    }
}
- (void)removeFromSuperview{
    if (_timer) {
         NSLog(@"定时器销毁2");
        [_timer invalidate];
        _timer = nil;
        self.count = 0; // 当退出时时间重置
        [self.processView drawProgress:0]; // 退出清0
    }
    
    [super removeFromSuperview];
}
- (void)starTimer{
    // 没有创建定时器且有时间
    if (self.count != -1) {
         NSLog(@"初始化setFireDate");
        [self.timer setFireDate:[NSDate distantPast]];
    }
    
}
- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(action) userInfo:nil repeats:YES];
    }
    return _timer;
}
- (void)action
{
    self.count++;//时间累加
//    NSLog(@"----圆: %f  -- %f",self.count/self.timeNAL,self.timeNAL);
    [self.processView drawProgress:(self.count/self.timeNAL)];
     if (self.count == self.timeNAL) {
        // 倒计时结束 打开红包，调取接口来重置时间
         [self opencoin];
     }
    
}
// 开始
- (void)startAddCoin{
    NSLog(@"startAddCoin");
//     [ self.timerExample3 start];
    if (!_timer) {
        [self starTimer];
    } else {
        [self cotinueAddCoin];
    }
    
}
- (void)resetAddCoin{
//     [ self.timerExample3 reset];
}
//暂停定时器(只是暂停,并没有销毁timer)
-(void)stopAddCoin{
//    [ self.timerExample3 pause];
    if (_timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
//继续计时
-(void)cotinueAddCoin{
    NSLog(@"cotinueAddCoin");
    if([NSThread isMainThread]){
       
    }else{
        
    }

    // 如果定时器没被销毁（退出登录状态）就重启，否则就重新加载
    if (_timer) {
        [self.timer setFireDate:[NSDate distantPast]];
    }
    
//    [ self.timerExample3 start];
}
// 定时器销毁
-(void)clearCoin{
    NSLog(@"开始定时器销毁");
    if (_timer) {
         NSLog(@"定时器销毁3");
        [_timer invalidate];
        _timer = nil;
        self.count = -1; // 当退出时时间重置
    }
    
    [super removeFromSuperview];
}
#pragma - 接口控制开启定时器
- (void)mkSetRedpackCoinNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber{
//    timeFloatNumber = @"15.00"; // 测试用

    [self mkSetCoinNumber:floatNumber]; // 金币数
    if (self.timeNAL == 0) {
        NSLog(@"初始化时间重置");
        self.timeNAL = timeFloatNumber.doubleValue; // 时间
        self.count = 0;//self.timeNAL; 初始化时间重置
    }else{
        if(self.timeNAL == timeFloatNumber.doubleValue){ // 时间没有变化的时候
            return;
        }
        self.timeNAL = timeFloatNumber.doubleValue;
    }
    // 如果定时器没创建
    if (!_timer) {
        NSLog(@"初始定时器");
        [self starTimer];
    }
    else
    {
        NSLog(@"定时器继续");
        [self cotinueAddCoin];
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
        [self.timer setFireDate:[NSDate distantFuture]]; // 定时器暂停
    });
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"初始化self.count");
        self.count = -1;
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
        _processView = [[MKProgressView alloc]initWithFrame:CGRectMake(-5*KDeviceScale,18*KDeviceScale, 46*KDeviceScale, 46*KDeviceScale)];
        [self addSubview:_processView];
    }
    return _processView;
}
- (void)mkAddSubView{
    [self addSubview: self.lblTimerExample3];
    _mkProgressView = [[MKCircularProgressView alloc]initWithFrame:CGRectMake(-5*KDeviceScale,18*KDeviceScale, 46*KDeviceScale, 46*KDeviceScale) backColor: GKColorRGBA(0,0,0,0.1) progressColor:[UIColor redColor] lineWidth:1.3];
    _mkProgressView.backgroundColor =  GKColorRGBA(0,0,0,0.54);
    _mkProgressView.layer.cornerRadius = 46*KDeviceScale/2.0;
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
        
        make.centerX.equalTo(self.mas_centerX).offset(-22*KDeviceScale);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.equalTo(@(29*KDeviceScale));
        
        make.height.equalTo(@(23*KDeviceScale));
        
    }];
    
    self.mkHomeCoinView.frame = CGRectMake(0, 0,100,30);
  
}

- (void)resetTime{
    NSLog(@"进废弃方法resetTime");
//    [self.timerExample3 reset];
//    [self.timerExample3 start];
//    self.mkProgressView.progress = 0.001;
}
- (void)resetTime:(CGFloat)time{
   NSLog(@"进废弃方法resetTime");
//    self.timeNAL = (double)time;
    self.lblTimerExample3 = [[UILabel alloc]init];
    [self addSubview:self.lblTimerExample3];
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(-22*KDeviceScale);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.equalTo(@(29*KDeviceScale));
        
        make.height.equalTo(@(23*KDeviceScale));
        
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
