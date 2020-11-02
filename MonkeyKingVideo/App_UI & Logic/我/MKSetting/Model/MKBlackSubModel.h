//
//  MKBlackSubModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MKBlackSubModel <NSObject>
@end

@interface MKBlackSubModel : JSONModel
///
@property (strong,nonatomic) NSString <Optional>*id;
@property (strong,nonatomic) NSString <Optional>*userId;
@property (strong,nonatomic) NSString <Optional>*blackId;
@property (strong,nonatomic) NSString <Optional>*account;
@property (strong,nonatomic) NSString <Optional>*headImage;
@property (strong,nonatomic) NSString <Optional>*remark;
@property (strong,nonatomic) NSString <Optional>*fansNum;
@property (strong,nonatomic) NSString <Optional>*nickName;


@end

NS_ASSUME_NONNULL_END
