//
//  MKInfoFansVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoFansVC.h"
#import "MKInfoFansVC+VM.h"

#import "MKInfoFansCell.h"

@interface MKInfoFansVC ()
<
UITableViewDelegate
,UITableViewDataSource
>
/// 消息列表
@property (strong,nonatomic) UITableView *mkInfoTableView;

@end

@implementation MKInfoFansVC

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    switch (self.type) {
        case 0:
            self.gk_navTitle = @"粉丝";
            break;
            
        default:
            self.gk_navTitle = @"评论";
            break;
    }
    self.gk_navTitleColor = [UIColor blackColor];
      
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

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100 * KDeviceScale;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MKSysInfoFansAll";
    MKInfoFansCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[MKInfoFansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (self.type) {
        case 0:
            cell.mkTitleLable.text = @"隔壁adey 关注了你";
            break;
        case 1:
            cell.mkTitleLable.text = @"隔壁adey 评论了你";
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UITableView *)mkInfoTableView{
    
    if (!_mkInfoTableView) {
        
        _mkInfoTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _mkInfoTableView.delegate = self;
        
        _mkInfoTableView.dataSource = self;
        
        _mkInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _mkInfoTableView;
}
@end
