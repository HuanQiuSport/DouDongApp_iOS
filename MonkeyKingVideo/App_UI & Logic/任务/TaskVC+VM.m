//
//  TaskVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TaskVC+VM.h"
#import "MKPaoMaView.h" // 跑马灯
#import "MKPMView.h" // 跑马灯
#import "MKWebViewVC.h"

#import "MKTaskPopView.h"
#import "WPAlertControl.h"
#import "WPView.h"
#import "MKNoticeView.h"
@implementation TaskVC (VM)

-(void)getData{
    // 未登录状态下只获取通知和签到信息
    [self MKuserInfoRollDate_GET];
    [self MKUserInfoSignList_GET];
    
}

#pragma mark - MKuserInfoRollDateGET 获取通知数据
-(void)MKuserInfoRollDate_GET{

    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKuserInfoRollDateGET
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            [self.m_notices removeAllObjects];
            NSMutableArray *m_arrs = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in response.reqResult) {
                NSString *str = dic[@"friendName"];
                NSString *str2 = [MKTools replaceStringWithAsterisk:str startLocation:1 lenght:str.length-2];
                NSString *str3 = [NSString stringWithFormat:@"%@",dic[@"winMoney"]];
                NSString *str4 = [NSString stringWithFormat:@"%@",dic[@"gameName"]];
                [self.m_notices addObject:[NSString stringWithFormat:@"    %@邀请了%@个好友, 获得了%@万抖币",str2,dic[@"friendCount"],dic[@"sumInCome"]]];
                
                
                NSString *text = [NSString stringWithFormat:@"恭喜 “%@”在“%@”中中了%@元",str2,dic[@"gameName"],dic[@"winMoney"]];
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];

                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(100, 30)]] range:NSMakeRange(3, str2.length+2)];
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(100, 30)]] range:NSMakeRange(11+str.length+str4.length, str3.length)];
                [m_arrs addObject:attributedString];
//                [self.m_rewards addObject:attributedString];
                
            }
//            NSLog(@"%@",self.m_notices);
//            self.paomaView.marqueeContentArray = self.m_notices;
            if (self.m_rewards.count == 0) {
                self.m_rewards = m_arrs;
                self.paomav.marqueeTitleArray = self.m_rewards;
                self.paomav.marqueeContentArray = self.m_rewards;
                [self.paomav start];
            }
            self.noticeView.dataSource = self.m_notices;
//            self.paomaView.text = [self.m_notices componentsJoinedByString:@"  "];
            
        } else {
             
             [WHToast showMessage:response.message
                         duration:1
                    finishHandler:nil];
        }
    }];
}
#pragma mark - APP钱包相关接口 —— POST 获取用户信息 获取余额和抖币数据
- (void)getDataUserData{
    NSDictionary *easyDict = @{
        @"userId":[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKUserInfoGET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    WeakSelf
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {

            if ([response.reqResult isKindOfClass:NSDictionary.class]){
                weakSelf.coinStr = response.reqResult[@"goldNumber"];
                weakSelf.walletStr = response.reqResult[@"balance"];
                if ([weakSelf.walletStr isEqualToString:@"0.00"]) {
                    weakSelf.walletStr = @"0";
                }
                if ([weakSelf.coinStr isEqualToString:@"0"]) {
                }
                weakSelf.walletLab.text = weakSelf.walletStr;
                weakSelf.coinLab.text = weakSelf.coinStr;

            }
            else
            {

                
                [WHToast showMessage:response.reqResult
                            duration:1
                       finishHandler:nil];
            }
            
        }else{

            [WHToast showMessage:@"没有哦oooo～"
                        duration:1
                   finishHandler:nil];
        }
    }];
}
#pragma mark - 签到列表
-(void)MKUserInfoSignList_GET{

    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKUserInfoSignListGET
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSDictionary.class])
            {
                NSString *coinNumb;
                // 1.是否登录都显示
                NSArray *datas = response.reqResult[@"data"];
                for (int i =0; i<7; i++) {
                    
                    NSDictionary *dic = datas[i];
                    UIImageView *imgeV = (UIImageView *)[self.view viewWithTag:200+i];
                    UILabel *lab = (UILabel *)[self.view viewWithTag:100+i];
                    lab.text = [NSString stringWithFormat:@"%@",dic[@"goldNum"]];
                    if (i==0) {
                        // 用于未登录只显示第一天可以获得的金币
                        coinNumb = [NSString stringWithFormat:@"%@",dic[@"goldNum"]];
                    }
                    NSString *op = [NSString stringWithFormat:@"%@",dic[@"isSign"]];
                    if ([op isEqualToString:@"0"]) {
//                        NSLog(@"%ld",weak_self.signDay.length);
                        // 这里签到有问题
                        if ([MKTools isBlankString:weak_self.signDay]) {
                            self.signDay = [NSString stringWithFormat:@"%@",dic[@"days"]];
                        }
                        imgeV.image = KIMG(@"icon_redpackage_nor");
                        lab.textColor = kBlackColor;
                    } else {
                        imgeV.image = KIMG(@"icon_redpackage_sel");
                        lab.textColor = kWhiteColor;
                    }

                }
                // 签到能获得的金币
                self.signCoin = [NSString stringWithFormat:@"%@",response.reqResult[@"nowGoldNum"]];
                self.signLab.text = [NSString stringWithFormat:@"%@抖币",response.reqResult[@"nowGoldNum"]];
                // 1.先判断是否登录
                if ([MKTools mkLoginIsYESWith:weak_self WithiSNeedLogin:NO]){
                    // 2.登录之后判断是否已经签到了
                    // 登录显示
//                    self.signLab.text = [NSString stringWithFormat:@"%@抖币",response.reqResult[@"nowGoldNum"]];
                    // isSign 是否已经签到过 nowGoldNum签到可以获得的抖币
                     NSString *isSign = [NSString stringWithFormat:@"%@",response.reqResult[@"isSign"]];
                    if ([isSign isEqualToString:@"1"]) {
                        // 3.已签到显示
                        [self.signBtn setTitle:@"继续赚抖币" forState:UIControlStateNormal];
                        self.signTitleLab.text = @"今日签到已获得";
                        // 5.已签到跳邀请好友
                        [self.signBtn addAction:^(UIButton *btn) {
                            MKWebViewVC *vc  = MKWebViewVC.new;
                            vc.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
                            [weak_self.navigationController pushViewController:vc animated:YES];
                        }];
                        
                    }
                    else
                    {
                        // 3.未签到显示
//                        self.signLab.text = [NSString stringWithFormat:@"%@抖币",self.signCoin];
                        [self.signBtn setTitle:@"立即签到" forState:UIControlStateNormal];
                        self.signTitleLab.text = @"今日签到可获得";
                        // 5.未签到调用签到接口
                        [self.signBtn addAction:^(UIButton *btn) {
                            [weak_self MKUserInfoDoSign_POST];
                        }];
                        
                    }
                }
                else
                {
                    // 1.未登录显示
                    self.signLab.text = [NSString stringWithFormat:@"%@抖币",coinNumb];
                    [self.signBtn setTitle:@"立即签到" forState:UIControlStateNormal];
                    self.signTitleLab.text = @"今日签到可获得";
                    // 2.未跳登录
                    [self.signBtn addAction:^(UIButton *btn) {
                        if ([MKTools mkLoginIsYESWith:weak_self]){return;}
                    }];
                    
                }
                
            }
            else
            {
                // 判断是否有数据

                  [WHToast showMessage:response.reqResult
                              duration:1
                         finishHandler:nil];
            }
        }
        else
        {
            // 判断是否请求成功
             
             [WHToast showMessage:response.message
                         duration:1
                    finishHandler:nil];
        }
    }];
}
#pragma mark - 签到 MKUserInfoDoSignPOST
-(void)MKUserInfoDoSign_POST{
    NSDictionary *easyDict = @{
        @"day":self.signDay
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKUserInfoDoSignPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            [self mkLoginAlert:nil];
        } else {

            [WHToast showMessage:response.reqResult
                                               duration:1
                                          finishHandler:nil];
        }
    }];
}
#pragma mark - 银行卡 MKUserInfoSelectIdCardGET
//-(void)MKUserInfoSelectIdCard_GET{
-(void)friendAndCard{

// 银行卡绑定功能移除
    [self MKUserFriendFourList_GET];
//    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
//                                                           path:[URL_Manager sharedInstance].MKUserInfoSelectIdCardGET
//                                                     parameters:@{}];
//    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
//    @weakify(self)
//    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//        if (response.code == 402 || response.code == 401) {
//            return;
//        }
//        else
//        {
//            [self MKUserFriendFourList_GET];
//        }
//        if (response.isSuccess) {
//            if ([response.reqResult isKindOfClass:NSDictionary.class])
//            {
//                if (![MKTools mkDictionaryEmpty:response.reqResult]) {
////                    NSLog(@"绑定卡");
//                   [weak_self.withdrawBtn  setTitle:@"已绑定" forState:UIControlStateNormal];
//                }
//            }
//            else
//            {
////                 NSLog(@"没有绑定卡");
//                 [weak_self.withdrawBtn  setTitle:@"去绑定" forState:UIControlStateNormal];
//
//            }
//            [weak_self.withdrawBtn addAction:^(UIButton *btn) {
//                MKWebViewVC *vc  = MKWebViewVC.new;
//                vc.webblock = ^(NSDictionary * _Nonnull dic) {
//                    if ([[NSString stringWithFormat:@"%@",dic[@"status"]] isEqualToString:@"0"]) {
////                        [weak_self mkLoginAlert:[NSString stringWithFormat:@"%@",dic[@"getCoin"]]];
//                        MKTaskPopView * alertV = [[MKTaskPopView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT) WithParameter:[NSString stringWithFormat:@"%@",dic[@"getCoin"]]];
//                        alertV.popblock = ^{
//                            MKWebViewVC *vc  = MKWebViewVC.new;
//                            vc.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
//
//                            [weak_self.navigationController pushViewController:vc
//                                                                 animated:YES];
//                        };
//                        [weak_self.view addSubview:alertV];
//                    }
//                };
//
//                vc.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5bandalipay,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
//
//                [weak_self.navigationController pushViewController:vc
//                                                     animated:YES];
//
//            }];
//        }
//        else {
//            [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
//                                                          text:response.message
//            dissmissAfterDeley:1.2];
//        }
//    }];
}
#pragma mark - 好友MKUserFriendFourListGET
-(void)MKUserFriendFourList_GET{

    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKUserFriendFourListGET
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            
            if ([response.reqResult isKindOfClass:NSDictionary.class])
            {
//                if ([MKTools mkDictionaryEmpty:response.reqResult]) {
//                    self.friendStr = response.reqResult[@"award"];
//                }
                if ([MKTools mkArrayEmpty:response.reqResult[@"list"]]) {
//
                    weak_self.friendLab.text = @"你还未邀请好友哦～";
                    weak_self.friendListView.hidden = YES;
                    weak_self.friendBtn.hidden = !weak_self.friendListView.hidden;
                    UIView *line = (UIView *)[self.view viewWithTag:999];
                    line.hidden = !weak_self.friendListView.hidden;
                    weak_self.friendListBtn.hidden = weak_self.friendListView.hidden;
                    [weak_self.friendBtn setTitle:@"立即邀请" forState:UIControlStateNormal];
                    [weak_self.friendBtn addAction:^(UIButton *btn) {
                        MKWebViewVC *vc  = MKWebViewVC.new;
                        vc.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
                        
                        [weak_self.navigationController pushViewController:vc
                                                             animated:YES];
                    }];
                    

                }
                else
                {
                    weak_self.friendListView.hidden = NO;
                    [weak_self.friendListView removeAllSubviews];
                    weak_self.friendBtn.hidden = !weak_self.friendListView.hidden;
                    UIView *line = (UIView *)[self.view viewWithTag:999];
                    line.hidden = !weak_self.friendListView.hidden;
                    weak_self.friendListBtn.hidden = weak_self.friendListView.hidden;
                    [weak_self.friendListBtn addAction:^(UIButton *btn) {
                        MKWebViewVC *vc  = MKWebViewVC.new;
                        vc.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];

                        [weak_self.navigationController pushViewController:vc
                                                             animated:YES];
                    }];
//                    [self.m_friends removeAllObjects];
//                    for (NSDictionary *dic in response.reqResult[@"list"]) {
//                        [self.m_friends addObject:dic];
//                    }
                    NSArray *datas = response.reqResult[@"list"];
                    @strongify(self)
                    for (int i = 0; i<datas.count; i++) {
                        NSDictionary *dic = datas[i];
                        // default_avatar_white.jpg
                        UIImageView *userImgeV = UIImageView.new;
                        [userImgeV sd_setImageWithURL:[NSURL URLWithString:dic[@"headImage"]]];
                        [weak_self.friendListView addSubview:userImgeV];
                        [userImgeV mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.top.equalTo(bgV).offset(0);
                            make.left.equalTo(self.friendListView).offset(i*(61*1)+16);
                            make.bottom.equalTo(self.friendListView.mas_bottom).offset(-17*1);
                            make.width.offset(50*1);
                            make.height.offset(50*1);
//                            make.right.equalTo(bgV).offset(0);
                        }];
                        userImgeV.layer.cornerRadius = 25*1;
                        userImgeV.layer.masksToBounds = YES;
                        [self MKUserFriendMyInCome_GET];
                    }
                    
                }
            }
        }
    }];
}
#pragma mark - 统计我的收益
-(void)MKUserFriendMyInCome_GET{

    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKUserFriendMyInComeGET
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSString *str = response.reqResult[@"award"];
            NSString *str2 = [NSString stringWithFormat:@"好友已帮您赚了 %.0f抖币",[str floatValue]];
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str2];

            NSRange rang = NSMakeRange(7, str2.length-7);

            [text addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(255,202,0) range:rang];

            [weak_self.friendLab setAttributedText:text];
        }
        else {
            [WHToast showMessage:response.message
                                               duration:1
                                          finishHandler:nil];
        }
    }];
}
#pragma mark - 弹窗
- (void)mkLoginAlert:(NSString *)coinNumb{
    if (coinNumb.length <= 0) {
        coinNumb = self.signCoin;
    }
    [self MKUserInfoSignList_GET];
    [self getDataUserData];
    @weakify(self)
    WPView *view1 = [WPView viewWithTapClick:^(id other) {
        @strongify(self)
        // 启动弹窗
    }];

    view1.tap = ^(id other) {
        [WPAlertControl alertHiddenForRootControl:self completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
            switch (status) {
                case WPAnimateWillAppear:
                    break;
                case WPAnimateDidAppear:
                    break;
                case WPAnimateWillDisappear:
                    break;
                case WPAnimateDidDisappear:
                    break;
            }
        }];
       
    };
    view1.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH,MAINSCREEN_HEIGHT);
    view1.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(MAINSCREEN_WIDTH/2 - (336*1)/2, 57, 336*1,  329*1)];
    image.image = KIMG(@"icon_task_baoxiang");
    [view1 addSubview:image];
    

    
    
    NSString *text = [NSString stringWithFormat:@"%@抖币",coinNumb];

    NSInteger fontSize1 = 42; // 金币数量
    NSInteger fontSize2 = 18; // 标题
    CGFloat fontRatio = 0.3;//基线偏移比率

    UILabel *label = UILabel.new;
    label.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(image.mas_bottom).offset(-(21*1));
        make.left.equalTo(view1).offset(0);
        make.right.equalTo(view1).offset(0);
    }];
    label.text = text;

    NSMutableAttributedString *attributedStringM = [[NSMutableAttributedString alloc] initWithString:text];

    [attributedStringM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize2] range:NSMakeRange(text.length - 2, 2)];
    [attributedStringM addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 2, 2)];

    [attributedStringM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize1] range:NSMakeRange(0, text.length - 2)];
    [attributedStringM addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(255,235,189) range:NSMakeRange(0, text.length - 2)];

//    [attributedStringM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize2] range:NSMakeRange(text.length - 3, 3)];
//    [attributedStringM addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 3, 3)];

    //不同大小的文字水平中部对齐(默认是底部对齐)
    [attributedStringM addAttribute:NSBaselineOffsetAttributeName value:@(fontRatio * (fontSize1 - fontSize2)) range:NSMakeRange(text.length - 2, 2)];

    label.attributedText = attributedStringM;

    UILabel *lab = UILabel.new;
    [view1 addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label.mas_top).offset(8);
        make.left.equalTo(view1).offset(0);
        make.right.equalTo(view1).offset(0);
    }];
    lab.text = @"恭喜您获得";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:26];
    lab.textColor = RGBCOLOR(255,235,189);
    
    
    // 宝箱
    UIButton *btn = UIButton.new;
    [view1 addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_bottom).offset(12);
        make.left.equalTo(view1).offset(57);
        make.right.equalTo(view1).offset(-57);
        make.height.offset(42);
    }];
    btn.backgroundColor = RGBCOLOR(255,125,0);
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"邀请好友狂赚37.6w抖币" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 21;
    btn.layer.masksToBounds = 1;
    WeakSelf
    [btn addAction:^(UIButton *btn) {
        [WPAlertControl alertHiddenForRootControl:weakSelf completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
             
        }];
        MKWebViewVC *vc  = MKWebViewVC.new;
        vc.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];

        [weakSelf.navigationController pushViewController:vc
                                             animated:YES];
    }];
    
    // 关闭
    UIButton *closebtn = UIButton.new;
    [view1 addSubview:closebtn];
    [closebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_top).offset(100);
        make.right.equalTo(view1).offset(-57);
        make.height.offset(36);
        make.width.offset(36);
    }];
    [closebtn setImage:KIMG(@"登录注册关闭@3x") forState:UIControlStateNormal];
    [closebtn addAction:^(UIButton *btn) {
        [WPAlertControl alertHiddenForRootControl:weakSelf completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
                    
               }];
    }];
        
    if ([[[SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers lastObject] isKindOfClass:JobsAppDoorVC_Style1.class]) {
//        NSLog(@"你他妹的手那么快干啥子呦");
        return;
    }
    [WPAlertControl alertForView:view1
                           begin:WPAlertBeginCenter
                             end:WPAlertEndCenter
                     animateType:WPAlertAnimateBounce
                        constant:0
            animageBeginInterval:0.3
              animageEndInterval:0.1
                       maskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
                             pan:YES
                     rootControl:self
                       maskClick:^BOOL(NSInteger index, NSUInteger alertLevel, WPAlertControl *alertControl) {
        @strongify(self)
        return NO;
    }
                   animateStatus:nil];
}

@end
