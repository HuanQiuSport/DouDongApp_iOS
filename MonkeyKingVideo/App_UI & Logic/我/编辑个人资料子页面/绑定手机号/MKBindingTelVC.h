//
//  MKChangeNickNameVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBindingTelVC : BaseViewController

@property(nonatomic,assign)BOOL isSave;

@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UITextField *verCodeTextFeild;

@end

NS_ASSUME_NONNULL_END
