//
//  BaseVC+SPAlertController.h
//  Shooting
//
//  Created by Jobs on 2020/9/11.
//  Copyright © 2020 Jobs. All rights reserved.
//

#warning 具体使用，详见demo https://github.com/SPStore/SPAlertController

#import "BaseVC.h"

typedef enum : NSUInteger {
    BaseVC_SPAlertControllerInitType_1 = 0,//alertControllerWithTitle/message/preferredStyle
    BaseVC_SPAlertControllerInitType_2,//alertControllerWithTitle/message/preferredStyle/animationType
    BaseVC_SPAlertControllerInitType_3,//alertControllerWithCustomAlertView/preferredStyle/animationType
    BaseVC_SPAlertControllerInitType_4,//alertControllerWithCustomHeaderView/preferredStyle/animationType
    BaseVC_SPAlertControllerInitType_5,//alertControllerWithCustomActionSequenceView/title/message/preferredStyle/animationType
    BaseVC_SPAlertControllerInitType_6,//alertControllerWithTitle/message/preferredStyle/animationType
} BaseVC_SPAlertControllerInitType;

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC (SPAlertController)

- (SPAlertController *)SPAlertControllerWithType:(BaseVC_SPAlertControllerInitType)SPAlertControllerInitType
                                           title:(NSString *_Nullable)title
                                         message:(NSString *_Nullable)message
                                 customAlertView:(UIView *_Nullable)customAlertView
                                customHeaderView:(UIView *_Nullable)customHeaderView
                        customActionSequenceView:(UIView *_Nullable)customActionSequenceView
                                  preferredStyle:(SPAlertControllerStyle)preferredStyle
                                   animationType:(SPAlertAnimationType)animationType
                             alertActionTitleArr:(NSArray <NSString *> *)alertActionTitleArr
                             alertActionStyleArr:(NSArray <NSNumber *> *)alertActionStyleArr//SPAlertActionStyle
                                  alertBtnAction:(NSArray <NSString *> *)alertBtnActionArr
                                    alertVCBlock:(TwoDataBlock)alertVCBlock;

@end

NS_ASSUME_NONNULL_END
