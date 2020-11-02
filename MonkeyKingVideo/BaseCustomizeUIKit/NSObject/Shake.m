//
//  Shake.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "Shake.h"

#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

///系统方法
@interface Shake_SYS ()

@end

@implementation Shake_SYS

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
//    [self resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
        //设置允许摇一摇功能
        [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
//        [self becomeFirstResponder];
    }return self;
}
// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion
          withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {// 判断是否是摇动事件

    }
}
// 摇一摇摇动结束
- (void)motionEnded:(UIEventSubtype)motion
          withEvent:(UIEvent *)event {
    // 判断是否是摇动事件
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"摇一摇结束~~~~~");
        //摇动结束添加事件
    }
}
// 摇一摇取消摇动
- (void)motionCancelled:(UIEventSubtype)motion
              withEvent:(UIEvent *)event {
}

@end

#import <CoreMotion/CoreMotion.h>
//加速仪
@interface Shake_CoreMotion ()

@property(nonatomic,strong)CMMotionManager *motionManager;

@end

@implementation Shake_CoreMotion

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
//    [self resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWhenViewDidAppear{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }return self;
}

-(void)startAccelerometer{
    //以push的方式更新并在block中接收加速度
    @weakify(self)
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]
                                             withHandler:^(CMAccelerometerData *accelerometerData,
                                                           NSError *error) {
        @strongify(self)
        [self outputAccelertionData:accelerometerData.acceleration];
        if (error) {
            NSLog(@"motion error:%@",error);
        }
    }];
}

-(void)stopAccelerometerWhenViewDidDisappear{
    [self.motionManager stopAccelerometerUpdates];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
}

//对应上面的通知中心回调的消息接收
-(void)receiveNotification:(NSNotification *)notification{
    if ([notification.name isEqualToString:UIApplicationDidEnterBackgroundNotification]){
        [self.motionManager stopAccelerometerUpdates];
    }else{
        [self startAccelerometer];
    }
}

-(void)outputAccelertionData:(CMAcceleration)acceleration{
    //综合3个方向的加速度
    double accelerameter =sqrt( pow( acceleration.x , 2 ) + pow( acceleration.y , 2 ) + pow( acceleration.z , 2) );
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    if (accelerameter > 1.5f) {
        //立即停止更新加速仪（很重要！）
        [self.motionManager stopAccelerometerUpdates];
        dispatch_async(dispatch_get_main_queue(), ^{
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            //设置开始摇晃时震动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            //加载动画
//            [self theAnimations];
        });
    }
}

#pragma mark —— lazyLoad
-(CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = CMMotionManager.new;
        _motionManager.accelerometerUpdateInterval = 0.5;//加速仪更新频率，以秒为单位
    }return _motionManager;
}

@end
