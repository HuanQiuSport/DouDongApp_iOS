//
//  MKInfoDetailCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoDetailCell.h"
#import "MKSysModel.h"
#import "NSString+MHCommon.h"
@interface MKInfoDetailCell()

///底部背景view
@property (strong,nonatomic) UIView *mkbackgroudView;

/// 信息内容
@property (strong,nonatomic) UILabel *mkInfoLabel;

/// 信息时间
@property (strong,nonatomic) UILabel *mkTimeLabel;

@end

@implementation MKInfoDetailCell

+ (instancetype) MKInfoDetailCellWith:(UITableView *)tableView{
    static NSString *cellIdentifier = @"MKSysInfoDetailAll";
    MKInfoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MKInfoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];  
    }
    cell.backgroundColor = MKBakcColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self mkAddSubView];
        [self mkLayOutView];
    }
    return self;
}

#pragma mark - 数据
- (void)setModel:(MKSysModel *)model{
    _model = model;
    
    if(model.videoName && [model.context containsString:model.videoName]){
        NSString *context = [model.context stringByReplacingOccurrencesOfString:model.videoName withString:[NSString stringWithFormat:@"  %@  ",model.videoName]];
        NSRange range = [context rangeOfString:model.videoName];
        NSMutableAttributedString *contextAs = [[NSMutableAttributedString alloc]initWithString:context];
        [contextAs addAttribute:NSForegroundColorAttributeName      value:COLOR_HEX(0xF78361, 1) range:range];

        self.mkInfoLabel.attributedText = contextAs;
    }else{
        self.mkInfoLabel.text = model.context;
    }
    self.mkTimeLabel.text = model.createTime;
    
    CGFloat height = [model.context textForLabHeightWithTextWidth:SCREEN_W - 38 * 2 * KDeviceScale font:kFontSize(18) ];
    height += 80*KDeviceScale;
    model.height  = [NSString stringWithFormat:@"%lf",height];
}

#pragma mark - 添加子视图
- (void)mkAddSubView{
    [self addSubview:self.mkbackgroudView];
    [self addSubview:self.mkInfoLabel];
    [self addSubview:self.mkTimeLabel];
}

#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mkbackgroudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20*KDeviceScale);
        make.right.equalTo(self.mas_right).offset(-20*KDeviceScale);
        make.top.equalTo(self.mas_top).offset(15*KDeviceScale);
        make.bottom.equalTo(self.mas_bottom).offset(-15*KDeviceScale);
    }];
    
    [self.mkInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(38*KDeviceScale);
        make.right.equalTo(self.mas_right).offset(-38*KDeviceScale);
        make.top.equalTo(self.mas_top).offset(27*KDeviceScale);
        
    }];
    
    [self.mkTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(38*KDeviceScale);
        make.bottom.mas_equalTo(-25*KDeviceScale);
    }];
}

#pragma mark - getter
- (UIView *)mkbackgroudView{
    if (!_mkbackgroudView) {
        _mkbackgroudView = [[UIView alloc]init];
        _mkbackgroudView.backgroundColor = MKBakcColor;
        
        _mkbackgroudView.clipsToBounds = YES;
        _mkbackgroudView.layer.cornerRadius = 5.0f;
        
        _mkbackgroudView.layer.shadowColor = [UIColor blackColor].CGColor;
        _mkbackgroudView.layer.shadowOpacity = 0.6f;
        _mkbackgroudView.layer.shadowOffset = CGSizeMake(2.0f,5.0f);
        _mkbackgroudView.layer.shadowRadius = 15.0f;
        _mkbackgroudView.layer.shouldRasterize = YES;
        _mkbackgroudView.layer.masksToBounds = NO;
    }
    return  _mkbackgroudView;
}
 
- (UILabel *)mkInfoLabel{
    if (!_mkInfoLabel) {
        _mkInfoLabel = [[UILabel alloc]init];
        _mkInfoLabel.text = @"若发布违规内容，我们有权对账号作出限制，甚至冻结账号处理。作出限制，甚至冻结账号处理。作出限制，甚至冻结账号处理。作出限制，甚至冻结账号处理。";
        _mkInfoLabel.numberOfLines = 0;
        _mkInfoLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _mkInfoLabel.textColor = [UIColor whiteColor];
        _mkTimeLabel.font = kFontSize(18);
    }
    return _mkInfoLabel;
}

- (UILabel *)mkTimeLabel{
    if (!_mkTimeLabel) {
        _mkTimeLabel = [[UILabel alloc]init];
        _mkTimeLabel.text = @"2020-05-04 20:20:20";
        _mkTimeLabel.textColor = [UIColor whiteColor];
        _mkTimeLabel.font = kFontSize(14);
    }
    return _mkTimeLabel;
}
@end
