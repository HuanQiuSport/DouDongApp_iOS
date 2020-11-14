//
//  PagingViewTableHeaderView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKPersonView.h"
@interface PagingViewTableHeaderView : UIView
@property (strong,nonatomic) MKPersonView *mkPersonView;
@property (nonatomic, strong) UIImageView *imageView;
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

-(void)refreshSkin;
@end
