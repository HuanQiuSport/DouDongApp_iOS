//
//  MyFansVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyFansVC.h"
#import "MyFansVC+VM.h"

#import "MyFansTBVCell.h"

@interface MyFansVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView * _Nullable tableView;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation MyFansVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}


+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MyFansVC *vc = MyFansVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    self.gk_navTitle = @"我的粉丝";
    self.gk_navTitleColor = kBlackColor;
    self.gk_statusBarHidden = NO;
    NSLog(@"");
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    self.tableView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyFansTBVCell cellHeightWithModel:nil];;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    @weakify(self)
//    [PersonalCenterVC ComingFromVC:weak_self
//                       comingStyle:ComingStyle_PUSH
//                 presentationStyle:UIModalPresentationAutomatic
//                     requestParams:nil
//                           success:^(id data) {}
//                          animated:YES];
//
//         MKSingeUserCenterVC *vc = [[MKSingeUserCenterVC alloc]init];
//        vc.requestParams = @{@"videoid":model.authorId};
//        [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFansTBVCell *cell = [MyFansTBVCell cellWith:tableView];
    [cell richElementsInCellWithModel:nil];
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"050013"];
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0 ;
        _tableView.mj_header = self.tableViewHeader;
        _tableView.mj_footer = self.tableViewFooter;
        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                          titleStr:@"没有评论"
                                                         detailStr:@"来发布第一条吧"];
//        if (？) {
//            [_tableView ly_hideEmptyView];
//        }else{
//            [_tableView ly_showEmptyView];
//        }
        _tableView.mj_footer.hidden = NO;
    }return _tableView;
}

@end
