//
//  HomeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeVC : BaseViewController
@property (nonatomic,strong) NSMutableArray *m_annoTitles;
@property (nonatomic,strong) NSMutableArray *m_annoContents;
@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
- (void)anno;

@end

NS_ASSUME_NONNULL_END
