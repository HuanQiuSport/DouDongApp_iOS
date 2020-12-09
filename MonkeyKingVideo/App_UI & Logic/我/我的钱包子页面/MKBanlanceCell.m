//
//  MKBanlanceCell.m
//  MonkeyKingVideo
//
//  Created by blank blank on 2020/9/7.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBanlanceCell.h"
@interface MKBanlanceCell()
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *money;
@end
@implementation MKBanlanceCell

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.clearColor;
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.content];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.money];
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(14);
            make.top.offset(0);
            make.height.offset(18);
        }];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(14);
            make.height.offset(10);
            make.top.mas_equalTo(self.content.mas_bottom).offset(0);
        }];
        [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-14);
            make.height.offset(18);
            make.top.offset(4);
        }];
    }
    return self;
}

- (void)setModel:(MKWalletMyFlowsListModel *)model {
    self.content.text = model.moneyType;
    if([model.moneyType isEqual:@"余额提现"]) {
        self.content.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(60, 30)]];
    } else {
        self.content.textColor = UIColor.blackColor;
    }
    self.time.text = model.createTime;
    self.money.text = model.amount;
    if ([model.inOutType  isEqual: @(0)] || [model.amount isEqualToString:@"已打款"] || [model.amount isEqualToString:@"审批中"]) {
        self.money.textColor = HEXCOLOR(0x79BB24);
    } else {
        self.money.textColor = kRedColor;
    }
}

- (UILabel *)content {
    if (!_content) {
        _content = UILabel.new;
        _content.textColor = UIColor.whiteColor;
        _content.font = [UIFont systemFontOfSize:12.8];
    }
    return _content;
}
- (UILabel *)time {
    if (!_time) {
        _time = UILabel.new;
        _time.textColor = COLOR_HEX(0x8E8E92, 1);
        _time.font = [UIFont systemFontOfSize:8];
    }
    return _time;
}

- (UILabel *)money {
    if (!_money) {
        _money = UILabel.new;
        _money.textAlignment = NSTextAlignmentRight;
        _money.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12.8];
    }
    return _money;
}
@end
