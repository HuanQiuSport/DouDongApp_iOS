//
//  MKEditUserInfoCell.m
//  MonkeyKingVideo
//
//  Created by blank blank on 2020/9/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKEditUserInfoCell.h"
#import <YYLabel.h>
#import <YYKit/NSAttributedString+YYText.h>
@implementation MKEditUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = 0;
        [self.contentView addSubview:self.leftLab];
        [self.contentView addSubview:self.rightLab];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.icon];
        [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(17);
            make.height.offset(21);
            make.centerY.offset(0);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.offset(0);
            make.height.offset(1);
        }];
        
        
    }
    return self;
}

- (void)hideIcon:(BOOL)hidden {
    if (hidden) {
        [self.rightLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-18);
            make.height.offset(21);
            make.width.mas_lessThanOrEqualTo(100);
            make.centerY.offset(0);
        }];
        self.icon.hidden = 1;
    } else {
        [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-18);
            make.width.offset(10);
            make.height.offset(14);
            make.centerY.offset(0);
        }];
        [self.rightLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.icon.mas_left).offset(-10);
            make.height.offset(21);
            make.width.mas_lessThanOrEqualTo(100);
            make.centerY.offset(0);
        }];
        self.icon.hidden = 0;
    }
}
- (UILabel *)leftLab {
    if (!_leftLab) {
        _leftLab = UILabel.new;
        _leftLab.textColor = UIColor.blackColor;
        _leftLab.font = [UIFont systemFontOfSize:15];
    }
    return _leftLab;
}
- (UILabel *)rightLab {
    if (!_rightLab) {
        _rightLab = UILabel.new;
        _rightLab.textColor = UIColor.blackColor;
        _rightLab.font = [UIFont systemFontOfSize:15];
        _rightLab.numberOfLines = 0;
        _rightLab.textAlignment = NSTextAlignmentRight;
    }
    return _rightLab;
}
- (UIView *)line {
    if (!_line) {
        _line = UIView.new;
        _line.backgroundColor = RGBA_COLOR(0xA2, 0xA2, 0xA2, 0.2);
    }
    return _line;
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = UIImageView.new;
        _icon.image = KIMG(@"white_未打开");
    }
    return _icon;
}
@end
