//
//  MKBlackListCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBlackListCell.h"

@implementation MKBlackListCell

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
    
    
    [self addSubview:self.mkFansLabel];
    
    
    [self addSubview:self.mkOutListButton];
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
        
        make.top.equalTo(self.mkTitleLable.mas_bottom);
        
        make.width.equalTo(@(120*1));
    }];
    
    [self.mkLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mKIMGageView.mas_right).offset(5*1);
        
        make.right.equalTo(self.mas_right);
        
        make.height.equalTo(@(0.5));
        
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    [self.mkFansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mKIMGageView.mas_right).offset(5*1);
        
        make.top.equalTo(self.mkDecripLabel.mas_bottom);
        
    }];
    
    [self.mkOutListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-5*1);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.height.equalTo(@(40));
        
        make.width.equalTo(@(120));
    }];
    
}
#pragma mark - setter

- (UIImageView *)mKIMGageView{
    
    if (!_mKIMGageView) {
        
        _mKIMGageView = [[UIImageView alloc]init];
        
        [MKTools mkSetStyleDefalutImageview:_mKIMGageView];
        
        _mKIMGageView.layer.masksToBounds = YES;
        
        _mKIMGageView.layer.cornerRadius = 23 * 1;
        
    }
    return _mKIMGageView;
}
- (UILabel *)mkTitleLable{
    
    if (!_mkTitleLable) {
        
        _mkTitleLable = [[UILabel alloc]init];
        
        _mkTitleLable.text = @"系统消息";
        
        _mkTitleLable.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    }
    return _mkTitleLable;
}

- (UILabel *)mkDecripLabel{
    
    if (!_mkDecripLabel) {
        
        _mkDecripLabel = [[UILabel alloc]init];
        
        _mkDecripLabel.text = @"发布违规信息或者广告，平台有权处理";
        
        _mkDecripLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
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

- (UILabel *)mkFansLabel{
    
    if (!_mkFansLabel) {
        
        _mkFansLabel = [[UILabel alloc]init];
//        _mkFansLabel.text = @"粉丝 25W";
        _mkFansLabel.textColor = [UIColor blackColor];
        
        _mkFansLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    }
    
    return _mkFansLabel;
}
- (UIButton *)mkOutListButton{
    
    if (!_mkOutListButton) {
        
        _mkOutListButton = [[UIButton alloc]init];
        
        _mkOutListButton.layer.borderColor = [UIColor blackColor].CGColor;
        
        [_mkOutListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _mkOutListButton.layer.borderWidth = 2;
        
        _mkOutListButton.layer.cornerRadius = 4;
    }
    
    return _mkOutListButton;
}
@end
