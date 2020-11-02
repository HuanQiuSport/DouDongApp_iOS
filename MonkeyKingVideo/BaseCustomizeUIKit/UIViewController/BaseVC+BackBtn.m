//
//  BaseVC+BackBtn.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+BackBtn.h"
#import <objc/runtime.h>

@implementation BaseVC (BackBtn)

static char *BaseVC_FSCustomButton_backBtnCategory = "BaseVC_FSCustomButton_backBtnCategory";
static char *BaseVC_FSCustomButton_backBtn = "BaseVC_FSCustomButton_backBtn";

@dynamic backBtnCategory;

#pragma mark —— 子类需要覆写
-(void)backBtnClickEvent:(UIButton *_Nullable)sender{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)FSCustomButton *backBtnCategory;
-(UIButton *)backBtnCategory{
    UIButton *BackBtnCategory = objc_getAssociatedObject(self, BaseVC_FSCustomButton_backBtnCategory);
    if (!BackBtnCategory) {
        BackBtnCategory = UIButton.new;
        [BackBtnCategory layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                         imageTitleSpace:10];
        [BackBtnCategory setTitleColor:kWhiteColor
                              forState:UIControlStateNormal];
        [BackBtnCategory setTitle:@"返回"
                         forState:UIControlStateNormal];
        [BackBtnCategory setImage:KIMG(@"back_white")
                         forState:UIControlStateNormal];
        @weakify(self)
        [[BackBtnCategory rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self backBtnClickEvent:x];
        }];
        objc_setAssociatedObject(self,
                                 BaseVC_FSCustomButton_backBtnCategory,
                                 BackBtnCategory,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackBtnCategory;
}

-(void)setBackBtnCategory:(UIButton *)backBtnCategory{
    objc_setAssociatedObject(self,
                             BaseVC_FSCustomButton_backBtnCategory,
                             backBtnCategory,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)backBtn{
    UIButton *BackBtnCategory = objc_getAssociatedObject(self, BaseVC_FSCustomButton_backBtn);
    if (!BackBtnCategory) {
        BackBtnCategory = UIButton.new;
        BackBtnCategory.frame = CGRectMake(0, 0, 20, 20);
        [BackBtnCategory setBackgroundImage:KIMG(@"back_white")
        forState:UIControlStateNormal];
        
        @weakify(self)
        [[BackBtnCategory rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self backBtnClickEvent:x];
        }];
        
        objc_setAssociatedObject(self,
                                 BaseVC_FSCustomButton_backBtn,
                                 BackBtnCategory,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackBtnCategory;
}

- (void)setBackBtn:(UIButton *)backBtn{
    objc_setAssociatedObject(self,
                             BaseVC_FSCustomButton_backBtn,
                             backBtn,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
