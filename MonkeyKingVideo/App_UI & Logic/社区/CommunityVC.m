//
//  CommunityVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityVC+VM.h"
#import "MKGameController.h"


@interface CommunityVC ()

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)UIImageView *bacKIMGV;
@property(nonatomic,strong)UIImageView *title_1IMGV;//抖动短视频
@property(nonatomic,strong)UIImageView *title_2IMGV;//福利群官方
@property(nonatomic,strong)UIButton *joinNowBtn;
@property(nonatomic,strong) UIButton  *gameButton;

@property(nonatomic,strong) UIImageView *guanfangImageView;
@property(nonatomic,strong) UIImageView *topTitleImageView;
@end

@implementation CommunityVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    CommunityVC *vc = CommunityVC.new;
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
//            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

#pragma mark - Lifecycle
-(instancetype)init{
    
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    self.bacKIMGV.alpha = 1;
    self.title_1IMGV.alpha = 0;
    self.title_2IMGV.alpha = 0;
    self.joinNowBtn.alpha = 1;
    [self.view addSubview:self.guanfangImageView];
    [self.view addSubview:self.topTitleImageView];
    [self.view addSubview:self.gameButton];
    [self.gameButton addAction:^(UIButton *btn) {
        NSURL * url = [NSURL URLWithString:@"tingyun.75://"];
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
        //先判断是否能打开该url
        if (canOpen){//打开微信
            [[UIApplication sharedApplication] openURL:url];
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mkSkipHQAppString]
                                               options:@{}
                                     completionHandler:nil];
        }
    }];
//    [self.gameButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(28*SCREEN_WIDTH/375);
//        make.width.mas_equalTo(319*SCREEN_WIDTH/375);
//        if (IS_IPHONE_X | IS_IPHONE_Xs) {
//            make.top.mas_equalTo(67+BR_STATUSBAR_HEIGHT);
//            make.bottom.mas_equalTo(-261);
//        } else if (IS_IPHONE_Xr){
//            make.top.mas_equalTo(67+BR_STATUSBAR_HEIGHT);
//            make.bottom.mas_equalTo(-281);
//        } else if (IS_IPHONE_Xs_Max){
//            make.top.mas_equalTo(67+BR_STATUSBAR_HEIGHT);
//            make.bottom.mas_equalTo(-281);
//        } else {
//            make.top.mas_equalTo(47+BR_STATUSBAR_HEIGHT);
//            make.bottom.mas_equalTo(-186);
//        }
//    }];
    
    [self.guanfangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.joinNowBtn.mas_right);
        make.bottom.equalTo(self.joinNowBtn.mas_top).offset(-5);
        make.width.equalTo(@(319*SCREEN_WIDTH/375 - 50));
        make.height.equalTo(@((319*SCREEN_WIDTH/375 - 50) / 2.63));
    }];
    CGFloat topTitleWidth = 130;
    [self.topTitleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.mas_topLayoutGuide).offset(10);
        make.width.equalTo(@(topTitleWidth));
        make.height.equalTo(@(topTitleWidth * 81 / 321));
    }];
    
    [self.gameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        
        make.bottom.equalTo(self.guanfangImageView.mas_top).offset(-5);
        make.top.equalTo(self.topTitleImageView.mas_bottom).offset(10);
        
    }];
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    #warning UserDefault存页面暂时解决上传页面返回问题
    SetUserDefaultKeyWithValue(@"selectedIndex", @"1");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark —— 立即加入 点击事件
-(void)joinNowBtnClickEvent:(UIButton *)sender{
    if ([MKTools mkLoginIsYESWith:self]){
        [NSObject feedbackGenerator];
            [UIView addViewAnimation:sender
                     completionBlock:^(id data) {
            }];
            [MKTools openGoToPotatol];
    }
}

#pragma mark —— lazyLoad
-(UIImageView *)bacKIMGV{
    if (!_bacKIMGV) {
        _bacKIMGV = UIImageView.new;
        _bacKIMGV.contentMode = UIViewContentModeScaleAspectFill;
        // 设置这个裁剪掉uiimage超出区域部分
        _bacKIMGV.clipsToBounds = true;

            _bacKIMGV.image = KIMG(@"backViewDouDong");
        [self.view addSubview:_bacKIMGV];
        [_bacKIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            if (IS_IPHONE_X | IS_IPHONE_Xs) {
                make.bottom.mas_equalTo(-83);
            } else if (IS_IPHONE_Xr){
                make.bottom.mas_equalTo(-83);
            } else if (IS_IPHONE_Xs_Max){
                make.bottom.mas_equalTo(-83);
            } else {
                make.bottom.mas_equalTo(-49);
            }
        }];
    }return _bacKIMGV;
}

-(UIImageView *)title_1IMGV{
    if (!_title_1IMGV) {
        _title_1IMGV = UIImageView.new;
        _title_1IMGV.image = KIMG(@"抖动短视频");
        [self.view addSubview:_title_1IMGV];
        [_title_1IMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(243), SCALING_RATIO(52)));
            make.top.equalTo(self.view).offset(SCALING_RATIO(59));
        }];
    }return _title_1IMGV;
}

-(UIImageView *)title_2IMGV{
    if (!_title_2IMGV) {
        _title_2IMGV = UIImageView.new;
        _title_2IMGV.image = KIMG(@"福利群官方");
        [self.view addSubview:_title_2IMGV];
        [_title_2IMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(175), SCALING_RATIO(136)));
            make.top.equalTo(self.title_1IMGV.mas_bottom).offset(SCALING_RATIO(113));
        }];
    }return _title_2IMGV;
}

-(UIButton *)joinNowBtn{
    if (!_joinNowBtn) {
        _joinNowBtn = UIButton.new;
        [_joinNowBtn setBackgroundImage:KIMG(@"画板")
                               forState:UIControlStateNormal];
        _joinNowBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica"
                                                      size:15];
        [_joinNowBtn setTitleColor:COLOR_RGB(255,
                                             255,
                                             255,
                                             1)
                          forState:UIControlStateNormal];
        [_joinNowBtn setTitle:@"立即加入"
                     forState:UIControlStateNormal];
        [_joinNowBtn addTarget:self
                        action:@selector(joinNowBtnClickEvent:)
              forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_joinNowBtn];
        [_joinNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(315), SCALING_RATIO(44)));
//            make.top.equalTo(self.title_2IMGV.mas_bottom).offset(SCALING_RATIO(184));
//            make.bottom.mas_equalTo(-30-TABBARH);
            if (IS_IPHONE_X | IS_IPHONE_Xs) {
                make.bottom.mas_equalTo(-83-30);
            } else if (IS_IPHONE_Xr){
                make.bottom.mas_equalTo(-83-30);
            } else if (IS_IPHONE_Xs_Max){
                make.bottom.mas_equalTo(-83-30);
            } else {
                make.bottom.mas_equalTo(-49-10);
            }
        }];
        [UIView cornerCutToCircleWithView:_joinNowBtn
                          AndCornerRadius:SCALING_RATIO(44 / 2)];
    }return _joinNowBtn;
}

-(UIImageView *)guanfangImageView {
    if(_guanfangImageView== nil) {
        _guanfangImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shequ_coin_tip"]];
//        _guanfangImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _guanfangImageView;
}

-(UIImageView *)topTitleImageView {
    if(_topTitleImageView== nil) {
        _topTitleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shequ_top_title"]];
    }
    return _topTitleImageView;
}



- (UIButton *)gameButton {
    if (!_gameButton) {
        _gameButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_gameButton setBackgroundImage:KIMG(@"group") forState:UIControlStateNormal];
        [_gameButton setImage:KIMG(@"group") forState:UIControlStateNormal];
        _gameButton.contentMode = UIViewContentModeScaleAspectFit;
      
    }
    return _gameButton;
}

@end
