
//
//  MKAdLoadView.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/28/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKAdLoadView.h"

@interface MKAdLoadView()

@end

@implementation MKAdLoadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self mkAddSubView];
        
        [self mkLayOutView];
    }
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self addSubview:self.mkImageView];
    
    [self addSubview:self.mkTitleLabel];
    
    [self addSubview:self.mkDecribeLabel];
    
    [self addSubview:self.mkButton];
}
#pragma mark - 布局子视图
-(void)mkLayOutView{
    
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(50*1));
        
        make.width.equalTo(@(80*1));
        
        make.height.equalTo(@(80*1));
        
        make.top.equalTo(@(40*1));
        
        
    }];
    
    [self.mkTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mkImageView.mas_right).offset(0);
        
        make.top.equalTo(@(40*1));
        
        make.right.equalTo(self.mas_right).offset(-50*1);
    }];
    
    
    [self.mkDecribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mkImageView.mas_right).offset(0);
        
        make.top.equalTo(self.mkImageView.mas_centerY);
                
        make.right.equalTo(self.mas_right).offset(-50*1);
    }];
    
    
    [self.mkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(50*1));

        make.right.equalTo(@(-50*1));
        
        make.height.equalTo(@(46*1));
        
        make.bottom.equalTo(self.mas_bottom).offset(-KBottomHeight);
    }];
    
}



#pragma mark - setter

- (UIImageView *)mkImageView{
    
    if (!_mkImageView) {
        
        _mkImageView = [[UIImageView alloc]init];
    }
    return _mkImageView;
}

- (UILabel *)mkTitleLabel{
    
    if (!_mkTitleLabel) {
        
        _mkTitleLabel = [[UILabel alloc]init];
        
        _mkTitleLabel.numberOfLines = 0;
        _mkTitleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        
    }
    
    return _mkTitleLabel;
}

- (UILabel *)mkDecribeLabel{
    
    if (!_mkDecribeLabel) {
        
        _mkDecribeLabel = [[UILabel alloc]init];
        
        _mkDecribeLabel.numberOfLines = 0;
        
        _mkDecribeLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
    }
    
    return _mkDecribeLabel;
}

- (UIButton *)mkButton{
    
    if (!_mkButton) {
        
        _mkButton = [[UIButton alloc]init];
        
        [_mkButton setTitle:@"立即下载" forState:UIControlStateNormal];
        
        _mkButton.backgroundColor = HEXCOLOR(0xF54B64);
        
        [_mkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
    return _mkButton;
}
@end
