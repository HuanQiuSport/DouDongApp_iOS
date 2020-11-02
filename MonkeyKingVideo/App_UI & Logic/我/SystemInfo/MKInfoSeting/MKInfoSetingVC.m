//
//  MKInfoSetingVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoSetingVC.h"
#import "MKInfoSetingVC+VM.h"

#import "MKInfoSetingCell.h"

#import "MKSysModel.h"

@interface MKInfoSetingVC ()
<
UITableViewDelegate
,UITableViewDataSource
,MKInfoSetingCellDelegate
>
/// 消息列表
@property (strong,nonatomic) UITableView *mkInfoTableView;

@end

@implementation MKInfoSetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.gk_navTitle = @"消息设置";
    
    self.gk_navTitleColor = [UIColor whiteColor];
    
    self.gk_navigationBar.backgroundColor = HEXCOLOR(0x242A37);
    
    self.gk_backStyle =  GKNavigationBarBackStyleWhite;
      
    [self mkAddSubView];
    
    [self mkLayOutView];
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
        
        make.top.equalTo(self.view.mas_top).offset(kNavigationBarHeight+kStatusBarHeight);
        
        make.bottom.equalTo(self.view);
        
    }];
    
    self.mkInfoTableView.backgroundColor = HEXCOLOR(0x242A37);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    return @"互动通知";
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 设置section背景颜色
    view.tintColor = HEXCOLOR(0x242A37);
    // 设置section字体颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    [header.textLabel setTextColor:HEXCOLOR(0xA7A7A7)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40 * KDeviceScale;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.mkDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"MKSysInfoSetingAll";
    
    MKInfoSetingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[MKInfoSetingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.section) {
        case 0:
            cell.mkTitleLable.text = @"推送接收通知";
            break;
        default:
        {
            
            MKSysModel *model = self.mkDataArray[indexPath.row];
            
            cell.mkTitleLable.text = model.title;
         
           
        }
            break;
    }
    cell.backgroundColor = [MKTools BackGroundColor2];
    
    cell.mkTitleLable.textColor = [UIColor whiteColor];
    
    cell.mkDelegate = self;
    
    cell.indexPath = indexPath;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didClickDelegate:(UIView *)superView WithIndex:(nonnull NSIndexPath *)indexPath{
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    if (indexPath.section == 0) {
        [dic setValue:0 forKey:@"status"];
        [dic setValue:0 forKey:@"id"];
        WeakSelf
        [self getDataWithDict:dic WithBlock:^(id data) {
            
            if ((Boolean)data) {
                [weakSelf getData];
            }
            
        }];
        
    }
    
    if (indexPath.section == 1) {
        
        MKSysModel *model = self.mkDataArray[indexPath.row];
        
        [dic setValue:model.status forKey:@"status"];
        [dic setValue:model.id forKey:@"id"];
        
        WeakSelf
        [self getDataWithDict:dic WithBlock:^(id data) {
            
            if ((Boolean)data) {
                [weakSelf getData];
            }
            
        }];
    }
}
- (void)getData{
    WeakSelf
    [self getDataWithDict:@{}.mutableCopy WithBlock:^(id data) {
        if ((Boolean)data) {
            
            [weakSelf.mkInfoTableView reloadData];
        }
    }];
}
- (UITableView *)mkInfoTableView{
    
    if (!_mkInfoTableView) {
        
        _mkInfoTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _mkInfoTableView.delegate = self;
        
        _mkInfoTableView.dataSource = self;
        
//        _mkInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _mkInfoTableView;
}
@end
