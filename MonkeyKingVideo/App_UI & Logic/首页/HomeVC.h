//
//  HomeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "MKNoticeAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeVC : BaseVC
@property (nonatomic,strong) NSMutableArray *m_annoTitles;
@property (nonatomic,strong) NSMutableArray *m_annoContents;
@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong) MKNoticeAlertView *noticeAlertView;
- (void)anno;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
