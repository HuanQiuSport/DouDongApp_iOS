//
//  MKSetingView.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/26/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSetingView.h"

@interface  MKSetingView()
@end


@implementation MKSetingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self mkAddSubView];
        
        [self mkLayoutSubView];
    }
    
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self addSubview:self.mkLeftImageView];
    
    [self addSubview:self.mkLeftLabel];
    
    [self addSubview:self.mkRightLabel];
    
    [self addSubview:self.mkRightImageView];
    
}
#pragma mark - 布局子视图
- (void)mkLayoutSubView{
    
    [self.mkLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(KDeviceScale * 15));
        
        make.width.equalTo(@(KDeviceScale * 20));
        
        make.height.equalTo(@(KDeviceScale * 20));
        
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [MKTools mkSetStyleDefalutImageview:self.mkLeftImageView];
    
    [self.mkLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mkLeftImageView.mas_right).offset( 15 * KDeviceScale);
        
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    self.mkLeftLabel.text = @"猴王视频";
    
    
    [self.mkRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset( -20 * KDeviceScale);
        
        make.height.equalTo(@(KDeviceScale * 20));
        
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.mkRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset( -16 * KDeviceScale);
        
        make.width.equalTo(@(KDeviceScale * 8));
        
        make.height.equalTo(@(KDeviceScale * 14));
        
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    self.mkRightLabel.text = @"猴王视频";
    
//    [MKTools mkSetStyleDefalutImageview:self.mkRightImageView];
    
}

#pragma mark - setter
- (UIImageView *)mkLeftImageView{
    
    if (!_mkLeftImageView) {
        
        _mkLeftImageView = [[UIImageView alloc]init];
        
        _mkLeftImageView.contentMode = UIViewContentModeRedraw;
        
    }
    return _mkLeftImageView;
}

- (UILabel *)mkLeftLabel{
    
    if (!_mkLeftLabel) {
        
        _mkLeftLabel = [[UILabel alloc]init];
        _mkLeftLabel.textColor = UIColor.whiteColor;
        _mkLeftLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _mkLeftLabel;
    
}

- (UIImageView *)mkRightImageView{
    
    if (!_mkRightImageView) {
        
        _mkRightImageView = [[UIImageView alloc]init];
        _mkRightImageView.image = KIMG(@"white_arrow");
        
    }
    
    return _mkRightImageView;
    
}

- (UILabel *)mkRightLabel{
    
    if (!_mkRightLabel) {
        
        _mkRightLabel = [[UILabel alloc]init];
        _mkRightLabel.textColor = UIColor.whiteColor;
        _mkRightLabel.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _mkRightLabel;
    
}
@end
