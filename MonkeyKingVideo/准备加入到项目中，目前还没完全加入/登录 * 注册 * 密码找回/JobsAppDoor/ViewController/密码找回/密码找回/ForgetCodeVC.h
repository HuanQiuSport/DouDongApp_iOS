//
//  ForgetCodeVC.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "ForgetCodeStep_01View.h"
#import "ForgetCodeStep_02View.h"
#import "FindCodeFlowChartView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForgetCodeVC : BaseViewController

@property(nonatomic,strong,nullable)ForgetCodeStep_01View *__block step_01;
@property(nonatomic,strong,nullable)ForgetCodeStep_02View *__block step_02;
@property(nonatomic,strong,nullable)FindCodeFlowChartView *findCodeFlowChartView;
@property(nonatomic,strong)UIButton *successBtn;
@property(nonatomic,strong)UIButton *nextStepBtn;//下一步
@property(nonatomic,assign)int __block Step;
@property(nonatomic,strong)NSString *telStr;
///一共几个流程节点
@property(nonatomic,assign)NSInteger flowNum;
///当前流程序号 从0开始
@property(nonatomic,assign)NSInteger currentFlowSerialNum;

- (void)removeAll;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
