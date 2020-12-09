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

@property(nonatomic,strong)UIImageView *bacKIMGV;
@property(nonatomic,strong)UIImageView *title_1IMGV;//抖动短视频
@property(nonatomic,strong)UIImageView *title_2IMGV;//福利群官方
@property(nonatomic,strong)UIButton *joinNowBtn;
@property(nonatomic,strong) UIButton  *gameButton;

@end

@implementation CommunityVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
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
    [self.view addSubview:self.gameButton];
    [self.gameButton addAction:^(UIButton *btn) {

        [NSObject OpenURL:@"tingyun.75://"
                  options:@{}
    completionOpenSuccessHandler:^{
            //TODO
        }
    completionOpenFailHandler:^{
            [NSObject OpenURL:mkSkipHQAppString
                      options:@{}
        completionOpenSuccessHandler:^{
                //TODO
            }
        completionOpenFailHandler:^{
                //TODO
        //        [NSURL URLWithString:mkSkipHQAppString]
            }];
        }];
    }];
    [self.gameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28*MAINSCREEN_WIDTH/375);
        make.width.mas_equalTo(319*MAINSCREEN_WIDTH/375);
        
        if (isiPhoneX_series()) {
            make.top.mas_equalTo(67+rectOfStatusbar());
            make.bottom.mas_equalTo(-261);
        }else{
            make.top.mas_equalTo(47+rectOfStatusbar());
            make.bottom.mas_equalTo(-186);
        }
        
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
            
            if (isiPhoneX_series()) {
                make.bottom.mas_equalTo(-83);
            }else{
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
            make.size.mas_equalTo(CGSizeMake(243, 52));
            make.top.equalTo(self.view).offset(59);
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
            make.size.mas_equalTo(CGSizeMake(175, 136));
            make.top.equalTo(self.title_1IMGV.mas_bottom).offset(113);
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
            make.size.mas_equalTo(CGSizeMake(315, 44));
            if (isiPhoneX_series()) {
                make.bottom.mas_equalTo(-83-30);
            }else{
                make.bottom.mas_equalTo(-49-10);
            }

        }];
        [UIView cornerCutToCircleWithView:_joinNowBtn
                          AndCornerRadius:22];
    }return _joinNowBtn;
}

- (UIButton *)gameButton {
    if (!_gameButton) {
        _gameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gameButton setBackgroundImage:KIMG(@"group") forState:UIControlStateNormal];
        _gameButton.contentMode = UIViewContentModeScaleToFill;
      
    }
    return _gameButton;
}

@end
