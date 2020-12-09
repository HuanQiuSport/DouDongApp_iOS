
//
//  MKInfoSetingCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoSetingCell.h"

@interface MKInfoSetingCell()

@end
@implementation MKInfoSetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self mkAddSubView];
        
        [self mkLayOutView];
        
    }
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self addSubview:self.mkTitleLable];
    
    [self addSubview:self.mkSwich];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    [self.mkTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15*1);
    }];
    
    [self.mkSwich  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-5*1);
//        make.width.equalTo(@(85*1));
//        make.height.equalTo(@(20*1));
    }];
    
    [self.mkSwich addTarget:self action:@selector(didClickSwitch) forControlEvents:UIControlEventValueChanged];
}
-(void)didClickSwitch{
    
    if (self.mkDelegate && [self.mkDelegate respondsToSelector:@selector(didClickDelegate:WithIndex:)]) {
        [self.mkDelegate didClickDelegate:self WithIndex:self.indexPath];
    }
}

- (UILabel *)mkTitleLable{
    
    if (!_mkTitleLable) {
        _mkTitleLable = [[UILabel alloc]init];
    }
    return _mkTitleLable;
}

- (UISwitch *)mkSwich{
    
    if (!_mkSwich) {
        
        _mkSwich = [[UISwitch alloc]init];
        
        _mkSwich.onTintColor = [UIColor redColor];
        
        _mkSwich.thumbTintColor = [UIColor whiteColor];
        
        _mkSwich.backgroundColor = [UIColor whiteColor];
        
        _mkSwich.layer.cornerRadius = 31/2.0;
        
        _mkSwich.layer.masksToBounds = true;
    }
    return _mkSwich;
}
//- (NSIndexPath *)indexPath{
//
//    if (!_indexPath) {
//
//
//        _indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//    }
//    return _indexPath;
//}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}
@end
