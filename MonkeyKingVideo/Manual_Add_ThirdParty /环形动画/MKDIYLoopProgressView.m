//
//  MKDIYLoopProgressView.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/18.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKDIYLoopProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define ViewWidth self.frame.size.width   //环形进度条的视图宽度
#define ProgressWidth 2.5                 //环形进度条的圆环宽度
#define Radius ViewWidth/2-ProgressWidth  //环形进度条的半径

@interface MKDIYLoopProgressView()
@property (nonatomic,assign)CGFloat i;
@end
@implementation MKDIYLoopProgressView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(50, 25)]].CGColor; //圆环底色
    layer.frame = rect;


    //创建一个圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(xCenter, yCenter) radius:Radius startAngle:0 endAngle:M_PI*2 clockwise:YES];

    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = ProgressWidth;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.8;
    shapeLayer.lineCap = @"round";
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;

    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(50, 25)]].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(xCenter, yCenter, 60, 60);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    [layer addSublayer:gradientLayer]; //设置颜色渐变
    [layer setMask:shapeLayer]; //设置圆环遮罩
    [self.layer addSublayer:layer];

    //动画
    CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation2.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    //    scaleAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation2.repeatCount = MAXFLOAT;
    rotationAnimation2.duration = 2;
    [layer addAnimation:rotationAnimation2 forKey:@"groupAnnimation"];
}

@end
