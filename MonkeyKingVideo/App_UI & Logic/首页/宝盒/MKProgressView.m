//
//  MKProgressView.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/4/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKProgressView.h"
@interface MKProgressView ()

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) CALayer *gradientLayer;

@end
@implementation MKProgressView
//-(void)setValue:(CGFloat)value{
//    _value = value ;
//    //这样系统不会执行drawRect方法
//    //[self drawRect:self.bounds] ;
//    //当系统调用drawRect方法的时候，在drawRect会自动创建跟View相关的上下文
//    //手动调用是没有效果的
//    //通知系统，执行drawRect方法
//    //setNeedsDisplay:重新绘制
//    [self setNeedsDisplay] ;
//}
//- (void)drawRect:(CGRect)rect {
//    // 扇形
//    [self setShanXing:rect];
//
//}
//- (void)setShanXing:(CGRect)rect{
//    //    NSLog(@"%@",NSStringFromCGRect(rect));
//        // Drawing code
//        //1.获取view相关联的上下文
//        CGContextRef ctx = UIGraphicsGetCurrentContext() ;
//        //2.描述路径
//        CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) ;
//    //    NSLog(@"%@",NSStringFromCGPoint(center)) ;
//        CGFloat radius = rect.size.height * 0.5;
//    //    NSLog(@"%f",radius) ;
//        CGFloat startAngle = -M_PI_2 ;
//        CGFloat endAngle = startAngle + self.value * M_PI * 2 ;
//        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES] ;
//        if (self.mkColor == nil) {
//            self.mkColor = [UIColor lightGrayColor];
//        }
//        [self.mkColor set] ;
//
//        //关闭路径
//        [path addLineToPoint:center];
//
//        //3.把路径添加到上下文
//        CGContextAddPath(ctx, path.CGPath) ;
//        //4.把上下文的l内容渲染到View上
//    //    CGContextStrokePath(ctx) ;
//        CGContextFillPath(ctx) ;
//
//}
- (void)drawProgress:(CGFloat )progress
{
    _progress = progress;
    [_progressLayer removeFromSuperlayer];
    [_gradientLayer removeFromSuperlayer];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawCycleProgress];
    
}

- (void)drawCycleProgress
{
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = self.bounds.size.width/2 - 1;
    CGFloat startA = - M_PI_2;  //设置进度条起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //设置进度条终点位置
    
    
    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    _progressLayer = [CAShapeLayer layer];//创建一个track shape layer
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _progressLayer.strokeColor = [[UIColor redColor] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    _progressLayer.opacity = 1; //背景颜色的透明度
    _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressLayer.lineWidth = 2;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆形
    _progressLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [self.layer addSublayer:_progressLayer];
    //生成渐变色
    _gradientLayer = [CALayer layer];
    
    //左侧渐变色
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);    // 分段设置渐变色
    leftLayer.locations = @[@1, @1, @1];
    leftLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor redColor].CGColor];
    [_gradientLayer addSublayer:leftLayer];
    
    //右侧渐变色
    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2, self.bounds.size.height);
    rightLayer.locations = @[@1, @1, @1];
    rightLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor redColor].CGColor];
    [_gradientLayer addSublayer:rightLayer];
    
    [self.layer setMask:_progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:_gradientLayer];
}
@end
