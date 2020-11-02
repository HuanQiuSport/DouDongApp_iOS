//
//  MKSettingCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/26/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSettingCell.h"

@implementation MKSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        self.backgroundColor = RGBCOLOR(30, 36, 50);
        
        [self mkAddSubView];
        
        [self mkLayOutView];
    }
   
    return self;
}

#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self.contentView addSubview:self.mkSettingView];
    
    
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mkSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView);
        
        make.right.equalTo(self.contentView);
        
        make.bottom.equalTo(self.contentView);
        
        make.top.equalTo(self.contentView);
        
    }];
}
#pragma mark - setter
- (MKSetingView *)mkSettingView{
    
    if (!_mkSettingView) {
        
        _mkSettingView = [[MKSetingView alloc]init];
        
        [MKTools mkSetStyleNextImageview:_mkSettingView.mkRightImageView];
        _mkSettingView.mkRightImageView.image = KIMG(@"white_arrow");
    }
    
    return _mkSettingView;
}
@end
