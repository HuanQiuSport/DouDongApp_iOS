//
//  MKBtnAddBadge.m
//  AllOpenGL
//
//  Created by hansong on 8/26/20.
//  Copyright © 2020 hansong. All rights reserved.
//

#import "MKBtnAddBadge.h"

@implementation MKBtnAddBadge
static MKBtnAddBadge *_tools = nil;
+ (MKBtnAddBadge *)shared{
    @synchronized(self){
        if (!_tools) {
            _tools = MKBtnAddBadge.new;
        }
    }return _tools;
}
- (void)AddBadge:(UIView *)targetView SizeWith:(CGSize)size{
    [self AddBadge:targetView SizeWith:size WithNumber:1];
}
-(void)AddBadge:(UIView *)targetView SizeWith:(CGSize)size WithNumber:(NSInteger)number{
    [self AddBadge:targetView SizeWith:size WithNumber:number WithTargetViewRadius:0];
    
}
-(void)AddBadge:(UIView *)targetView SizeWith:(CGSize)size WithNumber:(NSInteger)number WithTargetViewRadius:(CGFloat)floats{
    [targetView.subviews.firstObject removeFromSuperview];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(46 * 1 - 10 - size.width/2,0,size.width, size.height)];
#pragma warning -  此处不知为何一直获取不到 targetView.bounds | targetView.frame
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,size.width, size.height)];
    imageView.image = KIMG(@"消息number");
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [back addSubview:imageView];
    
    UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(0,-2,size.width, size.height)];
        
    view.textColor = [UIColor whiteColor];
    
    view.layer.cornerRadius = size.width/2.0;
    
    view.layer.masksToBounds = YES;
    
    view.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    
    view.minimumScaleFactor = 0.5;
    
    view.numberOfLines = 1;
//
    [view invalidateIntrinsicContentSize];

    view.adjustsFontSizeToFitWidth = YES;
    
    view.layer.shadowRadius = 1;
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowOpacity = 0.6;
    
    view.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    if (number >= 99) {
        
        view.text  = @" 99+ ";
        
    }else{
        
        view.text  = @(number).stringValue;
        
    }
    
    view.textAlignment = NSTextAlignmentCenter;
    
    [back addSubview:view];
    
    [targetView addSubview:back];
    
    if (number==0) {
        
        back.hidden = YES;
        
    }else{
        
        back.hidden = NO;
        
    }
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(UIImage*) imageToHeadView:(UIImage*)image withParam:(CGFloat)inset{
  
  //先获取大小
  CGFloat lengthW = CGImageGetWidth(image.CGImage);
  CGFloat lengthH = CGImageGetHeight(image.CGImage);
  CGFloat cutSzie;
  //判断长宽比,获得最大正方形裁剪值
  if(lengthW>= lengthH){
      cutSzie = lengthH;
  }
  else cutSzie = lengthW;
  //执行裁剪(为正方形)
//  CGImageRef sourceImageRef = [image CGImage]; //将UIImage转换成CGImageRef
//  CGRect rect = CGRectMake(lengthW/2-cutSzie/2, lengthH/2 - cutSzie/2, cutSzie, cutSzie);  //构建裁剪区
//  CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);    //按照给定的矩形区域进行剪裁
//  UIImage *newImage = [UIImage imageWithCGImage:newImageRef];                     //将CGImageRef转换成UIImage
//  //取圆形
//  UIGraphicsBeginImageContextWithOptions(newImage.size, NO, 0);
//  CGContextRef context = UIGraphicsGetCurrentContext();
//  CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//  CGContextFillPath(context);
//  CGContextSetLineWidth(context, .5);
//  CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
//  CGRect newrect = CGRectMake(inset, inset, newImage.size.width - inset * 2.0f, newImage.size.height - inset * 2.0f);
//  CGContextAddEllipseInRect(context, newrect);
//  CGContextClip(context);
//
//  [newImage drawInRect:newrect];
//  CGContextAddEllipseInRect(context, newrect);
//  CGContextStrokePath(context);
  UIImage *circleImg = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return circleImg;
}
@end
