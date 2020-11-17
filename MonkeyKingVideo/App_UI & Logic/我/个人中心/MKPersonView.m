//
//  MKPersonView.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/6/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKPersonView.h"
@interface MKPersonView()

@property (nonatomic, strong) UIView *topLineView;


@end

@implementation MKPersonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self mkAddSubView];
        
        [self mkLayOutView];
    }
    return self;
}
-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        self.loginLab.textColor = HEXCOLOR(0x000000);
        self.mkUserLabel.textColor = HEXCOLOR(0x000000);
        [self.mkSexAge setTitleColor:HEXCOLOR(0x000000) forState:UIControlStateNormal];
        self.mkArea.textColor = HEXCOLOR(0x000000);
        self.mkConstellationLab.textColor = HEXCOLOR(0x000000);
        self.mkDetailLabel.textColor = HEXCOLOR(0x000000);
    } else {
        self.loginLab.textColor = UIColor.whiteColor;
        self.mkUserLabel.textColor = [UIColor whiteColor];
        [self.mkSexAge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.mkArea.textColor =  [UIColor whiteColor];
        self.mkConstellationLab.textColor = [UIColor whiteColor];
        self.mkDetailLabel.textColor = [UIColor whiteColor];
    }
    [self.mkAttentionNumView refreshSkin];
    [self.mkFansNumView refreshSkin];
    [self.mkZanNumView refreshSkin];
    [self.mkMultiBtnView refreshSkin];
    
}

#pragma mark - 添加子视图
- (void)mkAddSubView{
    self.mkUserImageView.alpha = 1;
    self.mkUserLabel.alpha = 0;
    self.mkDetailLabel.alpha = 1;
    self.mkAttentionBtn.alpha = 1;
    
    self.mkAttentionNumView.alpha = 1;
    self.mkFansNumView.alpha = 1;
    self.mkZanNumView.alpha = 1;
    
    [self addSubview:self.loginBtn];
    [self addSubview:self.loginLab];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mkUserImageView.mas_right).offset(10);
        make.height.offset(28);
        make.width.offset(99);
        make.top.mas_equalTo(self.mkUserImageView.mas_top).offset(12);
    }];
    [self.loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(8);
        make.height.offset(14);
        make.left.mas_equalTo(self.loginBtn.mas_left).offset(0);
    }];
    
    [self addOherView];
    
    [self addSubview:self.topLineView];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(kNavigationBarHeight);
        make.height.mas_equalTo(@(8));
    }];
    
    
}
- (void)setNoLoginData {
    if ([MKTools mkLoginIsLogin]) {
        //没登录
        self.loginBtn.hidden = NO;
        self.loginLab.hidden = NO;
        self.mkAttentionBtn.hidden = YES;
        self.mkUserLabel.hidden = YES;
        self.mkDetailLabel.hidden = YES;
    } else {
        self.loginBtn.hidden = YES;
        self.loginLab.hidden = YES;
        self.mkAttentionBtn.hidden = NO;
        self.mkUserLabel.hidden = NO;
        self.mkDetailLabel.hidden = NO;
    }
}
#pragma mark - 布局子视图
-(void)mkLayOutView{
    
}
#pragma mark - 头像 其他个人信息
- (UIImageView *)mkUserImageView{
    
    if (!_mkUserImageView) {
        
        _mkUserImageView = [[UIImageView alloc]init];
        
        _mkUserImageView.image = KIMG(@"替代头像");
        
        _mkUserImageView.layer.cornerRadius = 33 *KDeviceScale;
        
        _mkUserImageView.layer.masksToBounds = YES;
        
        _mkUserImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_mkUserImageView];
        
        [_mkUserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.equalTo(@(66 *KDeviceScale));
            
            make.top.equalTo(@(kNavigationBarHeight + 20 * KDeviceScale));
            
            make.left.equalTo(@(16 *KDeviceScale));
            
        }];
    }
    return _mkUserImageView;
}
- (UIImageView *)mkUserVIPImageView
{
    if (!_mkUserVIPImageView) {
        _mkUserVIPImageView = [[UIImageView alloc]init];
        
        _mkUserVIPImageView.image = KIMG(@"icon_userVIP");
        
        [self addSubview:_mkUserVIPImageView];
        
        [_mkUserVIPImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(19 *KDeviceScale));
            make.height.equalTo(@(17 *KDeviceScale));
            
            make.left.equalTo(self.mkUserLabel.mas_right).offset(6*KDeviceScale);
            make.centerY.equalTo(self.mkUserLabel.mas_centerY).offset(0);
            
        }];
    }
    return _mkUserVIPImageView;
}
#pragma mark - 昵称 其他个人信息
- (UILabel *)mkUserLabel{
    
    if (!_mkUserLabel) {
        
        
        _mkUserLabel = [[UILabel alloc]init];
        
        _mkUserLabel.textColor = [UIColor whiteColor];
        
        _mkUserLabel.text = @"筑物季";
        
        _mkUserLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        _mkUserLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightHeavy];
        
        [self addSubview:_mkUserLabel];
        
        [_mkUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(16 *KDeviceScale));
            
            //            make.right.equalTo(@(-16 *KDeviceScale));
            
            make.top.equalTo(self.mkUserImageView.mas_bottom).offset(3*KDeviceScale);
            
            make.left.equalTo(@(16 *KDeviceScale));
            
        }];
    }
    return _mkUserLabel;
}
#pragma mark - 签名 其他个人信息
- (UILabel *)mkDetailLabel{
    
    if (!_mkDetailLabel) {
        
        _mkDetailLabel = [[UILabel alloc]init];
        
        _mkDetailLabel.textColor = [UIColor whiteColor];
        
        _mkDetailLabel.text = @"";
        
        _mkDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        _mkDetailLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        
        [self addSubview:_mkDetailLabel];
        
        [_mkDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@(-16 *KDeviceScale));
            
            make.top.equalTo(self.mkUserImageView.mas_bottom).offset(35*KDeviceScale);
            
            make.left.equalTo(@(16 *KDeviceScale));
            
        }];
    }
    return _mkDetailLabel;
}
#pragma mark - 关注 其他个人信息
- (UIButton *)mkAttentionBtn{
    if (!_mkAttentionBtn) {
        
        _mkAttentionBtn = [[UIButton alloc]init];
        
        //        [_mkAttentionBtn setBackgroundImage:KIMG(@"画板") forState:UIControlStateNormal];
        
        //        [_mkAttentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
        //
        //        [_mkAttentionBtn setTitle:@"关 注" forState:UIControlStateNormal];
        
        _mkAttentionBtn.layer.cornerRadius = 14.5 *KDeviceScale;
        
        _mkAttentionBtn.layer.masksToBounds = YES;
        
        [self addSubview:_mkAttentionBtn];
        
        [_mkAttentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(193 *KDeviceScale));
            
            make.height.equalTo(@(29 *KDeviceScale));
            
            make.top.equalTo(@(kNavigationBarHeight + 20 * KDeviceScale + 4));
            
            make.left.equalTo(@(91 *KDeviceScale));
            
        }];
        _mkAttentionBtn.hidden = YES;
    }
    return _mkAttentionBtn;
    
}
- (void)setAtttionStyle:(BOOL)isSelect{
    [_mkAttentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [_mkAttentionBtn setTitle:@"关 注" forState:UIControlStateNormal];
    
    if (isSelect) {
        
        [_mkAttentionBtn setBackgroundImage:[UIImage imageWithColor:MKBakcColor] forState:UIControlStateNormal];
        
        _mkAttentionBtn.layer.cornerRadius = 14.5 *KDeviceScale;
        
        _mkAttentionBtn.layer.masksToBounds = YES;
        
        _mkAttentionBtn.layer.borderColor = MKBorderColor.CGColor;
        
        _mkAttentionBtn.layer.borderWidth = 1;
        
    }else{
        [_mkAttentionBtn setBackgroundImage:KIMG(@"画板") forState:UIControlStateNormal];
        
        _mkAttentionBtn.layer.cornerRadius = 14.5 *KDeviceScale;
        
        _mkAttentionBtn.layer.masksToBounds = YES;
        
        _mkAttentionBtn.layer.borderColor = MKBorderColor.CGColor;
        
        _mkAttentionBtn.layer.borderWidth = 0;
    }
}
#pragma mark - 关注数量 其他个人信息
- (MKBtnLabelView *)mkAttentionNumView{
    
    if (!_mkAttentionNumView) {
        
        _mkAttentionNumView = [[MKBtnLabelView alloc]init];
        
        _mkAttentionNumView.mkTitleLabel.text = @"关注";
        
        _mkAttentionNumView.mkNumberLabel.text = @"0";
        
        [self addSubview:_mkAttentionNumView];
        
        [_mkAttentionNumView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(100 *KDeviceScale));
            
            make.height.equalTo(@(41 *KDeviceScale));
            
            make.left.equalTo(@([UIScreen mainScreen].bounds.size.width/4.0 - KDeviceScale * 75 ));
            
            make.top.equalTo(self.mkUserImageView.mas_bottom).offset(18);
            
        }];
    }
    return _mkAttentionNumView;
}

#pragma mark - 粉丝数量 其他个人信息
- (MKBtnLabelView *)mkFansNumView{
    
    if (!_mkFansNumView) {
        
        _mkFansNumView = [[MKBtnLabelView alloc]init];
        
        _mkFansNumView.mkTitleLabel.text = @"粉丝";
        
        _mkFansNumView.mkNumberLabel.text = @"0";
        
        [self addSubview:_mkFansNumView];
        
        [_mkFansNumView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(100 * KDeviceScale));
            
            make.height.equalTo(@(41 * KDeviceScale));
            
            make.left.equalTo(@([UIScreen mainScreen].bounds.size.width/2.0 - 50 * KDeviceScale ));
            
            make.top.equalTo(self.mkUserImageView.mas_bottom).offset(18);
            
        }];
        
    }
    return _mkFansNumView;
}
#pragma mark - 点赞数量 其他个人信息
- (MKBtnLabelView *)mkZanNumView{
    
    if (!_mkZanNumView) {
        
        _mkZanNumView = [[MKBtnLabelView alloc]init];
        //        _mkZanNumView.backgroundColor = [UIColor redColor];
        
        _mkZanNumView.mkTitleLabel.text = @"获赞";
        
        _mkZanNumView.mkNumberLabel.text = @"0";
        
        [self addSubview:_mkZanNumView];
        
        CGFloat x = ( [UIScreen mainScreen].bounds.size.width/4.0)  * 3 ;
        
        [_mkZanNumView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(100 * KDeviceScale));
            
            make.height.equalTo(@(41 * KDeviceScale));
            
            make.left.equalTo(@( x - 25 * KDeviceScale ));
            
            make.top.equalTo(self.mkUserImageView.mas_bottom).offset(18);
            
        }];
    }
    return _mkZanNumView;
}
#pragma mark - 性别和年龄
- (UIButton *)mkSexAge{
    
    if (!_mkSexAge) {
        
        _mkSexAge = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_mkSexAge titleLabel].font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        
        [_mkSexAge setImageEdgeInsets:UIEdgeInsetsMake(-4,-2, -4,4)];
        
        [_mkSexAge setTitleEdgeInsets:UIEdgeInsetsMake(-2,4, -2,-2)];
        
        [_mkSexAge setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        
         [self addSubview:_mkSexAge];
         [self setOtherStyle:_mkSexAge];
        [_mkSexAge mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(60 * KDeviceScale));
            
            make.height.equalTo(@(22 * KDeviceScale));
            
            make.left.equalTo(self.mkAttentionBtn.mas_left);
            
            make.top.equalTo(self.mkAttentionBtn.mas_bottom).offset(7*KDeviceScale);
            
        }];
    }
    return _mkSexAge;
}
#pragma mark - 星座 其他个人信息
- (UILabel *)mkConstellationLab{
    
    if (!_mkConstellationLab) {
        
        _mkConstellationLab = [[UILabel alloc]init];
        
        _mkConstellationLab.textAlignment = NSTextAlignmentCenter;
        
        _mkConstellationLab.textColor = UIColor.blackColor;
        
        _mkConstellationLab.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        
        [self addSubview:_mkConstellationLab];
        
        [self setOtherStyle:_mkConstellationLab];
        
        [_mkConstellationLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(60 * KDeviceScale));
            
            make.height.equalTo(@(22* KDeviceScale));
            
            make.left.equalTo(self.mkArea.mas_right).offset(8*KDeviceScale);
            
            make.top.equalTo(self.mkSexAge.mas_top);
            
            
        }];
    }
    return _mkConstellationLab;
}
- (void)setOtherStyle:(UIView *)sub{
    
    sub.layer.cornerRadius = 6;
    
    sub.layer.borderColor = HEXCOLOR(0xCECECE).CGColor;
    
    sub.layer.borderWidth = 1;
    
    sub.layer.masksToBounds = YES;
    
}
#pragma mark - 地区 其他个人信息
- (UILabel *)mkArea{
    
    if (!_mkArea) {
        
        _mkArea = [[UILabel alloc]init];
        
        _mkArea.textColor = UIColor.blackColor;
        
        _mkArea.textAlignment = NSTextAlignmentCenter;
        
        _mkArea.font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        
        [self addSubview:_mkArea];
        
        [self setOtherStyle:_mkArea];
        
        [_mkArea mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.greaterThanOrEqualTo(@(60 * KDeviceScale));
            
            make.height.equalTo(@(22 * KDeviceScale));
            
            make.left.equalTo(self.mkSexAge.mas_right).offset(8*KDeviceScale);
            
            make.top.equalTo(self.mkSexAge.mas_top);
            
            
        }];
        
    }
    return _mkArea;
}
#pragma mark - 我的个人中心重新布局 或者刷新UI
- (void)taCenterRefresh {
    self.mkUserImageView.alpha = 1;
    self.mkUserLabel.alpha = 1;
    [self.mkAttentionNumView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(100 *KDeviceScale));
        
        make.height.equalTo(@(41 *KDeviceScale));
        
        make.left.equalTo(@([UIScreen mainScreen].bounds.size.width/4.0 - KDeviceScale * 75 ));
        
        make.top.mas_equalTo(self.mkDetailLabel.mas_bottom).offset(30*KDeviceHeightScale);
    }];
    
    [self.mkFansNumView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(100 * KDeviceScale));
        
        make.height.equalTo(@(41 * KDeviceScale));
        
        make.left.equalTo(@([UIScreen mainScreen].bounds.size.width/2.0 - 50 * KDeviceScale ));
        
        make.top.mas_equalTo(self.mkDetailLabel.mas_bottom).offset(30*KDeviceHeightScale);
        
    }];
    CGFloat x = ( [UIScreen mainScreen].bounds.size.width/4.0)  * 3 ;
    [self.mkZanNumView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(100 * KDeviceScale));
        
        make.height.equalTo(@(41 * KDeviceScale));
        
        make.left.equalTo(@( x - 25 * KDeviceScale ));
        
        make.top.mas_equalTo(self.mkDetailLabel.mas_bottom).offset(30*KDeviceHeightScale);
        
    }];
    self.mkMultiBtnView.hidden = YES;
}
- (void)mkRefreshUILayout{
    self.mkUserImageView.alpha = 1;
    self.mkUserLabel.alpha = 1;
#pragma mark - 重新布局
    [self.mkUserLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mkUserImageView.mas_right).offset(10*KDeviceScale);
        make.top.equalTo(self.mkUserImageView.mas_top);
    }];
    //
    [self.mkDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mkUserImageView.mas_right).offset(10*KDeviceScale);
        make.top.equalTo(self.mkUserLabel.mas_bottom).offset(30*KDeviceScale);
        make.right.equalTo(self.mkDetailLabel.superview.mas_right).offset(16*KDeviceScale);
    }];
    
#pragma mark - 更新新布局
    [self.mkSexAge mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(60 * KDeviceScale));
        
        make.height.equalTo(@(22 * KDeviceScale));
        
        make.left.equalTo(self.mkUserImageView.mas_right).offset(10*KDeviceScale);
        
        make.centerY.equalTo(self.mkUserImageView.mas_centerY).offset(4*KDeviceScale);
        
    }];
    
    [self.mkArea mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.greaterThanOrEqualTo(@(60 * KDeviceScale));
        
        make.height.equalTo(@(22 * KDeviceScale));
        
        make.left.equalTo(self.mkSexAge.mas_right).offset(8*KDeviceScale);
        
        make.centerY.equalTo(self.mkUserImageView.mas_centerY).offset(4*KDeviceScale);
        
    }];
    
    [self.mkConstellationLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(60 * KDeviceScale));
        
        make.height.equalTo(@(22 * KDeviceScale));
        
        make.left.equalTo(self.mkArea.mas_right).offset(8*KDeviceScale);
        
        make.centerY.equalTo(self.mkUserImageView.mas_centerY).offset(4*KDeviceScale);
        
    }];

}
- (void)addOherView{
    self.mkMultiBtnView.alpha = 1;
//    self.mkBanerView.alpha = 1;
}

- (MKBorderView *)mkMultiBtnView{
    
    if (!_mkMultiBtnView) {
        
        _mkMultiBtnView = [[MKBorderView alloc]init];
        
        _mkMultiBtnView.layer.cornerRadius = 4;
        // 阴影颜色
        _mkMultiBtnView.layer.shadowColor = [UIColor blackColor].CGColor;
        // 阴影偏移，默认(0, -3)
        _mkMultiBtnView.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
        _mkMultiBtnView.layer.shadowOpacity = 0.5;
        // 阴影半径，默认3
        _mkMultiBtnView.layer.shadowRadius = 20;
        
        _mkMultiBtnView.clipsToBounds = YES;
        
        [self addSubview:_mkMultiBtnView];
        
        [_mkMultiBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(10*KDeviceScale));
            make.right.equalTo(@(-10*KDeviceScale));
            make.height.equalTo(@(67*KDeviceScale));
            make.top.mas_equalTo(_mkFansNumView.mas_bottom).offset(20*KDeviceHeightScale);
        }];
    }
    return _mkMultiBtnView;
}
//- (MKBanner *)mkBanerView{UIButton
- (UIButton *)mkBanerView{
    if (!_mkBanerView) {
        
        _mkBanerView = [[UIButton alloc]init];
        [_mkBanerView setImage:KIMG(@"banner") forState:UIControlStateNormal];
        [self addSubview:_mkBanerView];
        
        [_mkBanerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(0*KDeviceScale));
            make.right.equalTo(@(-0*KDeviceScale));
            make.height.equalTo(@(84*KDeviceScale));
            make.top.mas_equalTo(_mkMultiBtnView.mas_bottom).offset(10*KDeviceHeightScale);
        }];
        [_mkBanerView addAction:^(UIButton *btn) {
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
    }
    return _mkBanerView;
}
- (UIButton *)mkEditorBtn{
    
    if (!_mkEditorBtn) {
        
        _mkEditorBtn = [[UIButton alloc]init];
        
        [_mkEditorBtn setImage:[UIImage imageNamed:@"white_editpersoninfo"] forState:UIControlStateNormal];
        
        [_mkEditorBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        
        [self addSubview:_mkEditorBtn];
        [_mkEditorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10*KDeviceScale);
            make.centerY.equalTo(self.mkUserLabel.mas_centerY).offset(0);
            make.width.height.equalTo(@(50 *KDeviceScale));
        }];
    }
    return _mkEditorBtn;
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _loginBtn.layer.cornerRadius = 14;
        _loginBtn.layer.masksToBounds = 1;
        @weakify(self)
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if(![MKTools mkLoginIsYESWith:[self getCurrentVC]]) {
                return;
            }
        }];
        _loginBtn.hidden = YES;
    }
    return _loginBtn;
}
- (UILabel *)loginLab {
    if (!_loginLab) {
        _loginLab = UILabel.new;
        _loginLab.textColor = UIColor.whiteColor;
        _loginLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
        _loginLab.text = @"登录后获得更多精彩内容哦~";
        _loginLab.hidden = YES;
    }
    return _loginLab;
}
-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIView *)topLineView {
    if(_topLineView == nil) {
        _topLineView = UIView.new;
        _topLineView.backgroundColor = HEXCOLOR(0xF7F7F7);
    }
    return  _topLineView;
}

@end
