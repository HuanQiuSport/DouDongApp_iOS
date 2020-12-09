//
//  MKActionView.m
//  MonkeyKingVideo
//
//  Created by george on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKActionView.h"
@interface MKActionView()

@property(nonatomic,strong)UIButton *shadow; //阴影
@property(nonatomic,strong)UILabel *titleLabel; //主标题
@property(nonatomic,strong)UIButton *cancelBtn; //取消
@property(nonatomic,strong)UIButton *confirmBtn; //确定

@end

@implementation MKActionView

+ (instancetype)show:(id)delegate{
    
    UIWindow *window = getMainWindow();
    MKActionView *view = [[MKActionView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    view.delegate = delegate;
    [window addSubview:view];
    
    view.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        view.alpha = 1;
    }];
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setSubviews];
    }
    return self;
}

#pragma mark Event
- (void)confirmEvent{
    [self remove];
    [self.delegate mkDeleteActionViewConfirm];
}

- (void)cancelEvent{
   [self remove];
}

- (void)shadowEvent{
    [self remove];
}

- (void)remove{
    self.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark UI
- (void)setSubviews{
    self.backgroundColor = [UIColor clearColor];
    
    _shadow = [[UIButton alloc]init];
    _shadow.alpha = 0.4;
    _shadow.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT);
    _shadow.backgroundColor = [UIColor blackColor];
    [_shadow addTarget:self action:@selector(shadowEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_shadow];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kWhiteColor;//COLOR_HEX(0x1F242F, 1);
    view.frame = CGRectMake((MAINSCREEN_WIDTH-260)/2, (MAINSCREEN_HEIGHT-100)/2, 260, 100);
    view.layer.cornerRadius = 5;
    [self addSubview:view];
    
    CGFloat uniformHeight  = view.height/2;
    CGFloat uniformWidth  = view.width/2;
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"是否删除上一段视频";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = kBlackColor;//[UIColor whiteColor];
    _titleLabel.frame = CGRectMake(0, 0, view.width, uniformHeight);
    [view addSubview:_titleLabel];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = RGBCOLOR(222, 222, 222);//[UIColor blackColor];
    line.frame = CGRectMake(0, uniformHeight, view.width, 0.5f);
    [view addSubview:line];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = RGBCOLOR(222, 222, 222);//[UIColor blackColor];
    bottomLine.frame = CGRectMake(uniformWidth, uniformHeight, 0.5f, uniformHeight);
    [view addSubview:bottomLine];
    
    _cancelBtn = [[UIButton alloc]init];
    _cancelBtn.frame = CGRectMake(0, uniformHeight, uniformWidth, uniformHeight);
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelEvent) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_cancelBtn];
    
    _confirmBtn = [[UIButton alloc]init];
    _confirmBtn.frame = CGRectMake(uniformWidth, uniformHeight, uniformWidth, uniformHeight);
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_confirmBtn];
}

@end
