//
//  MKInfoListCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoListCell.h"
@interface MKInfoListCell()

@end

@implementation MKInfoListCell

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
    
     [self addSubview:self.mkTimeLable];
    
    [self addSubview:self.mkNumberLabel];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mKIMGageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(15*KDeviceScale));
        
        make.centerY.equalTo(self.mas_centerY);
        
        make.width.height.equalTo(@(46*KDeviceScale));
    }];
    
    [self.mkTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mKIMGageView.mas_right).offset(5*KDeviceScale);
        
        make.top.equalTo(self.mKIMGageView.mas_top);
        
       }];
    
    [self.mkTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(-20*KDeviceScale);
        
        make.top.equalTo(self.mkTitleLable.mas_top);
        
    }];
       
    
    [self.mkDecripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mKIMGageView.mas_right).offset(5*KDeviceScale);
        
        make.top.equalTo(self.mkTitleLable.mas_bottom).offset(5*KDeviceScale);
    }];
    
    
    [self.mkNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.right.equalTo(self.mas_right).offset(-5*KDeviceScale);
           
           make.centerY.equalTo(self.mkDecripLabel.mas_centerY);
           
    }];
    
    [self.mkLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(20*KDeviceScale);
        
        make.right.equalTo(self.mas_right).offset(-20*KDeviceScale);
        
        make.height.equalTo(@(0.5));
        
        make.bottom.equalTo(self.mas_bottom);
    }];
}
#pragma mark - setter

- (UIImageView *)mKIMGageView{
    
    if (!_mKIMGageView) {
        
        _mKIMGageView = [[UIImageView alloc]init];

//        [MKTools mkSetStyleDefalutImageview:_mKIMGageView];
        
        
    }
    return _mKIMGageView;
}
- (UILabel *)mkTitleLable{
    
    if (!_mkTitleLable) {
        
        _mkTitleLable = [[UILabel alloc]init];
        
        _mkTitleLable.text = @"系统消息";
        
        _mkTitleLable.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    }
    return _mkTitleLable;
}

- (UILabel *)mkDecripLabel{
    
    if (!_mkDecripLabel) {
        
        _mkDecripLabel = [[UILabel alloc]init];
        
         _mkDecripLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        
        _mkDecripLabel.text = @"发布违规信息或者广告，平台有权处理";
    }
    return _mkDecripLabel;
}
- (UIView *)mkLineView{
    
    if (!_mkLineView) {
        
        _mkLineView = [[UIView alloc]init];
        
        _mkLineView.backgroundColor = kHexRGB(0x4c525f);
        
    }
    
    return _mkLineView;
}
- (UILabel *)mkTimeLable{
    
    if (!_mkTimeLable) {
        
        _mkTimeLable = [[UILabel alloc]init];
        
        _mkTimeLable.textColor = [UIColor  whiteColor];
        
        _mkTimeLable.textAlignment = NSTextAlignmentRight;
        
        _mkTimeLable.font =  [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        
        _mkTimeLable.text = @"9:10";
    }
    return _mkTimeLable;
}


- (UILabel *)mkNumberLabel{
    
    if (!_mkNumberLabel) {
        
        _mkNumberLabel = [[UILabel alloc]init];
        
        _mkNumberLabel.textColor = [UIColor whiteColor];
        
        _mkNumberLabel.textAlignment = NSTextAlignmentCenter;
        
        _mkNumberLabel.backgroundColor = [UIColor redColor];
        
        _mkNumberLabel.layer.cornerRadius = 10;
        
        _mkNumberLabel.layer.masksToBounds = YES;
    }
    return _mkNumberLabel;
}
@end
