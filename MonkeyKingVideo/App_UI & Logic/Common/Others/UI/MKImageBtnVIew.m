//
//  MKImageBtnVIew.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/5/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKImageBtnVIew.h"

@interface MKImageBtnVIew()

@end

@implementation MKImageBtnVIew

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self mkAddSubView];
        [self mkLayOutView];
    }return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    [self addSubview:self.mkImageView];
    [self addSubview:self.mkTitleLable];
    [self addSubview:self.mkButton];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(0);
//        make.width.height.equalTo(@(25 *KDeviceScale));
    }];
    [self.mkTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
//        make.top.equalTo(self.mkImageView.mas_bottom).offset(0);
        make.bottom.equalTo(self);
    }];
    [self.mkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark —— lazyLoad
- (UIImageView *)mkImageView{
    if (!_mkImageView) {
        _mkImageView = [[UIImageView alloc]init];
        _mkImageView.clipsToBounds = YES;
        _mkImageView.contentMode = UIViewContentModeCenter;
    }return _mkImageView;
}

- (UILabel *)mkTitleLable{
    if (!_mkTitleLable) {
        _mkTitleLable = [[UILabel alloc]init];
        _mkTitleLable.font = [UIFont systemFontOfSize:12
                                               weight:UIFontWeightRegular];
        _mkTitleLable.textColor = HEXCOLOR(0xFFFFFF);
        _mkTitleLable.textAlignment = NSTextAlignmentCenter;
    }return _mkTitleLable;
}

- (UIButton *)mkButton{
    if (!_mkButton) {
        _mkButton = UIButton.new;
        _mkButton.uxy_acceptEventInterval = 0.5f;//防止重复点击
        _mkButton.backgroundColor = [UIColor clearColor];
    }return _mkButton;
}

@end
