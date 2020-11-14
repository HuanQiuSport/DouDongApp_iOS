//
//  PagingViewTableHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewTableHeaderView.h"
@interface PagingViewTableHeaderView()

@property (nonatomic, assign) CGRect imageViewFrame;
///

@end

@implementation PagingViewTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:MKBakcColor]];
        self.imageView.clipsToBounds = YES;
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self mkAddSubView];
        
        [self mkLayOutView];
    }
    return self;
}

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        self.imageView.image = [UIImage imageWithColor:UIColor.whiteColor];
    } else {
        self.imageView.image = [UIImage imageWithColor:MKBakcColor];
    }
    [self.mkPersonView refreshSkin];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageViewFrame = self.bounds;
}

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    
    CGRect frame = self.imageViewFrame;

    frame.size.height -= contentOffsetY;
    frame.origin.y = contentOffsetY;
    self.imageView.frame = frame;
   
    
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self addSubview:self.mkPersonView];
}

#pragma mark - 布局子视图
-(void)mkLayOutView{
    
    [self.mkPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
        
    }];
}
- (MKPersonView *)mkPersonView{
    
    if (!_mkPersonView) {
        
        _mkPersonView = [[MKPersonView alloc]init];
      
    }
    return _mkPersonView;
}
@end
