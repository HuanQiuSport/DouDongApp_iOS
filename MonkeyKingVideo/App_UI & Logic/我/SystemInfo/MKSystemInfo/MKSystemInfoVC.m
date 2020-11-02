
//
//  MKSystemInfoVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/29/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSystemInfoVC.h"
#import "MKInfoListVC.h"
#import "MKInfoFansVC.h"
#import "MKInfoSetingVC.h"
#import "MKSystemInfoVC+VM.h"

#import "MKInfoListCell.h"

#import "MKSysModel.h"
#import "MKBtnAddBadge.h"
@interface MKSystemInfoVC ()
<
UITableViewDelegate
,UITableViewDataSource
>
/// 消息列表
@property (strong,nonatomic) UITableView *mkInfoTableView;

@end

@implementation MKSystemInfoVC
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    WeakSelf
    [self getData:^(id data) {
        if ((Boolean)data) {
            [weakSelf.mkInfoTableView reloadData];
        }
    }];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MKBakcColor;
    
    self.gk_navTitle = @"消息";
    
    self.gk_navTitleColor = [UIColor whiteColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setTitle:@"设置" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(mkGotoSeting) forControlEvents:UIControlEventTouchUpInside];

    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
   
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    
    self.gk_navItemRightSpace = 20;
    
    [self mkAddSubView];
    
    [self mkLayOutView];
}
#pragma mark - 设置
- (void)mkGotoSeting{
    [MBProgressHUD wj_showPlainText:@"正在开发中" view:nil];
    return;
    NSLog(@"设置入口");
    MKInfoSetingVC *vc = MKInfoSetingVC.new;
    vc.mkDataArray = self.mkDataArray;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self.view addSubview:self.mkInfoTableView];
    
    self.mkInfoTableView.backgroundColor = MKBakcColor;
    
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mkInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        
        make.right.equalTo(self.view);
        
        make.top.equalTo(self.view.mas_top).offset(kNavigationBarHeight+kStatusBarHeight);
        
        make.bottom.equalTo(self.view);
        
    }];
    
   
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * KDeviceScale;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mkDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MKSysInfoListAll";
    MKInfoListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MKInfoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [MKTools BackGroundColor];
        
    MKSysModel *model = self.mkDataArray[indexPath.row];
    
    cell.mkTitleLable.text = model.title;
    
    cell.mkTitleLable.textColor = [UIColor whiteColor];
    
    cell.mkDecripLabel.textColor = [UIColor whiteColor];
    
    
    cell.mkDecripLabel.text = model.context;
    
    if([NSString ensureNonnullString:model.createTime ReplaceStr:@"as"]){
         NSLog(@"⚠️⚠️后台给出的时间是空的%@",model.createTime);
         cell.mkTimeLable.text = [NSString stringWithFormat:@"%@",model.createTime];
        
    }else{
        
        cell.mkTimeLable.text = @"";
    }
    cell.mkTimeLable.hidden = NO;
    NSString *encodingString = [model.messageIcon stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.mKIMGageView setImageWithURL:[NSURL URLWithString:encodingString] placeholder:[UIImage imageNamed:@""]];

    cell.mkNumberLabel.hidden = YES;
    
    [[MKBtnAddBadge shared] AddBadge:cell.mKIMGageView SizeWith:CGSizeMake(21, 21) WithNumber:model.infoNumber.integerValue];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     MKSysModel *model = self.mkDataArray[indexPath.row];
    
    switch ([model.type integerValue]) {
        case 0:
        {
            MKInfoListVC *vc = MKInfoListVC.new;
            vc.mkParamModle = model;
            [self.navigationController pushViewController:vc animated:YES];
            
            [self readData:^(id data) {} WithData:@"0"];
        }
            break;
        case 1:
        {
            return;
//            MKInfoFansVC *vc =  MKInfoFansVC.new;
//            vc.type = 0;
//            [self.navigationController pushViewController:vc animated:YES];
            [self readData:^(id data) {

            } WithData:@"1"];
        }
            
            break;
        case 2:
        {
//            MKInfoFansVC *vc =  MKInfoFansVC.new;
//            vc.type = 1;
//            [self.navigationController pushViewController:vc animated:YES];
            [self readData:^(id data) {

            } WithData:@"2"];
        }
            break;
        default:
            break;
    }
}
- (UITableView *)mkInfoTableView{
    
    if (!_mkInfoTableView) {
        
        _mkInfoTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _mkInfoTableView.delegate = self;
        
        _mkInfoTableView.dataSource = self;
        
        _mkInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mkInfoTableView.backgroundColor = [UIColor blackColor];
    }
    return _mkInfoTableView;
}
- (NSMutableArray<MKSysModel *> *)mkDataArray{
    
    if (!_mkDataArray) {
        
        _mkDataArray = [NSMutableArray array];
    }
    return _mkDataArray;
}
@end
