//
//  MKAnimations.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKAnimations.h"

@interface MKAnimations ()

@end

@implementation MKAnimations

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)moveUpSCaleBig:(UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animation
     view.transform = CGAffineTransformMakeScale(0.00001f, 0.00001f);
//     NSLog(@"up 1%@",view);
     [UIView animateWithDuration:duration animations:^{
         view.transform = CGAffineTransformIdentity;
         view.frame = CGRectMake(view.frame.origin.x-50,view.frame.origin.y-length-50,100,100);
//         view.center = CGPointMake(view.center.x, view.center.y-length);
       
     } completion:^(BOOL finished) {
         done = NO;
     }];
    
//     while (done == YES)
//         [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
//
}
+ (void)moveDownScaleSmall:(UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animationxxx
//    NSLog(@"down 1%@",view);
    view.transform =CGAffineTransformMakeScale(1,1);
    [UIView animateWithDuration:duration animations:^{
        view.transform = CGAffineTransformIdentity;
        view.transform =CGAffineTransformMakeScale(0.00001f,0.00001f);
//        view.frame = CGRectMake(100,250,0.0001,0.00001);
        view.frame = CGRectMake(view.frame.origin.x,view.frame.origin.y+length,0.0001,0.00001);
        
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
//    while (done == YES)
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
//    
//    NSLog(@"down 2%@",view);
}

+ (void) moveDown: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x, view.center.y + length);
        
    } completion:^(BOOL finished) {
        done = NO;
    }];
    // wait for animation to finish
//    while (done == YES)
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
+ (void) moveUp: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length{
    __block BOOL done = wait; //wait =  YES wait to finish animation
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x, view.center.y-length);

    } completion:^(BOOL finished) {
        done = NO;
    }];
//    // wait for animation to finish
//    while (done == YES)
//        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
}
@end
