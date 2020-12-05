//
//  MakeCoinRuleView.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/4.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MakeCoinRuleView.h"
#import <Masonry/Masonry.h>
#import "WPAlertControl.h"
#import "WPView.h"

@interface MakeCoinRuleView()

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *subLabel;

@property(nonatomic,strong) UIButton *contineButton;
@property(nonatomic,strong) UIButton *seeCoinButton;

@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,weak) UIViewController *rootVc;
@end

@implementation MakeCoinRuleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.subLabel];
        [self addSubview:self.contineButton];
        [self addSubview:self.seeCoinButton];
        [self addSubview:self.textView];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(30);
            make.left.equalTo(self.mas_left).offset(20);
        }];
        [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
        
        CGFloat offsetCenterX = 70;
        
        [self.contineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(-offsetCenterX);
            make.width.equalTo(@(120));
            make.height.equalTo(@(40));
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
        
        [self.seeCoinButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(offsetCenterX);
            make.width.equalTo(@(120));
            make.height.equalTo(@(40));
            make.bottom.equalTo(self.mas_bottom).offset(-20);
        }];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subLabel.mas_bottom).offset(20);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.seeCoinButton.mas_top).offset(-20);
        }];
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = 12;
        self.layer.masksToBounds = true;
        
        
    }
    return self;
}
+(MakeCoinRuleView *)ruleView {
    MakeCoinRuleView *view = [[MakeCoinRuleView alloc] initWithFrame:CGRectMake(0, 0, 300, 490)];
    return view;
}


-(UILabel *)titleLabel {
    if(_titleLabel == nil) {
        _titleLabel = UILabel.new;
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.text = @"赚币规则";
    }
    return _titleLabel;
}


-(UILabel *)subLabel {
    if(_subLabel == nil) {
        _subLabel = UILabel.new;
        _subLabel.textColor = UIColor.blackColor;
        _subLabel.text = @"刷视频得抖币";
    }
    return _subLabel;
}

-(UIButton *)contineButton {
    if(_contineButton == nil) {
        _contineButton = UIButton.new;
        _contineButton.backgroundColor = UIColor.blueColor;
        _contineButton.layer.cornerRadius = 20;
        _contineButton.layer.masksToBounds = true;
        _contineButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_contineButton addTarget:self action:@selector(contineClick) forControlEvents:UIControlEventTouchUpInside];
        [_contineButton setTitle:@"继续赚抖币" forState:UIControlStateNormal];
    }
    return _contineButton;
}

-(UIButton *)seeCoinButton {
    if(_seeCoinButton == nil) {
        _seeCoinButton = UIButton.new;
        _seeCoinButton.backgroundColor = UIColor.blueColor;
        _seeCoinButton.layer.cornerRadius = 20;
        _seeCoinButton.layer.masksToBounds = true;
        _seeCoinButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_seeCoinButton addTarget:self action:@selector(seeCoinClick) forControlEvents:UIControlEventTouchUpInside];
        [_seeCoinButton setTitle:@"看看我的抖币" forState:UIControlStateNormal];
    }
    return _seeCoinButton;
}
-(UITextView *)textView {
    if(_textView == nil) {
        _textView = UITextView.new;
        _textView.userInteractionEnabled = NO;
        _textView.backgroundColor = UIColor.whiteColor;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.text = @"抖动的小伙伴们，可以一边观看视频一边获得抖币哦！看得越多，送得越多，每天可以无限获得抖币。\n\n抖币领取时长为每90秒可自动领取一次，每次领取的数量均不同。注意不要一直停留在当前视频哦，如果当前视频观看完后，仍然停留在当前视频重复播放，则抖币领取倒计时将暂停。\n\n小小抖币大有用途，所获取的抖币可以进行余额的兑换，每10000抖币可兑换1元人民币。兑换的余额可以根据相应的规则进行提现，让您有玩游戏的资格，赚更多的钱！享受成人盛宴的同时顺带把钱赚了，还不赶快行动！";
    }
    return  _textView;
}

-(void)show:(UIViewController *)rootVc {
    self.rootVc = rootVc;
    [WPAlertControl alertForView:self
                           begin:WPAlertBeginCenter
                             end:WPAlertEndCenter
                     animateType:WPAlertAnimateBounce
                        constant:0
            animageBeginInterval:0.3
              animageEndInterval:0.1
                       maskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]
                             pan:YES
                     rootControl:rootVc
                       maskClick:^BOOL(NSInteger index, NSUInteger alertLevel, WPAlertControl *alertControl) {
//        @strongify(self)
        return NO;
    }
                   animateStatus:nil];
    
}

-(void)dismiss:(UIViewController *)rootVc {
    [WPAlertControl alertHiddenForRootControl:rootVc completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
    }];
}


-(void)contineClick {
    [self dismiss:self.rootVc];
}

-(void)seeCoinClick {
    [WPAlertControl alertHiddenForRootControl:self.rootVc completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
        if(status == WPAnimateDidDisappear) {
            self.seeCoinBlock();
        }
    }];
}

@end
