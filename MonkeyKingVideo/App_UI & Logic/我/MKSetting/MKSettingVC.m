//
//  MKSettingVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/26/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSettingVC.h"
//#import "MKSettingCell.h"
#import "MKSettingCell.h"
#import "MKAppVersionView.h"
#import "MKBlackListVC.h"
#import "MKWebViewVC.h"
#import "MKSettingVC+VM.h"
#import "MKCacheTool.h"
#import "MKRevisePasswordViewController.h"
@interface MKSettingVC ()
<
UITableViewDelegate
,UITableViewDataSource
>
/// tableView
@property(strong,nonatomic)UITableView *mkTableview;
/// 版本信息
@property(strong,nonatomic)MKAppVersionView *mkVersionView;
@property(strong,nonatomic)UILabel *cacheLab;
@end

@implementation MKSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = MKBakcColor;
    self.gk_navTitle = @"设置";
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    [self mkAddSubView];
    [self mkLayOutView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)logOff{
    @weakify(self)
    [self requestLogoutWithData:^(id data) {
        @strongify(self)
        if ((Boolean)data) {
            [self clearAllUserDefaultsData];
            [MKTools shared]._isReloadRequest = YES;
            [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
                                                          text:@"退出登录成功，已处于未登录状态"
                                            dissmissAfterDeley:1.2];
            [[MKLoginModel getUsingLKDBHelper] deleteToDB:[MKPublickDataManager sharedPublicDataManage].mkLoginModel];
            [[MKTools shared] cleanCacheAndCookie];
            [MKPublickDataManager sharedPublicDataManage].mkLoginModel.token = @"";
            [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 4;
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:KLoginOutNotifaction object:nil]];
        }else{
            [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
                                                          text:@"退出登录失败，稍后再试"
                                            dissmissAfterDeley:1.2];
        }
    }];

}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    [self.view addSubview:self.mkTableview];
    
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    [self.mkTableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view);
        make.top.equalTo(self.gk_navigationBar.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(KDeviceScale * 50 * 3));
    }];
    

    UIView *botV = UIView.new;
    [self.view addSubview:botV];
    [botV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.offset(0);
        make.top.mas_equalTo(self.mkTableview.mas_bottom).offset(0);
    }];
    botV.backgroundColor = RGBCOLOR(30, 36, 50);
    
    [botV addSubview:self.mkVersionView];
    [self.mkVersionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.equalTo(@(KDeviceScale * 50));
     }];
    [self.mkVersionView getVersionInfo];
}

#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 * KDeviceScale;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MKSetAll";
    MKSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MKSettingCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.mkSettingView.mkLeftLabel.text = @"清理缓存";
            self.cacheLab = cell.mkSettingView.mkRightLabel;
            cell.mkSettingView.mkRightImageView.hidden = YES;
            cell.mkSettingView.mkRightLabel.text = [NSString stringWithFormat:@"%.2fM",[MKCacheTool cacheSize]];
            cell.mkSettingView.mkLeftImageView.image = KIMG(@"清理缓存");
            break;
        case 1:
            cell.mkSettingView.mkLeftLabel.text = @"修改密码";
            cell.mkSettingView.mkRightImageView.hidden = NO;
            cell.mkSettingView.mkRightLabel.hidden = YES;
            cell.mkSettingView.mkLeftImageView.image = KIMG(@"修改密码");
            break;
        case 2:
            cell.mkSettingView.mkLeftLabel.text = @"退出登录";
            cell.mkSettingView.mkRightImageView.hidden = YES;
            cell.mkSettingView.mkRightLabel.hidden = YES;
            cell.mkSettingView.mkLeftImageView.image = KIMG(@"退出登录");
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [NSObject showSYSAlertViewTitle:@"温馨提示:"
                                    message:@"确认清理缓存"
                            isSeparateStyle:NO
                                btnTitleArr:@[@"确认",@"手滑啦"]
                             alertBtnAction:@[@"clearCache",@""]
                                    targetVC:self
                               alertVCBlock:^(id data) {
                
            }];
        }break;
        case 1:{
            
            [self.navigationController pushViewController:MKRevisePasswordViewController.new animated:YES];
        }break;
        case 3:{
            [self.navigationController pushViewController:MKBlackListVC.new
                                                 animated:YES];
            
        }break;
        case 2:{
            [NSObject showSYSAlertViewTitle:@"确定要退出吗？"
                                    message:@""
                            isSeparateStyle:NO
                                btnTitleArr:@[@"取消",@"确定"]
                             alertBtnAction:@[@"",@"logOff"]
                                   targetVC:self
                               alertVCBlock:^(id data) {
                //DIY
                
            }];
        }
        default:
            break;
    }
}

- (void)clearCache {
    [MKCacheTool cleanCaches];
    [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
                                                  text:@"缓存清理完成"
                                    dissmissAfterDeley:1.2];
    self.cacheLab.text = @"0M";
}
#pragma mark - Lazyload
- (UITableView *)mkTableview{
    if (!_mkTableview) {
        _mkTableview = [[UITableView alloc] initWithFrame:CGRectZero
                                                    style:UITableViewStylePlain];
        _mkTableview.delegate = self;
        _mkTableview.backgroundColor = RGBCOLOR(30, 36, 50);
        _mkTableview.dataSource = self;
        _mkTableview.bounces = NO;
    }return _mkTableview;
}

- (MKAppVersionView *)mkVersionView{
    if (!_mkVersionView) {
        _mkVersionView = MKAppVersionView.new;
    }return _mkVersionView;
}
- (void)clearAllUserDefaultsData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        if ([[NSString stringWithFormat:@"%@",key] isEqualToString:@"Acc"]|| [[NSString stringWithFormat:@"%@",key] isEqualToString:@"Password"]) {
            break;
        }
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

@end
