//
//  EditUserInfoVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MKBindingTelVC.h"//修改昵称
#import "MKChangePersonalizedSignatureVC.h"//修改个性签名
#import "MKChangeNameController.h"
#import "MKBindingTelVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditUserInfoVC : BaseViewController

@property(nonatomic,strong)MKChangeNameController *changeNickNameVC;
@property(nonatomic,strong)MKBindingTelVC  *nickName;
@property(nonatomic,strong)MKChangePersonalizedSignatureVC *changePersonalizedSignatureVC;
@property(nonatomic,strong)UITableView * _Nullable tableView;
@property(nonatomic,strong)UIButton *headerBtn;

@property(nonatomic,strong)NSMutableArray *detailTitleMutArr;
@property(nonatomic,strong)MKUserInfoModel *userInfoModel;
@property(nonatomic,strong)NSString *sex;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
