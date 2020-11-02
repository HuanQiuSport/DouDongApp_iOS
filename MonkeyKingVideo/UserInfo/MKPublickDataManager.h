//
//  MKPublickDataManager.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKLoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKPublickDataManager : NSObject{
    @public
    NSString *asclassname;
}
///

@property(nonatomic, assign)BOOL      isLogin;    //YES.登录中，NO未登录

/// 用户信息
@property (strong,nonatomic) MKLoginModel *mkLoginModel;
/// 当前视频信息
@property (strong,nonatomic) NSMutableString *currentVideoString;
/// 当前视频用户信息
@property (strong,nonatomic) NSMutableString *currentVideoUserString;


/// 是否显示去商店评论
@property (assign,nonatomic) BOOL isShowComment;
#pragma mark - 单例
+ (MKPublickDataManager *) sharedPublicDataManage;
@end

NS_ASSUME_NONNULL_END
