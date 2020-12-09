
//
//  MKDiamondsView.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/10/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKDiamondsView.h"

#import "MKKeyAndSecreetTool.h"
#import "MKAnimations.h"
@interface MKDiamondsView()<MZTimerLabelDelegate>
///
///
@property (assign,nonatomic) double timeNAL;
@property (strong,nonatomic) UILabel *lblTimerExample3;
///   *timerExample3;

@end

@implementation MKDiamondsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self mkAddSubView];
        [self mkLayOutView];
        self.lblTimerExample3.hidden = YES;
    }
    return self;
}

-(void)stopAddDiamond{
//    [_timerExample3 pause];
}
-(void)cotinueDiamond{
//    [_timerExample3 start];
}
- (void)startAddDiamond{
//    [_timerExample3 start];
}
- (void)resetTime{
//    [_timerExample3 pause];
//    [_timerExample3 reset];
//    [_timerExample3 start];
    self.lblTimerExample3.text = @"20:00";
    self.lblTimerExample3.hidden = YES;
}
- ( UIImageView*)mkImageView{
    
    if (!_mkImageView) {
        
        _mkImageView = [[UIImageView alloc]init];
        
    }
    return _mkImageView;
}
- (MKHomeCoinView *)mkHomeCoinView{
    
    if (!_mkHomeCoinView) {
        
        _mkHomeCoinView = [[MKHomeCoinView alloc]init];
    }
    return _mkHomeCoinView;
}
- (void)mkSetDiamondNumber:(NSString *)floatNumber{
    self.mkHomeCoinView.mkCoinNumberLabel.text = [NSString stringWithFormat:@"+%@",floatNumber];
}
- (void)mkSetDiamondNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber{
    [self mkSetDiamondNumber:floatNumber];
//    NSLog(@"%@",timeFloatNumber);
//    timeFloatNumber = @"20";
   
    if (self.timeNAL == 0) {
         self.timeNAL = timeFloatNumber.doubleValue;
         [self resetTime:timeFloatNumber.doubleValue];
        NSLog(@"mkSetDiamondNumber");
         [self.timerExample3 start];
    }else{
        if(self.timeNAL == timeFloatNumber.doubleValue){ // 时间没有变化的时候
            return;
        }
        double check = MAX(self.timeNAL,timeFloatNumber.doubleValue) - MIN(self.timeNAL, timeFloatNumber.doubleValue);
//        NSLog(@"相差几秒%f",check);
        double timeReal = MAX(self.timeNAL - check,0) == 0?-check:check;
        [self.timerExample3 addTimeCountedByTime:MAX(self.timeNAL - check,0) == 0?-check:check];
        
        self.timeNAL = timeFloatNumber.doubleValue;
        NSLog(@"mkSetDiamondNumber2");
        [self.timerExample3 start];
    }
}
- (void)resetTime:(NSInteger)time{
    self.timeNAL = (double)time;
    _timerExample3 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample3 andTimerType:MZTimerLabelTypeTimer];
    _timerExample3.tag = 101;
    [_timerExample3 setCountDownTime:self.timeNAL]; //** Or you can use [timer3 setCountDownToDate:aDate];
    _timerExample3.delegate = self;
    _timerExample3.timeFormat = @"mm:ss";
    _timerExample3.resetTimerAfterFinish = YES;
    [_timerExample3 startWithEndingBlock:^(NSTimeInterval countTime) {}];
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    [self addSubview:self.mkImageView];
    [self addSubview:self.lblTimerExample3];
    [self addSubview:self.mkHomeCoinView];
}
#pragma mark - 布局子视图
-(void)mkLayOutView{
    
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(10*1);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.height.equalTo(@(40*1));
        
    }];
    [self.lblTimerExample3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mkImageView.mas_bottom);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.height.equalTo(@(30*1));
        
        make.width.equalTo(@(80*1));
        
    }];
    
    self.lblTimerExample3 = [[UILabel alloc]init];
    self.lblTimerExample3.text = @"20:00";
    self.lblTimerExample3.textColor = [UIColor whiteColor];
    self.lblTimerExample3.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
    self.lblTimerExample3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lblTimerExample3];
    [self.lblTimerExample3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX).offset(10*1);
        
        make.bottom.offset(7*1);
        
        make.height.equalTo(@(30*1));
        
        make.width.equalTo(@(80*1));
        
    }];
    [self.mkHomeCoinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mkImageView.mas_top).offset(-10*1);
        
        make.left.equalTo(self.mkImageView.mas_left);
        
        make.width.equalTo(@(0*1));
        
        make.height.equalTo(@(0*1));
    }];
    self.mkHomeCoinView.hidden = YES;
    
}
- (void)coinDisplay{
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        self.mkImageView.image = KIMG(@"baoxiang");
        [self.mkImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX).offset(5*1);
            
            make.centerY.equalTo(self.mas_centerY).offset(-10*1);
            
            make.width.height.equalTo(@(60*1));
            
        }];
        self.mkHomeCoinView.hidden = NO;
        [MKAnimations moveUpSCaleBig:self.mkHomeCoinView andAnimationDuration:1.0 andWait:YES andLength:50];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self)
            [MKAnimations moveDownScaleSmall:self.mkHomeCoinView andAnimationDuration:1.0 andWait:YES andLength:50];
            self.mkHomeCoinView.hidden = YES;
            [self EndWobble];
            self.mkImageView.image = KIMG(@"mk_baohe");
            [self.mkImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX).offset(10*1);
                make.centerY.equalTo(self.mas_centerY);
                make.width.height.equalTo(@(40*1));
            }];
            [self.mkHomeCoinView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.mkImageView.mas_top).offset(-10*1);
                make.left.equalTo(self.mkImageView.mas_left);
                make.width.equalTo(@(0*1));
                make.height.equalTo(@(0*1));
            }];
        });
        
    });
    
}

-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
//    [[NSNotificationCenter defaultCenter] postNotificationName:MKOpenDiamondNotification object:nil];
    
    [self BeginWobble];
    
    [self coinDisplay];
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        [self cotinueDiamond];
        
    });
}
#pragma mark - 图片摇摆
-(void)BeginWobble {
    
    srand([[NSDate date] timeIntervalSince1970]);
    float rand=(float)random();
    CFTimeInterval t=rand*0.0000000001;
    
    [UIView animateWithDuration:0.1 delay:t options:0  animations:^{
        self.mkImageView.transform=CGAffineTransformMakeRotation(-0.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
         {
            self.mkImageView.transform=CGAffineTransformMakeRotation(0.05);
        } completion:^(BOOL finished) {}];
    }];
}

-(void)EndWobble {
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.mkImageView.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {}];
}

@end
