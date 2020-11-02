//
//  MKChangeNickNameVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBindingTelVC : BaseVC

@property(nonatomic,assign)BOOL isSave;

@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITextField *verCodeTextFeild;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
