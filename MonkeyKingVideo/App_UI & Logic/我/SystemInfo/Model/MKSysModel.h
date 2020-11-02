//
//  MKSysModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MKSysModel  <NSObject>
@end
@interface MKSysModel : JSONModel
///
@property (strong,nonatomic) NSString<Optional> *id;
/// 类型
@property (strong,nonatomic) NSString<Optional> *type;
/// 开关状态
@property (strong,nonatomic) NSString<Optional> *status;

@property (strong,nonatomic) NSString<Optional> *userId;
/// 消息标题
@property (strong,nonatomic) NSString<Optional> *title;
/// 消息文本
@property (strong,nonatomic) NSString<Optional> *context;
/// 消息图标
@property (strong,nonatomic) NSString<Optional> *messageIcon;

@property (strong,nonatomic) NSString<Optional> *createTime;

@property (strong,nonatomic) NSString<Optional> *headImage;

@property (strong,nonatomic) NSString<Optional> *nickName;

@property (strong,nonatomic) NSString<Optional> *remark;

@property (strong,nonatomic) NSString<Optional> *infoNumber;

///视频名称
@property (strong,nonatomic) NSString<Optional> *videoName;

///系统消息cell高度
@property (strong,nonatomic) NSString<Optional> *height;
@end

NS_ASSUME_NONNULL_END
