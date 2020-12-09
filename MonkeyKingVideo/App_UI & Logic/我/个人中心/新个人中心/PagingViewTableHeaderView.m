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

@property (nonatomic, strong) UIView *bottomLineView;


///

@end

@implementation PagingViewTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:kBlackColor]];
        self.imageView.clipsToBounds = YES;
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.imageView];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        [self mkAddSubView];
        
        [self mkLayOutView];
        [self refreshSkin];
    }
    return self;
}

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        self.imageView.image = [UIImage imageWithColor:UIColor.whiteColor];
    } else {
        self.imageView.image = [UIImage imageWithColor:kBlackColor];
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
    [self addSubview:self.bottomLineView];
    
}

#pragma mark - 布局子视图
-(void)mkLayOutView{
    
    [self.mkPersonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
        
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(@(10));
    }];
    
    
}
- (MKPersonView *)mkPersonView{
    
    if (!_mkPersonView) {
        
        _mkPersonView = [[MKPersonView alloc]init];
      
    }
    return _mkPersonView;
}
-(UIView *)bottomLineView {
    if(_bottomLineView == nil) {
        _bottomLineView = UIView.new;
        _bottomLineView.backgroundColor = HEXCOLOR(0xF7F7F7);
    }
    return  _bottomLineView;
}


@end
