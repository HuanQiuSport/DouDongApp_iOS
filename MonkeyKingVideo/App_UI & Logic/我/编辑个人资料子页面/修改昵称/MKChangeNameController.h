//
//  MKChangeNameController.h
//  MonkeyKingVideo
//
//  Created by Mose on 2020/9/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKChangeNameController : BaseViewController

@property(nonatomic,assign)BOOL isSave;

-(void)actionChangeNickNameBlock:(MKDataBlock)changeNickNameBlock;

@end

NS_ASSUME_NONNULL_END
