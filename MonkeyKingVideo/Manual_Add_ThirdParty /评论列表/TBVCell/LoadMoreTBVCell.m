//
//  LoadMoreTBVCell.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "NSString+Extras.h"
#import "LoadMoreTBVCell.h"

@interface LoadMoreTBVCell ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic, strong)UIImageView *arrowIcon;
@end

@implementation LoadMoreTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    LoadMoreTBVCell *cell = (LoadMoreTBVCell *)[tableView dequeueReusableCellWithIdentifier:@"LoadMoreTBVCell"];
    if (!cell) {
        cell = [[LoadMoreTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"LoadMoreTBVCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 18 + 16;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    self.titleLab.text = @"展开更多回复";
    self.arrowIcon.image = KIMG(@"arrow_down");
}
- (void)setData {
    self.titleLab.text = @"收起回复";
    self.arrowIcon.image = KIMG(@"arrow_up");
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.textColor = HEXCOLOR(0x999999);
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.height.offset(18);
            make.left.offset(SCALING_RATIO(94));
            make.width.mas_lessThanOrEqualTo(80);
        }];
    }return _titleLab;
}
- (UIImageView *)arrowIcon {
    if (!_arrowIcon) {
        _arrowIcon = UIImageView.new;
        _arrowIcon.image = KIMG(@"arrow_down");
        [self.contentView addSubview:_arrowIcon];
        [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_titleLab.mas_right).offset(6);
            make.width.offset(12);
            make.height.offset(6);
            make.centerY.mas_equalTo(self->_titleLab.mas_centerY).offset(0);
        }];
    }
    return _arrowIcon;
}
@end
