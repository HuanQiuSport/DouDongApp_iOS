//
//  RecommendVC+Comment.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#define CommentHeight SCREEN_HEIGHT * 508 / (508 + 159)
#import "RecommendVC+Private.h"
#import "RecommendVC+Comment.h"

@implementation RecommendVC (Comment)
- (void)keyboard {
    [IQKeyboardManager sharedManager].enable = 0;
}
-(void)willOpen{
    @weakify(self)
    self.commentPopUpVC.view.alpha = 1;
    if (self.isRecommend) {
        [self.homeVC.view addSubview:self.commentCoverView];
    } else {
        [self.view addSubview:self.commentCoverView];
    }
    [UIView animateWithDuration:0.3f
                     animations:^{
        @strongify(self)
        self.commentPopUpVC.view.mj_y = SCREEN_HEIGHT - CommentHeight;
    } completion:^(BOOL finished) {
        @strongify(self)
        //不知为何，这个地方的约束会出现问题，所以在这里写上一句，锁定约束
        self.commentPopUpVC.view.mj_y = SCREEN_HEIGHT - CommentHeight;
        self.isCommentPopUpVCOpen = !self.isCommentPopUpVCOpen;
        self.CommentPopUpVC_Y = self.commentPopUpVC.view.mj_y;
        [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
        self.commentCoverView.alpha = 0.2;
        
    }];
}
- (void)willClose_vertical{
    @weakify(self)
    if (self.commentPopUpVC) {
//        self.mkPlayerScrollView.mkPlayUserInfoView.mkRightBtuttonView.mkCommentView.mkTitleLable.text = self.commentPopUpVC.commentNumStr;
        self.commentCoverView.alpha = 0;
        [self.commentCoverView removeFromSuperview];
    [UIView animateWithDuration:0.3f
                     animations:^{
        @strongify(self)
        [self.commentPopUpVC.field endEditing:1];
        self.commentPopUpVC.view.mj_y = SCREEN_HEIGHT;
       

    } completion:^(BOOL finished) {
        @strongify(self)
        [self.commentPopUpVC.view endEditing:YES];
        //不知为何，这个地方的约束会出现问题，所以在这里写上一句，锁定约束
        self.commentPopUpVC.view.mj_y = SCREEN_HEIGHT;
        //vc的view减1 这里面避免用self.属性，因为害怕走属性懒加载
        [self.commentPopUpVC.view removeFromSuperview];
        //vc为0
        [self.commentPopUpVC removeFromParentViewController];
        self.commentPopUpVC = nil;
        self.isCommentPopUpVCOpen = !self.isCommentPopUpVCOpen;
         [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
        
    }];
    }
}
- (void)GiveUpComment {
    [self.view endEditing:YES];
    [self willClose_vertical];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}
- (void)Sorry{
    self.commentPopUpVC.view.mj_y = self.CommentPopUpVC_EditY;//102;
}

@end
