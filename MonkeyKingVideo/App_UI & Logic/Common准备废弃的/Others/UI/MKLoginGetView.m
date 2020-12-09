//
//  MKLoginGetView.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/6/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKLoginGetView.h"

@implementation MKLoginGetView

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
    
    [self addSubview:self.mkBackView];
    
    [self addSubview:self.mkImageView];
    
    [self addSubview:self.mkTitleLable];
    
}
#pragma mark - 布局子视图
-(void)mkLayOutView{
    
    [self.mkBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom);
        
        make.left.equalTo(self.mas_left);
        
        make.right.equalTo(self.mas_right);
        
        make.height.equalTo(@(20*1));
        
    }];
    
    [self.mkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left);
        
        make.bottom.equalTo(self.mas_bottom);
    
    }];
    
    [self.mkTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mkImageView.mas_right).offset(2*1);
        
        make.bottom.equalTo(self.mas_bottom);
        
        make.height.equalTo(@(20*1));
        
    }];
}
- (UIView *)mkBackView{
    
    if (!_mkBackView) {
        
        _mkBackView = [[UIView alloc]init];
        
        _mkBackView.backgroundColor = [UIColor blackColor];
        
        _mkBackView.alpha = 0.35;
        
        _mkBackView.layer.cornerRadius = 4;
        
        _mkBackView.layer.masksToBounds = YES;
        
    }
    return _mkBackView;
}
- (UIImageView *)mkImageView{
    
    if (!_mkImageView) {
        
        _mkImageView = [[UIImageView alloc]init];
        
        _mkImageView.image = KIMG(@"红包积分");
    }
    return _mkImageView;
}
- (UILabel *)mkTitleLable{
    
    if (!_mkTitleLable) {
        
        _mkTitleLable = [[UILabel alloc]init];
        
        _mkTitleLable.textColor = [UIColor whiteColor];
        
        _mkTitleLable.text = @"登录看视频领积分";
        
        _mkTitleLable.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        
//        _mkTitleLable.textAlignment = NSTextAlignmentRight;
    }
    return _mkTitleLable;
}
@end
