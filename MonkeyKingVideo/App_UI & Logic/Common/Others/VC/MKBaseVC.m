//
//  MKBaseVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/9/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBaseVC.h"

@interface MKBaseVC (){
    UILabel *_navTitleLb;
    UIView *_navLineView;   //
}

@end

@implementation MKBaseVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavViews];
    
    [self setNavViewsLayoutUI];
    
}
- (void)addNavViews {
    //導航
    WeakSelf
    
    CGRect frame = CGRectMake(0, 0, 0, 0 );
    
    self.statusView = [[UIView alloc] initWithFrame:frame];
    
//    self.statusView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.statusView];
    

    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth,40)];
    
    self.navView.userInteractionEnabled = YES;
    
    self.navView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.navView];
    
    //返回
    _navBackBt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_navBackBt setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    
    [_navBackBt addAction:^(UIButton *btn) {
        
        [weakSelf gotoBack];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    _navBackBt.userInteractionEnabled = YES;
    
    _navBackBt.hidden = YES;
    
    [self.navView addSubview:_navBackBt];
    
    
    self.navTitleLb = [[UILabel alloc] initWithFrame:frame];
    
    self.navTitleLb.text = @"遊戲中心";
    
    self.navTitleLb.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightMedium];
    
    self.navTitleLb.textAlignment = NSTextAlignmentCenter;
    
    self.navTitleLb.textColor = HEXCOLOR(0x000000);
    
    [self.navView addSubview:self.navTitleLb];
    
    //說明
    self.delegateBt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.delegateBt.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    
    [self.delegateBt setImage:[UIImage imageNamed:@"black_Kefu"] forState:UIControlStateNormal];
    
    [self.delegateBt setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
    [self.delegateBt addAction:^(UIButton *btn) {
 
        [weakSelf gotoKefu];
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    if (@available(iOS 11.0, *)) {
        
        self.delegateBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentTrailing;
        
    } else {
        
    }
    self.delegateBt.userInteractionEnabled = YES;
    self.delegateBt.hidden = NO;
    [self.navView addSubview:self.delegateBt];
    _navLineView = [UIView new];
    _navLineView.backgroundColor = [UIColor clearColor];
    [self.navView addSubview:_navLineView];
}

- (void)setNavViewsLayoutUI {
    WeakSelf
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.view).offset(0);
        
        make.left.equalTo(weakSelf.view).offset(0);
        
        make.height.equalTo([NSNumber numberWithFloat:kStatusBarHeight]);
        
        make.width.equalTo([NSNumber numberWithFloat:kScreenWidth]);
        
    }];
    
    //導航
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.statusView.mas_bottom).offset(0);
        
        make.left.equalTo(weakSelf.view).offset(0);
        
        make.height.equalTo([NSNumber numberWithFloat:kNavigationBarHeight]);
        
        make.width.equalTo([NSNumber numberWithFloat:kScreenWidth]);
        
    }];
    //返回
    [_navBackBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView).offset(0);
        
        make.left.equalTo(self.navView).offset(8);
        
        make.height.equalTo([NSNumber numberWithFloat:kNavigationBarHeight]);
        
        make.width.equalTo([NSNumber numberWithFloat:50]);
        
    }];
    
    [_navTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView).offset(0);
        
        make.centerX.equalTo(self.navView);
        
        make.height.equalTo([NSNumber numberWithFloat:kNavigationBarHeight]);
        
        make.width.equalTo([NSNumber numberWithFloat:150]);
        
    }];
    
    //說明
    [_delegateBt mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView).offset(0);
        
        make.right.equalTo(self.navView).offset(-8);
        
        make.height.equalTo([NSNumber numberWithFloat:kNavigationBarHeight]);
        
        make.width.equalTo([NSNumber numberWithFloat:60]);
        
    }];
    
    //
    [_navLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView).offset(kNavigationBarHeight-1);
        
        make.left.equalTo(self.navView).offset(0);
        
        make.right.equalTo(self.navView).offset(0);
        
        make.height.equalTo([NSNumber numberWithFloat:1]);
    }];
    
}
- (void)gotoKefu{
    
}
- (void)gotoBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
