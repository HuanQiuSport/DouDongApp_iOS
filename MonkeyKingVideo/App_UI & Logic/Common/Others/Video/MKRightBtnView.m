//
//  MKRightBtnView.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/5/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKRightBtnView.h"

@interface MKRightBtnView()

@end

@implementation MKRightBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self mkAddSubView];
        [self mkLayOutView];
    }return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    [self addSubview:self.mkZanView];
    [self addSubview:self.mkCommentView];
    [self addSubview:self.mkShareView];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
//    NSMutableArray *array;
//    if (!array) {
//        array = NSMutableArray.array;
//    }
//    [array addObject:self.mkZanView];
//    [array addObject:self.mkCommentView];
//    [array addObject:self.mkShareView];
    
    [self.mkZanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.equalTo(@(54));
        
    }];
    
    [self.mkCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@(54));
        make.top.equalTo(self.mkZanView.mas_bottom).offset(10);
    }];
    
    [self.mkShareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@(70));
        make.top.equalTo(self.mkCommentView.mas_bottom).offset(8);
    }];
    
    
//    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical
//                       withFixedSpacing:10
//                            leadSpacing:0
//                            tailSpacing:0];
//    [array mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self);
//        make.width.equalTo(@(60 * KDeviceScale));
//    }];
}
#pragma mark —— lazyLoad
- (MKImageBtnVIew *)mkZanView{
    if (!_mkZanView) {
        _mkZanView = [[MKImageBtnVIew alloc] initWithFrame:CGRectZero];
        _mkZanView.mkImageView.image = KIMG(@"喜欢-未点击");
        _mkZanView.mkTitleLable.text = @"点赞";
    }return _mkZanView;
}

- (MKImageBtnVIew *)mkCommentView{
    if (!_mkCommentView) {
        _mkCommentView = [[MKImageBtnVIew alloc] initWithFrame:CGRectZero];
        _mkCommentView.mkImageView.image = KIMG(@"信息");
        _mkCommentView.mkTitleLable.text = @"评论";
    }return _mkCommentView;
}

- (MKImageBtnVIew *)mkShareView{
    if (!_mkShareView) {
        _mkShareView  =  [[MKImageBtnVIew alloc] initWithFrame:CGRectZero];
        _mkShareView.mkImageView.image = KIMG(@"分享");
        _mkShareView.mkTitleLable.numberOfLines = 0;
        _mkShareView.mkTitleLable.text = @"分享\n赚钱";
         
    }return _mkShareView;
}

@end
