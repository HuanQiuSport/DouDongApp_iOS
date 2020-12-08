//
//  TaskVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
@class MKPaoMaView;
@class MKPMView;
@class MKNoticeView;
NS_ASSUME_NONNULL_BEGIN

@interface TaskVC : BaseViewController
@property (nonatomic, strong) NSString *walletStr;
@property (nonatomic, strong) NSString *coinStr;
@property (nonatomic, strong) NSString *friendStr;


@property (nonatomic, strong) NSMutableArray *m_notices;
@property (nonatomic, strong) NSMutableArray *m_rewards;
@property (nonatomic, strong) NSMutableArray *m_Signs;
@property (nonatomic, strong) NSMutableArray *m_friends;

@property (nonatomic, strong) UILabel *signLab;
@property (nonatomic, strong) UILabel *signTitleLab;
@property (nonatomic, strong) UILabel *walletLab;
@property (nonatomic, strong) UILabel *coinLab;
@property (nonatomic, strong) MKPaoMaView *paomaView;
@property (nonatomic, strong) MKPMView *paomav; // 奖励视图
@property (nonatomic, strong) UILabel *friendLab;
@property (nonatomic, strong) UIButton *signBtn;
@property (nonatomic, strong) UIButton *friendBtn;
@property (nonatomic, strong) UIButton *withdrawBtn;
@property (nonatomic, strong) UIView *friendListView;
@property (nonatomic, strong) UIButton *friendListBtn;
@property (nonatomic, strong) MKNoticeView *noticeView;   // 通知视图

@property (nonatomic, copy) NSString *signDay;
@property (nonatomic, copy) NSString *signCoin;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
