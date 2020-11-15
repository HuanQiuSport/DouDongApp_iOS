
//
//  MKAttentionVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PersonalCenterVC.h"
#import "MKAttentionVC.h"
#import "MKAttentionVC+VM.h"

#import "MKAttentionCell.h"

#import "MKAttentionModel.h"
#import "MKAttentionSubModel.h"
#import "MKPersonalnfoModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
/// 我的关注
@interface MKAttentionVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>


@property(strong,nonatomic)UITableView *mkInfoTableView;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
/// 0 我的关注 ｜ 1 我的粉丝    ｜   2  他的关注 ｜  3  他的粉丝
@property (assign,nonatomic) NSInteger mkType;
/// pageNumber
@property (assign,nonatomic) NSInteger mkPageNumber;

///
@property (strong,nonatomic) MKAttentionModel *mkAttionModel;

///  个人信息model
@property (strong,nonatomic) MKPersonalnfoModel *mkPersonalModel;

/// 背景图片
@property (strong,nonatomic) UIImageView *mkBackImageView;

@property (nonatomic, assign)NSInteger page;

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL showEmpty;

@property(nonatomic,copy)MKDataBlock attentionVCBlock;
@end

@implementation MKAttentionVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKAttentionVC *vc = MKAttentionVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    vc.mkPersonalModel = (MKPersonalnfoModel *)requestParams[@"dataModel"];
    vc.mkType = [requestParams[@"mkType"] integerValue];
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
    /// 0 我的关注 ｜ 1 我的粉丝    ｜   2  他的关注 ｜  3  他的粉丝
    self.view.backgroundColor = HEXCOLOR(0xF8F8F8);
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    self.gk_navTitleColor = UIColor.blackColor;
    self.gk_navBackgroundColor = UIColor.whiteColor;
    self.gk_navLineHidden = YES;
    switch (self.mkType) {
        case 0:
            self.gk_navTitle = @"我的关注";
            break;
        case 1:
            self.gk_navTitle = @"我的粉丝";
            break;
        case 2:
            self.gk_navTitle = @"TA的关注";
            break;
        case 3:
            self.gk_navTitle = @"TA的粉丝";
            break;
        default:
            break;
    }
    [self mkAddSubView];
    [self mkLayOutView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
    self.mkPageNumber = 1;
    @weakify(self)
    [self requestWith:self.mkType WithPageNumber:self.mkPageNumber WithPageSize:10 Block:^(id data) {
        @strongify(self)
        self.showEmpty = YES;
    }];
}

#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    [self.view addSubview:self.mkBackImageView];
    
    [self.view addSubview:self.mkInfoTableView];
    
}

#pragma mark - 布局子视图
- (void)mkLayOutView{
    
   
    [self.mkBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.left.equalTo(self.view);
           
           make.right.equalTo(self.view);
           
           make.top.equalTo(self.view.mas_top).offset(kNavigationBarHeight+kStatusBarHeight);
           
           make.bottom.equalTo(self.view);
           
    }];
    
    [self.mkInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view);
        
        make.right.equalTo(self.view);
        
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(10);
        
        make.bottom.equalTo(self.view);
    }];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80 * KDeviceScale;
}

- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section{
    return self.mkAttionModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MKAttentionAll";
    MKAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MKAttentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = UIColor.whiteColor;
    MKAttentionSubModel *model  = self.mkAttionModel.list[indexPath.row];
    DLog(@"会员%@",model.isVip);
    cell.vipImgage.hidden =  ![model.isVip boolValue];

    cell.mkTitleLable.text = model.nickName;
    cell.mkDecripLabel.text = [NSString ensureNonnullString:model.remark ReplaceStr:@"这个家伙很懒，还没有写签名"];
    cell.mkFansLabel.text = [NSString  stringWithFormat:@"粉丝 %@ ",[NSString ensureNonnullString:model.fansNum ReplaceStr:@"0"]];
//    cell.mkLineView.backgroundColor = MKBakcColor;
    [cell.mKIMGageView sd_setImageWithURL:[NSURL URLWithString:model.headImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error == nil) {
            
            cell.mKIMGageView.image = image;
            
        }else{
            
            cell.mKIMGageView.image = KIMG(@"替代头像");
            
        }
    }];
    
    if (self.mkType == 0 || self.mkType == 1) {
         [cell.mkOutListButton setTitle:@"已关注" forState:UIControlStateSelected];
         [cell.mkOutListButton setTitle:@"关 注" forState:UIControlStateNormal];
         cell.mkOutListButton.selected = [model.attention isEqualToString:@"1"]?YES:NO; // 0 是没关注 1是关注
//        [cell rightButtton:cell.mkOutListButton.selected];
        
//         [[MKTools shared] setAtttionStyle:cell.mkOutListButton.selected ToButton:cell.mkOutListButton];
    }
    else if (self.mkType == 2 || self.mkType == 3 ) {
        
        cell.mkOutListButton.hidden = [model.areSelf isEqualToString:@"1"] ?YES:NO;
        cell.mkOutListButton.selected = [model.attention isEqualToString:@"1"]?YES:NO; // 0 是没关注 1是关注

//        [cell.mkOutListButton setTitle:@"已关注" forState:UIControlStateSelected]; // 已关注 attention = 1
//        [cell.mkOutListButton setTitle:@" 关注 " forState:UIControlStateNormal]; // 未关注 attention = 0
        [[MKTools shared] setAtttionStyle:cell.mkOutListButton.selected ToButton:cell.mkOutListButton];
        
    }
    [cell rightButtton:cell.mkOutListButton.selected];
    WeakSelf
    @weakify(cell)
    [cell.mkOutListButton addAction:^(UIButton *btn) {
        StrongSelf
        if (strongSelf.mkType == 0 || strongSelf.mkType == 1) {
           
            if (btn.selected)
            {
                @weakify(self)
                [strongSelf deleteListFrom:model WithBlock:^(id data) {
                    @strongify(self)
                    @strongify(cell)
                    if((Boolean)data){
//                        [MBProgressHUD wj_showSuccess:@"取消关注成功"];
                        [MBProgressHUD wj_showPlainText:@"取消关注" view:nil];
                        self.mkPageNumber = 1;
                        //
                        [MKTools mkHanderDeleteAttentionOfCurrentLoginWithUseId:model.userId.mutableCopy WithBool:NO];
                        cell.mkOutListButton.selected = NO;
                        [[MKTools shared] setAtttionStyle:cell.mkOutListButton.selected ToButton:cell.mkOutListButton];
                        model.fansNum = [NSString stringWithFormat:@"%@",@(MAX(model.fansNum.integerValue -1, 0))];
                        model.attention = @"0";
                    
                        [tableView reloadRow:indexPath.row inSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                        
                        if (strongSelf.mkType == 0){
                            int focusNum = [weakSelf.mkPersonalModel.focusNum intValue];
                            weakSelf.mkPersonalModel.focusNum = [NSString stringWithFormat:@"%@",@(MAX(focusNum-1,0))];
                        }else{
                            int fansNum = [weakSelf.mkPersonalModel.fansNum intValue];
                            weakSelf.mkPersonalModel.fansNum = [NSString stringWithFormat:@"%@",@(MAX(fansNum-1, 0))];
                        }
                        if (self.attentionVCBlock){
                            self.attentionVCBlock(strongSelf.mkPersonalModel);
                        }
                       
                        //
                    }else{
                        [MBProgressHUD wj_showSuccess:@"取消关注失败"];
                    }
                }];
            }
            else
            {
                @weakify(self)
                [strongSelf requestMyAttentionWith:model.userId WithBlock:^(id data) {
#warning 由于data可能变化了 导致永远判断为true 如果认为这方案不合理，就直接删除
//                    BOOL isAttention = [data boolValue]; // 由于data可能变化了 导致永远判断为true
//                    NSLog(@"%d",[[NSString stringWithFormat:@"%@", data] boolValue]);
                    if ((Boolean)data) {
                        @strongify(cell)
                        model.fansNum = [NSString stringWithFormat:@"%ld",model.fansNum.integerValue +1];
                        cell.mkFansLabel.text = [NSString stringWithFormat:@"粉丝%ld",model.fansNum.integerValue];
                        cell.mkOutListButton.selected = YES;
                        [[MKTools shared] setAtttionStyle:cell.mkOutListButton.selected ToButton:cell.mkOutListButton];
//                        [MBProgressHUD wj_showSuccess:@"关注成功"];
                        [MBProgressHUD wj_showPlainText:@"关注成功" view:nil];
                        model.attention = @"1";
                        [tableView reloadRow:indexPath.row inSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                        if (strongSelf.mkType == 0){
                            int focusNum = [weakSelf.mkPersonalModel.focusNum intValue];
                            weakSelf.mkPersonalModel.focusNum = [NSString stringWithFormat:@"%@",@(MAX(focusNum+1,0))];
                        }else{
                            int fansNum = [weakSelf.mkPersonalModel.fansNum intValue];
                            weakSelf.mkPersonalModel.fansNum = [NSString stringWithFormat:@"%@",@(MAX(fansNum+1, 0))];
                        }
                        if (self.attentionVCBlock){
                            self.attentionVCBlock(strongSelf.mkPersonalModel);
                        }
                        
                    }else{
                        [MBProgressHUD wj_showError:@"关注失败"];
                    }
                }];
            }
            
        }
        else if (strongSelf.mkType == 2 || strongSelf.mkType == 3 ) {
            
            if (btn.selected) {
                @weakify(self)
                @strongify(cell)
                [strongSelf deleteListFrom:model WithBlock:^(id data) {
                    @strongify(cell)
                    if((Boolean)data){
                        cell.mkOutListButton.selected = 0;
                        [[MKTools shared] setAtttionStyle:0 ToButton:cell.mkOutListButton];
                        [MKTools mkHanderDeleteAttentionOfCurrentLoginWithUseId:model.userId.mutableCopy WithBool:NO];
//                        [MBProgressHUD wj_showSuccess:@"取消关注成功"];
                        [MBProgressHUD wj_showPlainText:@"取消关注" view:nil];
                        model.fansNum = [NSString stringWithFormat:@"%@",@(MAX(model.fansNum.integerValue -1, 0))];
                        cell.mkFansLabel.text = [NSString stringWithFormat:@"粉丝%@",@(MAX(model.fansNum.integerValue -1, 0))];
                        model.attention = @"0";
                        [tableView reloadRow:indexPath.row inSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                    }else{
                        [MBProgressHUD wj_showError:@"取消关注失败"];
                    }
//                    @strongify(self)
//                    [weakSelf requestWith:self.mkType WithPageNumber:self.mkPageNumber WithPageSize:10 Block:^(id data) {
//
//                    }];
                }];
            }
            else{
                @weakify(self)
                [strongSelf requestMyAttentionWith:model.userId WithBlock:^(id data) {
#warning 由于data可能变化了 导致永远判断为true 如果认为这方案不合理，就直接删除
//                    BOOL isAttention = [data boolValue]; // 由于data可能变化了 导致永远判断为true
//                    NSLog(@"%d",[[NSString stringWithFormat:@"%@", data] boolValue]);
                    if ((Boolean)data) {
                        @strongify(cell)
                        model.fansNum = [NSString stringWithFormat:@"%ld",model.fansNum.integerValue +1];
                        cell.mkFansLabel.text = [NSString stringWithFormat:@"粉丝%ld",model.fansNum.integerValue];
                        cell.mkOutListButton.selected = 1;
                        [[MKTools shared] setAtttionStyle:1 ToButton:cell.mkOutListButton];
//                        [MBProgressHUD wj_showSuccess:@"关注成功"];
                        [MBProgressHUD wj_showPlainText:@"关注成功" view:nil];
                        model.attention = @"1";
                        [tableView reloadRow:indexPath.row inSection:indexPath.section withRowAnimation:UITableViewRowAnimationNone];
                    }else{
                        [MBProgressHUD wj_showError:@"关注失败"];
                    }
                }];
            }
        }
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MKAttentionSubModel *model  = self.mkAttionModel.list[indexPath.row];
//    @weakify(self)//1288002294503227393 //1288002294503227393
//    // 先放模拟数据
//    [PersonalCenterVC ComingFromVC:weak_self comingStyle:ComingStyle_PUSH presentationStyle:UIModalPresentationFullScreen requestParams:@{@"videoid":model.userId} success:^(id data) {
//
//    } animated:YES];
   
      NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
     NSString *nickName  = [userDefault objectForKey:@"nickName"];
     DLog(@"用户名%@",[MKPublickDataManager sharedPublicDataManage].mkLoginModel.nickName);
    if ([[MKPublickDataManager sharedPublicDataManage].mkLoginModel.nickName isEqualToString:model.nickName]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:MKMineNotification object:nil];
            [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 4;
        });
           
    } else {
        MKSingeUserCenterVC *vc = [[MKSingeUserCenterVC alloc]init];
          vc.requestParams = @{@"videoid":model.userId};
          [self.navigationController pushViewController:vc animated:YES];
    }
  
    
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *emptyString;
    switch (self.mkType) {
        case 0:
            emptyString = @"您还没有关注";
            break;
        case 1:
            emptyString = @"您还没有粉丝";
            break;
        case 2:
            emptyString = @"TA还没有关注";
            break;
        case 3:
            emptyString = @"TA还没有粉丝";
            break;
        default:
            break;
    }
    NSDictionary *attributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:16],
        NSForegroundColorAttributeName:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(120), 30)]]
    };
    return [[NSAttributedString alloc] initWithString:emptyString attributes:attributes];
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.showEmpty;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (UITableView *)mkInfoTableView{
    if (!_mkInfoTableView) {
        _mkInfoTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mkInfoTableView.delegate = self;
        _mkInfoTableView.dataSource = self;
        _mkInfoTableView.backgroundColor = [UIColor clearColor];
        _mkInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mkInfoTableView.mj_header = self.tableViewHeader;
        _mkInfoTableView.mj_footer = self.tableViewFooter;
        self.tableViewFooter.hidden = 1;
        _mkInfoTableView.emptyDataSetSource = self;
        _mkInfoTableView.emptyDataSetDelegate = self;
        _mkInfoTableView.tableFooterView = UIView.new;
        
    }return _mkInfoTableView;
}

- (void) requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize Block:(MKDataBlock)block{
    NSDictionary *easyDict = @{
         @"pageNum":@(pageNumber),
         @"pageSize":@(pageSize),
         @"userId":self.mkPersonalModel.id
     };
     ///
    NSString *url;
    if (type == 0 || type == 2) {
        url=  [URL_Manager sharedInstance].MkUserFocusListGET;
    }else{
        url = [URL_Manager sharedInstance].MKUserFansListGET;
    }
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:url
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    
     @weakify(self)
     [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
         if (response.isSuccess) {
             NSLog(@"%@",response.reqResult);
              NSError *error;
            @strongify(self)
                MKAttentionModel * model  = [[MKAttentionModel alloc]initWithDictionary:response.reqResult error:&error];
             
                 if (error == nil) {
                     if (self.mkPageNumber == 1) {
                         self.mkInfoTableView.mj_footer.hidden = 0;
                          self.mkAttionModel = model;
                          block(@(YES));
                     }else{
                         [self.mkAttionModel.list addObjectsFromArray:model.list];
                     }
                 }else{
                      block(@(NO));
                 }
    
             if (model.list.count < 10 || model.list.count == model.total) {
                 self.mkInfoTableView.mj_footer.hidden = 1;
             }
         }else{
             @strongify(self)
             block(@(NO));
             if (self.mkPageNumber > 1) {
                 self.mkPageNumber --;
             }
         }
         
         [self.mkInfoTableView.mj_header endRefreshing];
         [self.mkInfoTableView.mj_footer endRefreshing];
         
         [self.mkInfoTableView reloadData];
     }];
}

- (MKAttentionModel *)mkAttionModel{
    
    if (!_mkAttionModel ) {
        
        _mkAttionModel = [[MKAttentionModel alloc] init];
        
    }
    
    return _mkAttionModel;
}
- (MKPersonalnfoModel *)mkPersonalModel{
    
    if (!_mkPersonalModel) {
        
        _mkPersonalModel = [[MKPersonalnfoModel alloc] init];
    }
    
    return _mkPersonalModel;
}
// 下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    self.mkPageNumber = 1;
    [self requestWith:self.mkType WithPageNumber:self.mkPageNumber WithPageSize:10 Block:^(id data) {

    }];
}
//上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
    self.mkPageNumber += 1;

    [self requestWith:self.mkType WithPageNumber:self.mkPageNumber WithPageSize:10 Block:^(id data) {
        BOOL op = (Boolean)data;
        if (op) {

        }else{
            self.mkPageNumber -= 1;
        }

    }];  
}
#pragma mark - 取消关注
- (void)deleteListFrom:(MKAttentionSubModel *)model WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"userId":model.userId,
//         @"id":model.id,
    };
  
    NSString *url = [URL_Manager sharedInstance].MKUserFocusDeleteGET;
    
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:url
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    
    @weakify(self)
    
    
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            
            if(response.code == 200){
                
//               [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"已取消关注哦oooo～" dissmissAfterDeley:1.2];
//                [self.mkAttionModel.list removeObject:model];
//                [self.mkInfoTableView reloadData];
                block(@(YES));
            }
            
        }else{
            block(@(NO));
            [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"操作失败哦oooo～" dissmissAfterDeley:1.2];
      
        }
    
    }];
}
#pragma mark - 添加 添加关注
/// 添加关注
- (void)requestAttentionWith:(NSString*)userID
                   WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"followUserId":userID,
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKUserFocusAddPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            if (response.code == 200) {
                block(@(YES));
            }else{
                block(@(NO));
            }
            
        }
    }];
}
#pragma mark - From CoNg
- (void)requestMyAttentionWith:(NSString*)userID
                   WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"followUserId":userID,
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKUserFocusAddPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            if (response.code == 200) {
                block(@(YES));
            }else{
                block(@(NO));
            }
            
        }
    }];
}
- (void)attentionVCBlock:(MKDataBlock)attentionVCBlock{
    self.attentionVCBlock = attentionVCBlock;
}

#pragma mark - 去看看
- (void)gotoLook:(MKAttentionSubModel *)model WithBlock:(MKDataBlock)block{
    
    @weakify(self)
    MKSingeUserCenterVC *vc = [[MKSingeUserCenterVC alloc]init];
                       vc.requestParams = @{@"videoid":model.userId};
                       [self.navigationController pushViewController:vc animated:YES];
}

- (UIImageView *)mkBackImageView{
    
    if (!_mkBackImageView) {
        
        _mkBackImageView = [[UIImageView alloc]init];
        
        
//        _mkBackImageView.image = [UIImage imageWithColor:MKBakcColor];
        
        _mkBackImageView.contentMode = UIViewContentModeScaleToFill;
        
        
    }
    return _mkBackImageView;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.new;
    }
    return _dataArray;
}
@end
