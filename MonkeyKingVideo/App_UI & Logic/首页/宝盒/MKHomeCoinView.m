//
//  MKHomeCoinView.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/14/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKHomeCoinView.h"

@implementation MKHomeCoinView
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
    [self addSubview:self.mkImageView];
    
    [self addSubview:self.mkCoinNumberLabel];
}
#pragma mark - 布局子视图
-(void)mkLayOutView{
    
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        
        make.left.equalTo(self);
        
        make.width.equalTo(@(14*KDeviceScale));
        
        make.height.equalTo(@(14*KDeviceScale));
        
    }];
    
    [self.mkCoinNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mkImageView.mas_right);
        
        make.centerY.equalTo(self.mkImageView.mas_centerY);
        
        make.width.equalTo(@(49*KDeviceScale));
        
        make.height.equalTo(@(15*KDeviceScale));
        
    }];
}
- (UIImageView *)mkImageView{
    
    if (!_mkImageView) {
        
        _mkImageView = [[UIImageView alloc]init];
        
        _mkImageView.image = KIMG(@"mk_coin");
    }
    return _mkImageView;
}
- (UILabel *)mkCoinNumberLabel{
    
    if (!_mkCoinNumberLabel) {
        
        _mkCoinNumberLabel = [[UILabel alloc]init];
        
        _mkCoinNumberLabel.font = [UIFont fontWithName:@"FZPWJW--GB1-0" size:14];
        
        _mkCoinNumberLabel.textColor = kHexRGB(0xfacb7a);
    }
    return _mkCoinNumberLabel;
}

@end
