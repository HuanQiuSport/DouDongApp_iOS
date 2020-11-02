//
//  MKInfoListVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoListVC.h"
#import "MKInfoListVC+VM.h"

#import "MKInfoDetailCell.h"

#import "MKSysModel.h"

@interface MKInfoListVC ()
<
UITableViewDelegate
,UITableViewDataSource
,DZNEmptyDataSetSource
,DZNEmptyDataSetDelegate
>
/// 消息列表
@property (strong,nonatomic) UITableView *mkInfoTableView;

@end

@implementation MKInfoListVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MKBakcColor;
    
    self.gk_navTitle = @"系统消息";
    self.gk_navTitleColor = [UIColor whiteColor];
    self.gk_backStyle =  GKNavigationBarBackStyleWhite;
    
//    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonIt emStylePlain target:self action:@selector(mkGotoSeting)];
    
    [self mkAddSubView];
    [self mkLayOutView];
    
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

    WeakSelf
    [self getDataWithID:self.mkParamModle.type WithBlock:^(id data) {
        if ((Boolean)data) {
            [weakSelf.mkInfoTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mkDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MKInfoDetailCell *cell = [MKInfoDetailCell MKInfoDetailCellWith:tableView];
    cell.model = self.mkDataArray[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MKSysModel *model = self.mkDataArray[indexPath.row];
    return [model.height floatValue];
//    return 135 * KDeviceScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark getter &setter
- (UITableView *)mkInfoTableView{
    if (!_mkInfoTableView) {
        _mkInfoTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mkInfoTableView.delegate = self;
        _mkInfoTableView.dataSource = self;
        _mkInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mkInfoTableView.emptyDataSetSource  = self;
        _mkInfoTableView.emptyDataSetDelegate = self;
        _mkInfoTableView.backgroundColor = MKBakcColor;
    }
    return _mkInfoTableView;
}

- (MKSysModel *)mkParamModle{
    if (!_mkParamModle) {
        _mkParamModle = [[MKSysModel alloc]init];
    }
    return _mkParamModle;
}

- (NSMutableArray<MKSysModel *> *)mkDataArray{
    if (!_mkDataArray) {
        _mkDataArray = [NSMutableArray array];
    }
    return _mkDataArray;
}

#pragma mark -  空数据delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"av"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂时没有更多数据";
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

@end
