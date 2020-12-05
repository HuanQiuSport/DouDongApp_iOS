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
    self.lblTimerExample3.hidden = NO;
}

- (void)reloadSetTime:(double)time{
    NSLog(@"进废弃方法reloadSetTime");
}


- (void)mkSetCoinNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber{
    NSLog(@"进废弃方法mkSetCoinNumber");
}

    
@end
