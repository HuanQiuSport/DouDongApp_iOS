//
//  MKBanner.m
//  MonkeyKingVideo
//
//  Created by hansong on 10/15/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKBanner.h"
#import "TKCarouselView.h"

@implementation MKBanner
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mkImageView.alpha  = 1;
        self.mkCarouselView.alpha = 1; // 隐藏轮播
        [self.mkImageView addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
        
        }];
    }
    return self;
}
- (UIImageView *)mkImageView{
    
    if (!_mkImageView) {
        _mkImageView = [[UIImageView alloc]init];
        _mkImageView.image = [UIImage imageNamed:@"banner"];
        _mkImageView.contentMode = UIViewContentModeScaleAspectFill;
        _mkImageView.frame = CGRectMake(10*KDeviceScale, 0,kScreenWidth - 20*KDeviceScale ,84*KDeviceScale);
        [self addSubview:_mkImageView];
    }
    return _mkImageView;
}

- (TKCarouselView *)mkCarouselView{
    
    if (!_mkCarouselView) {
        NSArray *array = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3658587479,3162190896&fm=26&gp=0.jpg",
                           @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1322896087,2736086242&fm=26&gp=0.jpg",
                           @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2716219330,3814054151&fm=26&gp=0.jpg"];
        _mkCarouselView = [[TKCarouselView alloc]initWithFrame:CGRectMake(KDeviceScale*10, 0,kScreenWidth - 20*KDeviceScale ,84*KDeviceScale)];
        _mkCarouselView.pageControl.currentDotSize = CGSizeMake(18, 5);
        _mkCarouselView.pageControl.otherDotSize = CGSizeMake(12, 5);
        _mkCarouselView.pageControl.currentDotRadius = 2.0;
        _mkCarouselView.pageControl.otherDotRadius = 2.0;
        _mkCarouselView.pageControl.dotSpacing = 8.0;
        _mkCarouselView.placeholderImageView.image = [UIImage imageNamed:@"banner"];
        [self addSubview:_mkCarouselView];
        [_mkCarouselView reloadImageCount:array.count itemAtIndexBlock:^(UIImageView *imageView, NSInteger index) {}
                        imageClickedBlock:^(NSInteger index) {
            NSURL * url = [NSURL URLWithString:@"tingyun.75://"];
            BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
            if (canOpen){//打开微信
                [[UIApplication sharedApplication] openURL:url];
            }else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mkSkipHQAppString]  options:@{}  completionHandler:nil];
            }
        }];
    }
    return _mkCarouselView;
}
@end
