//
//  MKPlayUserInfoView.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/5/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKPlayUserInfoView.h"

@interface MKPlayUserInfoView()

@end

@implementation MKPlayUserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self mkAddSubView];
        
        [self mkLayOutView];
    }
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self addSubview:self.mkDescribeLabel];
    
    [self addSubview:self.mkUserImageView];
    
    [self addSubview:self.mkUserNameLabel];
    
    [self addSubview:self.mkAttentionButton];
    
    [self addSubview:self.mkGouImageView];
    
    [self addSubview:self.mkRightBtuttonView];
    
    [self addSubview:self.mkLoginView];
    
    [self addSubview:self.mkStatusImage];
    
    [self addSubview:self.mkAdView];
    
    [self addSubview:self.mkAdGuideLabel];
    
    [self addSubview:self.mkAdLogoLabel];

    
    self.mkLoginView.hidden =  self.mkAdGuideLabel.hidden =  self.mkAdLogoLabel.hidden =  self.mkAdView.hidden = YES;
    
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    
    [self.mkDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(20*1);
        
        make.bottom.equalTo(self.mas_bottom).offset(- kTabBarHeight - KBottomHeight- 5*1);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.7);
        
    }];
    [self.mkUserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(16 * 1);
        
        make.bottom.equalTo(self.mkDescribeLabel.mas_top).offset(-5 * 1);
        
        make.width.height.equalTo(@(35 * 1));
    }];
    
    
    [self.mkUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mkUserImageView.mas_right).offset(5 * 1);
        
        make.centerY.equalTo(self.mkUserImageView.mas_centerY);
        
        make.width.lessThanOrEqualTo(@(120 * 1));
        
    }];
    
    [self.mkAttentionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mkUserNameLabel.mas_right).offset(5 * 1);
        
        make.centerY.equalTo(self.mkUserImageView.mas_centerY);
        
        make.width.equalTo(@(44 * 1));
        
        make.height.equalTo(@(20 * 1));
        
    }];
    
    [self.mkGouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mkAttentionButton.mas_centerX);
        
        make.centerY.equalTo(self.mkAttentionButton.mas_centerY);
        
        make.width.equalTo(@(20 * 1));
        
        make.height.equalTo(@(20 * 1));
        
    }];
    
    
    
    [self.mkRightBtuttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(0 * 1);
        
        make.width.equalTo(@(60 * 1));
        
        make.height.equalTo(@(180 * 1 ));
        
        make.bottom.equalTo(self.mkUserNameLabel.mas_bottom);
        
       }];
    
    [self.mkLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(5 * 1);
        
        make.width.equalTo(self.mas_width).multipliedBy(0.5);
        
        make.height.equalTo(@(60 * 1));
        
//        make.bottom.equalTo(self.mkUserImageView.mas_top).offset(-10 *1);
        make.top.equalTo(self.mas_top).offset(44 + rectOfStatusbar());
    }];
    
    
    [self.mkStatusImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        
    }];
    
    [self.mkAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        
        make.left.equalTo(self);
        
        make.right.equalTo(self);
        
        make.top.equalTo(self.mkDescribeLabel.mas_top);
    }];
    
    [self.mkAdGuideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(40));
        
        make.width.equalTo(@(200));
        
        make.left.equalTo(self.mkUserImageView.mas_left);
        
        make.centerY.equalTo(self.mkAdView.mas_centerY);
        
    }];
    
    
    [self.mkAdLogoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(40));
        
        make.width.equalTo(@(40));
        
        make.left.equalTo(self.mkAdGuideLabel.mas_right);
        
        make.centerY.equalTo(self.mkAdView.mas_centerY);
        
    }];
    
}
- (UIImageView *)mkUserImageView{
    
    if (!_mkUserImageView) {
        
        _mkUserImageView = [[UIImageView alloc]init];
        
        _mkUserImageView.backgroundColor = [UIColor redColor];
        
        _mkUserImageView.layer.cornerRadius = 35*1/2;
        
        _mkUserImageView.layer.masksToBounds = YES;
        
        _mkUserImageView.userInteractionEnabled = YES;
    }
    return _mkUserImageView;
}
- (UILabel *)mkDescribeLabel{
    
    if (!_mkDescribeLabel) {
        
        _mkDescribeLabel = [[UILabel alloc]init];
        
        _mkDescribeLabel.textColor = HEXCOLOR(0xFFFFFF);
        
        _mkDescribeLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        
        _mkDescribeLabel.text = @"这位小姐姐太厉害了";
    }
    return _mkDescribeLabel;
}
- (UILabel *)mkUserNameLabel{
    
    if (!_mkUserNameLabel) {
        
        _mkUserNameLabel = [[UILabel alloc]init];
        
        _mkUserNameLabel.textColor = HEXCOLOR(0xFFFFFF);
        
        _mkUserNameLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        
        _mkUserNameLabel.text = @"@色情网";
        
        _mkUserNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _mkUserNameLabel;
}
- (UIButton *)mkAttentionButton{
    
    if (!_mkAttentionButton) {
        
        _mkAttentionButton = [[UIButton alloc]init];
        [_mkAttentionButton setBackgroundImage:[UIImage imageNamed:@"gradualColor"] forState:UIControlStateNormal];
        [_mkAttentionButton setBackgroundImage:[UIImage imageNamed:@"clearColor"] forState:UIControlStateSelected];
//        [_mkAttentionButton setImage:[UIImage imageNamed:@"selectedImage"] forState:UIControlStateSelected];
        // 等待UI给图我再去处理
//        [_mkAttentionButton setImage:[UIImage animatedImageNamed:@"勾选" duration:0.5] forState:UIControlStateSelected];
        [_mkAttentionButton setTitle:@"关注" forState:UIControlStateNormal];
        
        [_mkAttentionButton setTitle:@"" forState:UIControlStateSelected];
        
        [_mkAttentionButton titleLabel].font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        
        [_mkAttentionButton setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
                
        _mkAttentionButton.layer.cornerRadius = 10 *1;
        
        _mkAttentionButton.layer.masksToBounds = YES;
    }
    return _mkAttentionButton;
}
- (MKRightBtnView *)mkRightBtuttonView{
    
    if (!_mkRightBtuttonView) {
        
        _mkRightBtuttonView = [[MKRightBtnView alloc]init];
    }
    return _mkRightBtuttonView;
}
- (MKLoginGetView *)mkLoginView{
    
    if (!_mkLoginView) {
        
        _mkLoginView = [[MKLoginGetView alloc]init];
        
    }
    return _mkLoginView;
}
- (UIImageView *)mkStatusImage{
    
    if (!_mkStatusImage) {
        
        _mkStatusImage = [[UIImageView alloc]init];
    }
    return _mkStatusImage;
}
- (UIView *)mkAdView{
    
    if (!_mkAdView) {
        
        _mkAdView = [[UIView alloc]init];
        
        _mkAdView.backgroundColor = [UIColor clearColor];
        
        _mkAdView.layer.cornerRadius = 3;
        
        _mkAdView.layer.masksToBounds = YES;
        
    }
    return _mkAdView;
}
- (UILabel *)mkAdGuideLabel{
    
    if (!_mkAdGuideLabel) {
        
        _mkAdGuideLabel = [[UILabel alloc]init];
        
        _mkAdGuideLabel.text = @"去玩一下";
        
        _mkAdGuideLabel.layer.cornerRadius = 3;
        
        _mkAdGuideLabel.layer.masksToBounds = YES;
        
        
        _mkAdGuideLabel.textAlignment = NSTextAlignmentCenter;
        
        _mkAdGuideLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium];
        
        _mkAdGuideLabel.textColor = [UIColor whiteColor];
        
        _mkAdGuideLabel.backgroundColor = [UIColor redColor];
    }
    return _mkAdGuideLabel;
}

- (UILabel *)mkAdLogoLabel{
    
    if (!_mkAdLogoLabel) {
        
        _mkAdLogoLabel = [[UILabel alloc]init];
        
        _mkAdLogoLabel.layer.cornerRadius = 10;
        
        _mkAdLogoLabel.layer.masksToBounds = YES;
        
        
//        _mkAdLogoLabel.text = @"广告";
        
        _mkAdLogoLabel.textColor = [UIColor whiteColor];
        
//        _mkAdLogoLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    }
    return _mkAdLogoLabel;
}
- (UIImageView *)mkGouImageView{
    
    if (!_mkGouImageView) {
        
        _mkGouImageView = [[UIImageView alloc]init];
        
      
        
        _mkGouImageView.hidden = YES;
    }
    return _mkGouImageView;
}
@end
