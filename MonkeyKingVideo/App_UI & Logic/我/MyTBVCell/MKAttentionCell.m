//
//  MKAttentionCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKAttentionCell.h"

@implementation MKAttentionCell

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
        
        self.contentView.backgroundColor = MKBakcColor;
        self.layer.cornerRadius= 5.0f;
        self.layer.masksToBounds=YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self mkAddSubView];
        
        [self mkLayOutView];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
  frame.origin.x = 2;//这里间距为10，可以根据自己的情况调整
  frame.size.width -= frame.origin.x;
  frame.size.height -= 5 * frame.origin.x;
  [super setFrame:frame];
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self addSubview:self.mKIMGageView];
    
    [self addSubview:self.mkTitleLable];
    
    [self addSubview:self.mkDecripLabel];
    
    [self addSubview:self.mkLineView];
    
    
    [self addSubview:self.mkFansLabel];
    
    
    [self addSubview:self.mkOutListButton];
    [self addSubview:self.vipImgage];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mKIMGageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(15*KDeviceScale));
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.height.equalTo(@(50*KDeviceScale));
    }];
    
    [self.mkTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mKIMGageView.mas_right).offset(10*KDeviceScale);
        
        make.top.equalTo(self.mKIMGageView.mas_top);
//        make.height.offset(SCALING_RATIO(22));
        make.width.mas_lessThanOrEqualTo(kScreenWidth-150);
        
       }];
    [self.vipImgage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mkTitleLable.mas_right).offset(6*KDeviceScale);
        make.top.equalTo(self.mkTitleLable.mas_top);
        make.centerY.mas_equalTo(self.mkTitleLable.mas_centerY);
        make.width.equalTo(@(19 *KDeviceScale));
        make.height.equalTo(@(17 *KDeviceScale));
    }];
    
    [self.mkDecripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mKIMGageView.mas_right).offset(10*KDeviceScale);
        
        make.top.equalTo(self.mkTitleLable.mas_bottom);
        make.height.offset(SCALING_RATIO(18));
        make.width.mas_lessThanOrEqualTo(kScreenWidth-150);
    }];
    
    [self.mkLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mKIMGageView.mas_right).offset(10*KDeviceScale);
        
        make.right.equalTo(self.mas_right);
        
        make.height.equalTo(@(0.5));
        
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    [self.mkFansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mKIMGageView.mas_right).offset(10*KDeviceScale);
        
        make.top.equalTo(self.mkDecripLabel.mas_bottom);
        make.height.offset(SCALING_RATIO(13));
    }];
    
    [self.mkOutListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-11*KDeviceScale);
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.height.equalTo(@(26 * KDeviceScale));
        
        make.width.equalTo(@(56 * KDeviceScale));
    }];
    
}
#pragma mark - setter

- (UIImageView *)mKIMGageView{
    
    if (!_mKIMGageView) {
        
        _mKIMGageView = [[UIImageView alloc]init];
        
        [MKTools mkSetStyleDefalutImageview:_mKIMGageView];
        
        _mKIMGageView.layer.masksToBounds = YES;
        
        _mKIMGageView.layer.cornerRadius = 25 * KDeviceScale;
        
    }
    return _mKIMGageView;
}

- (UIImageView *)vipImgage {
    if (!_vipImgage) {
        
        _vipImgage = [[UIImageView alloc]init];
          _vipImgage.image = KIMG(@"icon_userVIP");
//        [MKTools mkSetStyleDefalutImageview:_vipImgage];
//        
//        _vipImgage.layer.masksToBounds = YES;
//        
//        _vipImgage.layer.cornerRadius = 25 * KDeviceScale;
        
    }
    return _vipImgage;
}

- (UILabel *)mkTitleLable{
    
    if (!_mkTitleLable) {
        
        _mkTitleLable = [[UILabel alloc]init];
        
        _mkTitleLable.text = @"系统消息";
        _mkTitleLable.textColor = UIColor.whiteColor;
        _mkTitleLable.font = [UIFont systemFontOfSize:16];
    }
    return _mkTitleLable;
}

- (UILabel *)mkDecripLabel{
    
    if (!_mkDecripLabel) {
        
        _mkDecripLabel = [[UILabel alloc]init];
        
        _mkDecripLabel.text = @"发布违规信息或者广告，平台有权处理";
        _mkDecripLabel.textColor = RGBCOLOR(78, 88, 110);
        _mkDecripLabel.font = [UIFont systemFontOfSize:13];
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
        _mkFansLabel.text = @"粉丝 25W";
        _mkFansLabel.textColor = [UIColor whiteColor];
        
        _mkFansLabel.font = [UIFont systemFontOfSize:9];
    }
    
    return _mkFansLabel;
}
- (UIButton *)mkOutListButton{
    
    if (!_mkOutListButton) {
        
        _mkOutListButton = [[UIButton alloc]init];
        
        [_mkOutListButton titleLabel].font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
        
        [_mkOutListButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_mkOutListButton setTitle:@"已关注" forState:UIControlStateSelected];
        [_mkOutListButton setTitle:@"关注" forState:UIControlStateNormal];
        
        [_mkOutListButton setBackgroundImage:[UIImage imageNamed:@"gradualColor"] forState:UIControlStateNormal];
        
        
        _mkOutListButton.layer.masksToBounds = YES;
        
        _mkOutListButton.layer.cornerRadius = 13*KDeviceScale;
    }
    
    return _mkOutListButton;
}
@end
