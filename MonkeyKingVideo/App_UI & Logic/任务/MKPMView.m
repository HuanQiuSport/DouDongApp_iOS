//
//  MKPMView.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/16.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKPMView.h"
#import "MKCustomView.h"
@interface MKPMView()
@property(nonatomic,strong)MKCustomView *customView1;
@property(nonatomic,strong)MKCustomView *customView2;
@property(nonatomic,strong)MKCustomView *customView3;
@property(nonatomic,strong)MKCustomView *customView4;
@property(nonatomic,strong)MKCustomView *customView5;
@property(nonatomic,strong)MKCustomView *customView6;

@end
@implementation MKPMView
{
    // 记录位置
    NSInteger currentIndex;
}

#pragma mark - 懒加载
- (MKCustomView *)customView1 {
    if (!_customView1) {
        _customView1 = [[MKCustomView alloc]init];
        [self addSubview:_customView1];
        _customView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick)];
        [_customView1 addGestureRecognizer:tap];
    }
    return _customView1;
}
- (MKCustomView *)customView2 {
    if (!_customView2) {
        _customView2 = [[MKCustomView alloc]init];
        [self addSubview:_customView2];
        _customView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick)];
        [_customView2 addGestureRecognizer:tap];
    }
    return _customView2;
}
- (MKCustomView *)customView3 {
    if (!_customView3) {
        _customView3 = [[MKCustomView alloc]init];
        [self addSubview:_customView3];
        _customView3.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick)];
        [_customView3 addGestureRecognizer:tap];
    }
    return _customView3;
}
- (MKCustomView *)customView4 {
    if (!_customView4) {
        _customView4 = [[MKCustomView alloc]init];
        [self addSubview:_customView4];
        _customView4.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick)];
        [_customView4 addGestureRecognizer:tap];
    }
    return _customView4;
}
- (MKCustomView *)customView5 {
    if (!_customView5) {
        _customView5 = [[MKCustomView alloc]init];
        [self addSubview:_customView5];
        _customView5.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick)];
        [_customView5 addGestureRecognizer:tap];
    }
    return _customView5;
}
- (MKCustomView *)customView6 {
    if (!_customView6) {
        _customView6 = [[MKCustomView alloc]init];
        [self addSubview:_customView6];
        _customView6.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick)];
        [_customView6 addGestureRecognizer:tap];
    }
    return _customView6;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
        // 设置默认数据
        self.animationDuration = 1.f;
        self.pauseDuration = 3.0f;
    }
    return self;
}

-(void)refreshSkin {
    [self.customView1 refreshSkin];
    [self.customView2 refreshSkin];
    [self.customView3 refreshSkin];
    [self.customView4 refreshSkin];
    [self.customView5 refreshSkin];
    [self.customView6 refreshSkin];
}


- (void)setupView {
    
    // 设置Label的frame
    self.customView1.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    self.customView2.frame = CGRectMake(0, 40, self.frame.size.width, 40);
    self.customView3.frame = CGRectMake(0, 80, self.frame.size.width, 40);
    self.customView4.frame = CGRectMake(0, 120, self.frame.size.width, 40);
    self.customView5.frame = CGRectMake(0, 160, self.frame.size.width, 40);
    self.customView6.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 40);
    
    self.clipsToBounds = YES;
}

#pragma mark - 设置动画
-(void)startMarqueeViewAnimation{
    
    if(currentIndex+6 > [self.marqueeTitleArray count]) {
        currentIndex = 0;
    }
    
    // 1.设置滚动前的数据
//    self.customView1.titleLabel.text = self.marqueeTitleArray[currentIndex];
    self.customView1.contentLabel.attributedText = self.marqueeContentArray[currentIndex];
    self.customView1.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    

    
//    self.customView2.titleLabel.text = self.marqueeTitleArray[currentIndex];
    self.customView2.contentLabel.attributedText = self.marqueeContentArray[currentIndex+1];
    self.customView2.frame = CGRectMake(0, 40, self.frame.size.width, 40);
    
    //    self.customView2.titleLabel.text = self.marqueeTitleArray[currentIndex];
    self.customView3.contentLabel.attributedText = self.marqueeContentArray[currentIndex+2];
    self.customView3.frame = CGRectMake(0, 80, self.frame.size.width, 40);
    
    //    self.customView2.titleLabel.text = self.marqueeTitleArray[currentIndex];
    self.customView4.contentLabel.attributedText = self.marqueeContentArray[currentIndex+3];
    self.customView4.frame = CGRectMake(0, 120, self.frame.size.width, 40);
    
    //    self.customView2.titleLabel.text = self.marqueeTitleArray[currentIndex];
    self.customView5.contentLabel.attributedText = self.marqueeContentArray[currentIndex+4];
    self.customView5.frame = CGRectMake(0, 160, self.frame.size.width, 40);
    
    // 即将显示的
    //    self.customView2.titleLabel.text = self.marqueeTitleArray[currentIndex];
    self.customView6.contentLabel.attributedText = self.marqueeContentArray[currentIndex+5];
    self.customView6.frame = CGRectMake(0, 200, self.frame.size.width, 40);
    
    // 提前计算currentIndex
    currentIndex++;
    // 2.开始动画
    [UIView animateWithDuration:self.animationDuration animations:^{
        
        self.customView1.frame = CGRectMake(0, -40, self.frame.size.width,40);
        self.customView2.frame = CGRectMake(0, 0, self.frame.size.width, 40);
        self.customView3.frame = CGRectMake(0, 40, self.frame.size.width, 40);
        self.customView4.frame = CGRectMake(0, 80, self.frame.size.width, 40);
        self.customView5.frame = CGRectMake(0, 120, self.frame.size.width, 40);
        self.customView6.frame = CGRectMake(0, 160, self.frame.size.width, 40);
        
    } completion:^(BOOL finished) {
        
        // 延迟一秒再次启动动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.pauseDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self startMarqueeViewAnimation];
            
        });
        
    }];
}

#pragma mark - 开始动画
- (void)start {
    
    // 设置动画默认第一条信息
    currentIndex = 0;
    
    // 开始动画
    [self startMarqueeViewAnimation];
}
#pragma mark - 点击事件
- (void)onClick {
    if (self.block) {
        self.block(currentIndex);
    }
}
@end
