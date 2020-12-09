//
//  MKInfoFansCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoFansCell.h"

@implementation MKInfoFansCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self mkAddSubView];
        
        [self mkLayOutView];
    }
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self addSubview:self.mKIMGageView];
    
    [self addSubview:self.mkTitleLable];
    
    [self addSubview:self.mkDecripLabel];
    
    [self addSubview:self.mkLineView];
    
    [self addSubview:self.mkLookButton];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mKIMGageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(15*1));
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.height.equalTo(@(46*1));
    }];
    
    [self.mkTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mKIMGageView.mas_right).offset(5*1);
        
        make.top.equalTo(self.mKIMGageView.mas_top);
        
    }];
    
    [self.mkDecripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mKIMGageView.mas_right).offset(5*1);
        
        make.bottom.equalTo(self.mKIMGageView.mas_bottom);
    }];
    
    [self.mkLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mKIMGageView.mas_left).offset(0*1);
        
        make.right.equalTo(self.mas_right);
        
        make.height.equalTo(@(0.5));
        
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.mkLookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mkDecripLabel.mas_centerY).offset(0*1);
        
        make.right.equalTo(self.mas_right).offset(-5*1);
        
    }];
}
#pragma mark - setter

- (UIImageView *)mKIMGageView{
    
    if (!_mKIMGageView) {
        
        _mKIMGageView = [[UIImageView alloc]init];
        
        [MKTools mkSetStyleDefalutImageview:_mKIMGageView];
        
        _mKIMGageView.layer.masksToBounds = YES;
        
        _mKIMGageView.layer.cornerRadius = 5;
        
    }
    return _mKIMGageView;
}
- (UILabel *)mkTitleLable{
    
    if (!_mkTitleLable) {
        
        _mkTitleLable = [[UILabel alloc]init];
        
        _mkTitleLable.text = @"隔壁adey 关注了你";
    }
    return _mkTitleLable;
}

- (UILabel *)mkDecripLabel{
    
    if (!_mkDecripLabel) {
        
        _mkDecripLabel = [[UILabel alloc]init];
        
        _mkDecripLabel.text = @"2020-4-23 20:20:20";
    }
    return _mkDecripLabel;
}
- (UIView *)mkLineView{
    
    if (!_mkLineView) {
        
        _mkLineView = [[UIView alloc]init];
        
        _mkLineView.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    return _mkLineView;
}
- (UIButton *)mkLookButton{
    if (!_mkLookButton) {
        
        _mkLookButton = [[UIButton alloc]init];
        
        [_mkLookButton setTitle:@"去看看 >" forState:UIControlStateNormal];
        
        [_mkLookButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _mkLookButton;
}
@end
