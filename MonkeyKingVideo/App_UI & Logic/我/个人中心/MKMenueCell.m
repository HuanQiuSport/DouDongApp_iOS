//
//  MKMenueCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKMenueCell.h"

@implementation MKMenueCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.mKIMGaeView.alpha = 1;
    }return self;
}

- (MKImageBtnVIew *)mKIMGaeView{
    
    if (!_mKIMGaeView) {
        
        _mKIMGaeView = [[MKImageBtnVIew alloc]init];
        
        
        [self.contentView addSubview:_mKIMGaeView];
        
        [_mKIMGaeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        
    }
    return _mKIMGaeView;
}
@end
