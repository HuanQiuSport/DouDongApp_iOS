//
//  MKChangePersonalizedSignatureVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKChangePersonalizedSignatureVC : BaseViewController

@property(nonatomic,assign)BOOL isSave;


-(void)actionChangePersonalizedSignatureBlock:(MKDataBlock)changePersonalizedSignatureBlock;

@end

NS_ASSUME_NONNULL_END
