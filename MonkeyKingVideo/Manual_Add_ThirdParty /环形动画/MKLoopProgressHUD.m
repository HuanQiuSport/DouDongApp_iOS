//
//  MKLoopProgressHUD.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/5.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKLoopProgressHUD.h"
@interface MKLoopProgressHUD()
@property (weak,nonatomic)CAShapeLayer *shapLayer;
@property (weak,nonatomic)UILabel *refreshLabel;
@property (strong,nonatomic)UILabel *subrefreshLabel;
@property (weak,nonatomic)UIWindow * currentWindow;
@property (strong,nonatomic)UIView *backView;
@property (strong,nonatomic)UIView *shapLayerView;
@property (weak,nonatomic)NSTimer * timer;
@property (strong,nonatomic)CAKeyframeAnimation *anim;
@end
@implementation MKLoopProgressHUD

+ (id)shareInstance{
    static MKLoopProgressHUD *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init{
    if (self = [super init]) {
        //        self.backgroundColor = [UIColor whiteColor];
//        [self timer];
        self.backgroundColor = [[UIColor colorWithWhite:0.0 alpha:1.000] colorWithAlphaComponent:0.9];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
//        [self addBGview];
    }
    return self;
}
- (void)addBGview{
//    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
//    effe.frame = CGRectMake(50, 90, self.frame.size.width, 400);
//    // 添加毛玻璃
//    [self addSubview:effe];

}
/**
 *  创建动画
 */
- (void)starAnimation
{
    if (!_anim) {
        _anim = [CAKeyframeAnimation animation];
        _anim.keyPath = @"transform.rotation";
        _anim.values = @[@(M_PI/4.0), @(M_PI * 2/4.0), @( M_PI * 3/4.0), @(4 * M_PI /4.0),@(5 *M_PI/4.0), @(6 *M_PI/4.0), @(7 *M_PI/4.0), @(8 * M_PI /4.0),@(8 * M_PI /4.0 + M_PI/4.0)];
        _anim.repeatCount = MAXFLOAT;
        _anim.duration = 1;
        _anim.removedOnCompletion = NO;
        _anim.fillMode = kCAFillModeForwards;
        [self.shapLayer addAnimation:_anim forKey:@"CLAnimation"];
    }
    
}
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(textMove:) userInfo:nil repeats:YES];
    }
    return _timer;
}
- (void)textMove:(NSTimer *)sender{
    
    if ([self.refreshLabel.text isEqualToString:@"正在上传..."]) {
        self.refreshLabel.text = @"正在上传";
        
    }else{
        
        self.refreshLabel.text = [NSString stringWithFormat:@"%@.",self.refreshLabel.text];
        
    }
    
}
- (CAShapeLayer *)shapLayer{
    if (_shapLayer == nil) {
        
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        shapLayer.frame = CGRectMake(0, 0, self.radius, self.radius);
        shapLayer.fillColor = [UIColor clearColor].CGColor;
        
        shapLayer.lineWidth = 2.0f;
        shapLayer.strokeColor = self.strokeColor.CGColor;//线条颜色
        
        UIBezierPath *bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.radius,self.radius)];//画个圆
        shapLayer.path = bezier.CGPath;
        [self.shapLayerView.layer addSublayer:shapLayer];
        shapLayer.strokeStart = 0;
        shapLayer.strokeEnd = 0.85;
        _shapLayer = shapLayer;
    }
    return _shapLayer;
}
- (UIView *)shapLayerView
{
    if (!_shapLayerView) {
        _shapLayerView = UIView.new;
        [self addSubview:_shapLayerView];
        [self.shapLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(62 *KDeviceScale);
            make.height.offset(self.radius+2);
            make.width.offset(self.radius+2);
        }];
        UIImageView *imgeV = UIImageView.new;
        [self.shapLayerView addSubview:imgeV];
        [imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shapLayerView).offset(-2); // 由于图片不是对称的，需要位置微调
            make.centerX.equalTo(self.shapLayerView).offset(-2); // 位置微调
            make.width.equalTo(@(12 *KDeviceScale));
            make.height.equalTo(@(20 *KDeviceScale));
        }];
        imgeV.image = self.imge;
        
    }
    return _shapLayerView;
}
- (UILabel *)refreshLabel{
    if (_refreshLabel == nil) {
        UILabel *refreshLabel = UILabel.new;
        refreshLabel.textColor = kWhiteColor;
        refreshLabel.text = @"正在上传...";
        [self addSubview:refreshLabel];
        [refreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shapLayerView.mas_right).offset(6);
            make.centerY.equalTo(self);
        }];
        _refreshLabel = refreshLabel;
        
    }
    return _refreshLabel;
}
- (UILabel *)subrefreshLabel{
    if (!_subrefreshLabel) {
        _subrefreshLabel = UILabel.new;
        _subrefreshLabel.textColor = kWhiteColor;
        _subrefreshLabel.textAlignment = NSTextAlignmentRight;
        _subrefreshLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_subrefreshLabel];
        [_subrefreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-8);
            make.bottom.equalTo(self).offset(-8);
//            make.left.equalTo(self.shapLayerView.mas_right).offset(6);
//            make.centerY.equalTo(self);
        }];
    }
    return _subrefreshLabel;
}

- (UIWindow *)currentWindow{
    if (_currentWindow == nil) {
        
        UIWindow * currentWindow = [UIApplication sharedApplication].keyWindow;
        _backView = [[UIView alloc]initWithFrame:currentWindow.bounds];
        _backView.backgroundColor = [UIColor colorWithWhite:0.412 alpha:0.0]; // 设置全透明背景
        [currentWindow addSubview:_backView];
        _currentWindow = currentWindow;
    }
    return _currentWindow;
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    self.frame = CGRectMake(SCREEN_W/2 - self.width / 2, SCREEN_H/2 - self.height / 2, self.width,self.height);
    self.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
}
- (void)shows:(NSString *)progressStr{
    self.hidden = NO;
    self.backView.hidden = NO;
    self.subrefreshLabel.text = progressStr;
    if (!_timer) {
        self.timer.fireDate=[NSDate distantPast];//恢复定时器
    }
    [self.currentWindow addSubview:self];
    [self starAnimation];
}
- (void)dismiss{
    self.hidden = YES;
    self.backView.hidden = YES;
    [self.shapLayer removeAnimationForKey:@"CLAnimation"];
    self.timer.fireDate=[NSDate distantFuture];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    self.anim = nil;
}
@end
