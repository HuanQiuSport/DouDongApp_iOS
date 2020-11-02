//
//  MKBtnLabelView.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBtnLabelView.h"

@implementation MKBtnLabelView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self mkAddSubView];
    }
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    self.mkNumberLabel.alpha = 1;
    
    self.mkTitleLabel.alpha = 1;
    
    self.mkButton.alpha = 1;
}
#pragma mark - 布局子视图
-(void)mkLayOutView{
    
}
- (UILabel *)mkNumberLabel{
    
    if (!_mkNumberLabel) {
        
        _mkNumberLabel = [[UILabel alloc]init];
        
        _mkNumberLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightHeavy];
        
        _mkNumberLabel.textColor = [UIColor whiteColor];
              
        
        [self addSubview:_mkNumberLabel];
        
        [_mkNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.mas_centerY);
            
            make.centerX.equalTo(self.mas_centerX);
            
        }];
    }
    return _mkNumberLabel;
}

- (UILabel *)mkTitleLabel{
    
    if (!_mkTitleLabel) {
        
        _mkTitleLabel = [[UILabel alloc]init];
        
        _mkTitleLabel.font = [UIFont systemFontOfSize:13.6 weight:UIFontWeightMedium];
        
        _mkTitleLabel.textColor = MKTextColor;
        
        [self addSubview:_mkTitleLabel];
        
        [_mkTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_centerY);
            
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    return _mkTitleLabel;
}
- (UIButton *)mkButton{
    
    if (!_mkButton) {
        
        _mkButton = [[UIButton alloc]init];
        
        [self addSubview:_mkButton];
        
        [_mkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self);
            
        }];
    }
    return _mkButton;
}
@end
