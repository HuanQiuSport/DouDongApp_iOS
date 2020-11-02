//
//  MKBlackListVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBlackListVC.h"
#import "MKBlackListCell.h"
#import "MKBlackModel.h"
#import "MKBlackSubModel.h"
#import "MKBlackListVC+VM.h"
@interface MKBlackListVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(strong,nonatomic)UITableView *mkInfoTableView;

@end

@implementation MKBlackListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.gk_navTitle = @"我的黑名单";
    self.gk_navTitleColor = kBlackColor;
    [self mkAddSubView];
    [self mkLayOutView];
    WeakSelf
    [self requestWith:0 WithPageNumber:0 WithPageSize:100 Block:^(id data) {
        if ((Boolean)data) {
            [weakSelf.mkInfoTableView reloadData];
        }
    }];
    
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    [self.view addSubview:self.mkInfoTableView];
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    [self.mkInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(kNavigationBarHeight+kStatusBarHeight);
        make.top.equalTo(self.gk_navigationBar.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * KDeviceScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mkBlackModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MKSetBlackListAll";
    MKBlackListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MKBlackListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MKBlackSubModel *modle = self.mkBlackModel.list[indexPath.row];
    
    cell.mkTitleLable.text = modle.nickName;
    
    cell.mkDecripLabel.text = modle.remark;
    
    cell.mkFansLabel.text = [NSString stringWithFormat:@"粉丝 %@",modle.fansNum];
    
    [cell.mKIMGageView sd_setImageWithURL:[NSURL URLWithString:modle.headImage] placeholderImage:KIMG(@"nodata")];
    
    [cell.mkOutListButton setTitle:@"解除拉黑" forState:UIControlStateNormal];
    WeakSelf
    [cell.mkOutListButton addAction:^(UIButton *btn) {
       
        
        [weakSelf deleteBalckNameList:modle.id WithBlock:^(id data) {
            
            if((Boolean)data){
                
                [[MKTools shared] showMBProgressViewOnlyTextInView:weakSelf.view
                                                              text:@"解除黑名单成功"
                                                dissmissAfterDeley:1.2];
            }else{
                [[MKTools shared] showMBProgressViewOnlyTextInView:weakSelf.view
                                                              text:@"解除黑名单没有成功"
                                                dissmissAfterDeley:1.2];
            }
            
          
        }];
        
    }];
    
    return cell;
}

- (UITableView *)mkInfoTableView{
    if (!_mkInfoTableView) {
        _mkInfoTableView = [[UITableView alloc]initWithFrame:CGRectZero
                                                       style:UITableViewStylePlain];
        _mkInfoTableView.delegate = self;
        _mkInfoTableView.dataSource = self;
        _mkInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
    }return _mkInfoTableView;
}
- (MKBlackModel *)mkBlackModel{
    
    if (!_mkBlackModel) {
        
        _mkBlackModel = MKBlackModel.new;
        
    }
    return _mkBlackModel;
}
@end
