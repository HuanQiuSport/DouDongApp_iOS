//
//  MKShareView.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKShareView.h"
#import "MKImageBtnVIew.h"
@interface MKShareView ()

@property(nonatomic,strong) UIView *bgView; /* 背景view */
//@property(nonatomic,strong) UIButton *linkBtn; /* 复制链接 */
@property(nonatomic,strong) MKImageBtnVIew *linkBtn; /* 复制链接 */

@property(nonatomic,strong) MKImageBtnVIew *saveBtn; /* 保存分享 */


@property(nonatomic,strong) UIButton *closeBtn; /* 关闭 */
@property(nonatomic,strong) UIImageView *qrImge; /* 二维码 */
@property(nonatomic,strong) UIImageView *viedoImge; /* 视频首帧 */
@property(nonatomic,strong) NSString *viedoStr; /* 视频首帧地址 */
@property(nonatomic,strong) NSString *inviteCode; /* 邀请码 */
@property(nonatomic,strong) NSString *shareLink; /* 分享链接 */
@property(nonatomic,strong) UILabel *inviteLab; /* 邀请码容器 */

// 截图
@property(nonatomic,strong) UIView *flashView; /* 截图背景view */

@property(nonatomic,strong) UIView *tipView;
@property(nonatomic,strong) UIButton *iKnowBtn;


@property(nonatomic,strong) UIImageView *shareTipImageView;
@end

@implementation MKShareView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB_COLOR(0x21 , 0x1B,0x45);
        self.flashView = [[UIView alloc] initWithFrame:frame];
        self.flashView.backgroundColor = RGB_COLOR(0x21 , 0x1B,0x45);
        UIImageView *bottomBgimageView = UIImageView.new;
        [self.flashView addSubview:bottomBgimageView];
        bottomBgimageView.image = KIMG(@"white_share_bg");
        [bottomBgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        [self addSubview:self.flashView];
        
    }
    return self;
}
// 显示
- (void)showWithViedo:(NSString *)imgurl AndInviteInfo:(NSDictionary *)inviteDic{
    UIWindow *window = getMainWindow();
    [window addSubview:self];
    WeakSelf
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.viedoImge sd_setImageWithURL:[NSURL URLWithString:imgurl.stringByRemovingPercentEncoding]];
        });
    });
    
    if (inviteDic != nil) {
        _inviteCode = inviteDic[@"inviteCode"];
        _shareLink = inviteDic[@"url"];
    }
    //
    [self.flashView addSubview:self.saveBtn];
    [self.flashView addSubview:self.bgView];
    [self.flashView addSubview:self.linkBtn];
    [self.flashView addSubview:self.closeBtn];
    
    @weakify(self)
    // 二维码
    [UIView animateWithDuration:.3f
                     animations:^{
        @strongify(self)
        CGRect frame = self.bgView.frame;
        frame.origin.y =  0;
        self.bgView.frame = frame;
    }];
    
    // 按钮 51
    [UIButton animateWithDuration:.3f
                     animations:^{
        @strongify(self)
        CGRect saveBtnframe = self.saveBtn.frame;
        CGRect linkBtnframe = self.linkBtn.frame;
        CGRect closeBtnframe = self.closeBtn.frame;
        
        saveBtnframe.origin.y =  SCALING_RATIO(626);
        self.saveBtn.frame = saveBtnframe;
        
        linkBtnframe.origin.y =  SCALING_RATIO(626);
        self.linkBtn.frame = linkBtnframe;
        
        closeBtnframe.origin.y =  51;
        self.closeBtn.frame = closeBtnframe;
    }];
}

- (void)removeChildView{
    @weakify(self)
    [UIView animateWithDuration:.3f
                     animations:^{
        @strongify(self)
        CGRect frame = self.bgView.frame;
        frame.origin.y = -[UIScreen mainScreen].bounds.size.height*0.673;
        self.bgView.frame = frame;
         // 按钮
        CGRect saveBtnframe = self.saveBtn.frame;
        saveBtnframe.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.saveBtn.frame = saveBtnframe;
        
        CGRect linkBtnframe = self.linkBtn.frame;
        linkBtnframe.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.linkBtn.frame = linkBtnframe;
        
        CGRect closeBtnframe = self.closeBtn.frame;
        closeBtnframe.origin.y = -26;
        self.closeBtn.frame = closeBtnframe;
        
        
    } completion:^(BOOL finished) {
        @strongify(self)
        if (finished) {
            
            UIImageView *imgev = (UIImageView *)[self viewWithTag:1000];
            imgev.image = KIMG(@"bg_share");
            
            
            self.saveBtn.hidden = NO;
            self.linkBtn.hidden = NO;
            self.shareTipImageView.hidden = NO;
            self.closeBtn.hidden = NO;
//            self.inviteLab.textColor = kWhiteColor;
            self.tipView.hidden = YES;
            self.iKnowBtn.hidden = YES;
            
            [self removeFromSuperview];
            if (self.isPlaying) {
                self.shareblock(@"play");
            } else {
                self.shareblock(@"pause");
            }
            
        }
    }];
}

#pragma mark - lazy loading
- (UIView *)bgView{
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -[UIScreen mainScreen].bounds.size.height*0.673 , SCREEN_W, [UIScreen mainScreen].bounds.size.height*0.67)];
        // 这里不能用mas因为要从外面开始布局
//        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 69, 190, 69));
//        }];
        
        // 背景
        UIImageView *imgev = UIImageView.new;
        imgev.tag = 1000;
        [_bgView addSubview:imgev];
        [imgev mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(-20, 0, 0, 0));
        }];
        imgev.image = KIMG(@"share_content_bg");
        
        [_bgView addSubview:self.shareTipImageView];
        [self.shareTipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_bgView.mas_centerX);
            make.top.equalTo(imgev.mas_bottom).offset(-5);
        }];
        
        
        // 视频首帧
        if (!_viedoImge) {
            _viedoImge = UIImageView.new;
            _viedoImge.contentMode = UIViewContentModeScaleAspectFill;
            // 设置这个裁剪掉uiimage超出区域部分
            _viedoImge.clipsToBounds = true;
            [_bgView addSubview:_viedoImge];
            [_viedoImge mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_bgView);
                make.left.equalTo(_bgView).offset(103);
                make.right.equalTo(_bgView).offset(-103);
                make.top.equalTo(_bgView).offset(26);
                make.height.equalTo(_bgView).multipliedBy(0.472);
            }];
        }
        
        // 二维码
        if (!_qrImge) {
            _qrImge = UIImageView.new;
            WeakSelf
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.qrImge.image = [UIImage createNonInterpolatedUIImageFormString:weakSelf.shareLink withSize:200];
                });
            });
            _qrImge.contentMode = UIViewContentModeScaleAspectFit;
            // 设置这个裁剪掉uiimage超出区域部分
            _qrImge.clipsToBounds = true;
            [_bgView addSubview:_qrImge];
            [_qrImge mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_viedoImge.mas_bottom).offset(40);
                make.left.equalTo(_bgView).offset(45);
                make.bottom.equalTo(_bgView.mas_bottom).offset(-89);
                make.right.equalTo(_bgView).offset(-45);
            }];
        }
        
        // 邀请码
        if (!_inviteLab) {
            _inviteLab = UILabel.new;
            [_bgView addSubview:_inviteLab];
            [_inviteLab mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(_bgView).offset(0);
//                make.right.equalTo(_bgView).offset(0);
                make.centerX.equalTo(_bgView.mas_centerX);
                make.height.equalTo(@(30));
                make.top.equalTo(_qrImge.mas_bottom).offset(8);
                
            }];
            _inviteLab.layer.masksToBounds = true;
            _inviteLab.layer.cornerRadius = 15;
            _inviteLab.textAlignment = NSTextAlignmentCenter;
            _inviteLab.textColor = kWhiteColor;
            _inviteLab.backgroundColor = HEXCOLOR(0xF27D5A);
            _inviteLab.font = [UIFont systemFontOfSize:19];
            _inviteLab.text = [NSString stringWithFormat:@"      邀请码: %@      ",_inviteCode];
        }
        
        
    }return _bgView;
}
- (MKImageBtnVIew *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[MKImageBtnVIew alloc] initWithFrame:CGRectZero];
        
        _saveBtn.width = SCALING_RATIO(126);
        _saveBtn.height = 70;
        _saveBtn.x = SCALING_RATIO(204);
        _saveBtn.y = [UIScreen mainScreen].bounds.size.height;
        
        _saveBtn.mkImageView.image = KIMG(@"share_save_save");
        _saveBtn.mkTitleLable.text = @"保存图片分享";
        
//        _saveBtn.frame = CGRectMake(SCALING_RATIO(204), [UIScreen mainScreen].bounds.size.height, SCALING_RATIO(126), 32);
//        _saveBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:_saveBtn.frame.size]];
////        [_loginBtn setBackgroundImage:KIMG(@"login_gradualColor") forState:UIControlStateNormal];
//        [_saveBtn setTitle:@"  保存图片分享" forState:UIControlStateNormal];
//        _saveBtn.adjustsImageWhenHighlighted = 0;
//        _saveBtn.layer.cornerRadius = 32/2;
//        _saveBtn.layer.masksToBounds = 1;
//        [_saveBtn setImage:KIMG(@"icon_save") forState:UIControlStateNormal];
//        [_saveBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        @weakify(self)
        [[_saveBtn.mkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self screenshot];
        }];
    }return _saveBtn;
}
- (MKImageBtnVIew *)linkBtn{
    if (!_linkBtn) {
        _linkBtn = [[MKImageBtnVIew alloc] initWithFrame:CGRectZero];
        _linkBtn.width = SCALING_RATIO(126);
        _linkBtn.height = 70;
        _linkBtn.x = SCALING_RATIO(47);
        _linkBtn.y = [UIScreen mainScreen].bounds.size.height;
        
        _linkBtn.mkImageView.image = KIMG(@"sahre_link_link");
        _linkBtn.mkTitleLable.text = @"复制链接分享";
        
//        _linkBtn.frame = CGRectMake(SCALING_RATIO(47), [UIScreen mainScreen].bounds.size.height, SCALING_RATIO(126), 32);
//        _linkBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:_linkBtn.frame.size]];
//        [_loginBtn setBackgroundImage:KIMG(@"login_gradualColor") forState:UIControlStateNormal];
//        [_linkBtn setTitle:@"  复制链接分享" forState:UIControlStateNormal];
//        [_linkBtn setImage:KIMG(@"icon_link") forState:UIControlStateNormal];
//        _linkBtn.adjustsImageWhenHighlighted = 0;
//        _linkBtn.layer.cornerRadius = 32/2;
//        _linkBtn.layer.masksToBounds = 1;
//        [_linkBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        _linkBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        @weakify(self)
        [[_linkBtn.mkButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self successCopy];
        }];
    }return _linkBtn;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        _closeBtn.frame = CGRectMake( [[UIScreen mainScreen] bounds].size.width - 9 - SCALING_RATIO(60) , -26, SCALING_RATIO(60), 26);
        _closeBtn.backgroundColor = UIColor.clearColor;
//        [_closeBtn setTitle:@"  取消" forState:UIControlStateNormal];
        [_closeBtn setImage:KIMG(@"share_close") forState:UIControlStateNormal];
        _closeBtn.adjustsImageWhenHighlighted = 0;
        _closeBtn.layer.cornerRadius = 26/2;
        _closeBtn.layer.masksToBounds = 1;
        [_closeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        @weakify(self)
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self removeChildView];
        }];
    }return _closeBtn;
}
#pragma mark - ButtonAction
- (void)successCopy{
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.shareLink;//这个需要接口调动态数据，接口尚未开发成功
    [[MKTools shared] showMBProgressViewOnlyTextInView:self text:@"复制成功，赶快去分享吧" dissmissAfterDeley:2.0f];
    [self performSelector:@selector(exit) withObject:nil afterDelay:2.5f];
}
- (void)exit
{
    [self removeChildView];
}

- (void)cancleButtonAction{
    [self removeChildView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
//    NSLog(@"view = %@", touch.view);
    // 防止误操作点击到标题收起分享页面
    if (touch.view == self.flashView) {
        [self removeChildView];
    }
}


- (void)screenshot{
    WeakSelf
    [ECAuthorizationTools checkAndRequestAccessForType:ECPrivacyType_Photos
                                          accessStatus:^id(ECAuthorizationStatus status,
                                                           ECPrivacyType type) {
        
        // status 即为权限状态，
        //状态类型参考：ECAuthorizationStatus
//        NSLog(@"%lu",(unsigned long)status);
        if (status == ECAuthorizationStatus_Authorized) {
//            NSLog(@"系统相册可用");
            UIGraphicsBeginImageContext(weakSelf.bgView.frame.size);
            [weakSelf.bgView.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image= UIGraphicsGetImageFromCurrentImageContext();

            UIGraphicsEndImageContext();
            UIImageView *imaView = [[UIImageView alloc] initWithImage:image];
            imaView.frame = weakSelf.bgView.frame;
            //保存到相册
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);


            // 动画
            NSArray *myArray = [NSArray arrayWithObjects:[self scale:[NSNumber numberWithFloat:1.0f] orgin:[NSNumber numberWithFloat:0] durTimes:.2f Rep:1],[self opacityForever_Animation:0.3], nil];
            [self.flashView.layer addAnimation:[self groupAnimation:myArray durTimes:.5f Rep:1] forKey:nil];
            return nil;
        }else{
//            NSLog(@"系统相册不可用:%lu",(unsigned long)status);
            
//            [NSObject showSYSAlertViewTitle:@"提示"
//                                    message:@"保存图片需要过去您的相册权限,请前往设置打开"
//                            isSeparateStyle:NO
//                                btnTitleArr:@[@"确定"]
//                             alertBtnAction:@[@""]
//                                   targetVC:[[MKTools shared] getCurrentVC]
//                               alertVCBlock:^(id data) {
//                //DIY
//            }];
            [MBProgressHUD wj_showError:@"保存图片需要过去您的相册权限,请前往设置打开"];
            return nil;
        }
    }];
    
}

#pragma mark === 永久闪烁的动画 ======

- (CABasicAnimation *)opacityForever_Animation:(float)time

{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。

    animation.fromValue = [NSNumber numberWithFloat:1.0f];

    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。

    animation.autoreverses = YES;

    animation.duration = time;

    animation.repeatCount = 1;

    animation.removedOnCompletion = NO;

    animation.fillMode = kCAFillModeForwards;

    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。

    return animation;

}
#pragma mark =====缩放-=============

-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes

{

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];

    animation.fromValue = Multiple;

    animation.toValue = orginMultiple;

    animation.autoreverses = YES;

    animation.repeatCount = 1;

    animation.duration = time;//不设置时候的话，有一个默认的缩放时间.

    animation.removedOnCompletion = NO;

    animation.fillMode = kCAFillModeForwards;

    return  animation;

}

 

#pragma mark =====组合动画-=============

-(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes

{

    CAAnimationGroup *animation = [CAAnimationGroup animation];

    animation.animations = animationAry;

    animation.duration = time;

    animation.removedOnCompletion = NO;

    animation.repeatCount = repeatTimes;

    animation.fillMode = kCAFillModeForwards;

    return animation;

}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    WeakSelf
    NSString *message = nil;
    if (!error) {
        message = @"成功保存到相册";
        [[MKTools shared] showMBProgressViewOnlyTextInView:self text:@"成功保存到相册" dissmissAfterDeley:2.0f];
//        [self performSelector:@selector(exit) withObject:nil afterDelay:2.5f];
//        UIImageView *imgev = UIImageView.new;
//        [_bgView addSubview:imgev];
//        [imgev mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(UIEdgeInsetsMake(-20, 0, 0, 0));
//        }];
//        imgev.image = image;
//        _inviteLab.textColor = kBlackColor;
        UIImageView *imgev = (UIImageView *)[self viewWithTag:1000];
        imgev.image = KIMG(@"bg_share");
        [weakSelf saveSuccessDrawNewView];

    }else
    {
        message = [error description];
     }
}
// 移除原来底部的按钮新增一个【我知道了】按钮
- (void)saveSuccessDrawNewView
{
    self.saveBtn.hidden = YES;
    self.linkBtn.hidden = YES;
    self.shareTipImageView.hidden = YES;
    
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                            SCREEN_H - 123  - SCALING_RATIO(87),
                                                                            SCREEN_W,
                                                                            SCALING_RATIO(87))];
//        _tipView.backgroundColor = kRedColor;
        [self.flashView addSubview:_tipView];
        
        [_tipView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(SCREEN_W));
            make.height.equalTo(@(87));
            make.centerX.equalTo(self.flashView.mas_centerX).offset(0);
            make.top.equalTo(self.bgView.mas_bottom).offset(10);
        }];
        
        UILabel *tiplab = UILabel.new;
        [_tipView addSubview:tiplab];
        [tiplab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_tipView);
        }];
        tiplab.text = @"已保存到相册";
        tiplab.textAlignment = NSTextAlignmentCenter;
        tiplab.textColor = kWhiteColor;
        tiplab.font = [UIFont systemFontOfSize:17];
        
        UIView *line = UIView.new;
        line.backgroundColor = UIColor.clearColor;
        [_tipView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_tipView);
            make.left.equalTo(_tipView).offset(24);
            make.right.equalTo(_tipView).offset(-24);
            make.top.equalTo(tiplab.mas_bottom).offset(4);
            make.height.equalTo(@(1));
        }];
         
        
        UILabel *tiplab2 = UILabel.new;
        [_tipView addSubview:tiplab2];
        [tiplab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tipView);
            make.right.equalTo(_tipView);
            make.top.equalTo(line.mas_bottom).offset(8);
        }];
        tiplab2.text = @"如要分享给微信好友，请发送保存的图片来分享";
        tiplab2.textAlignment = NSTextAlignmentCenter;
        tiplab2.textColor = kWhiteColor;
        tiplab2.font = [UIFont systemFontOfSize:15];
        
        _iKnowBtn = UIButton.new;
        [self.flashView addSubview:_iKnowBtn];
        _iKnowBtn.frame = CGRectMake(SCALING_RATIO(120),SCREEN_H - 130, kScreenWidth-SCALING_RATIO(240), 40);
        
        [_iKnowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.flashView.mas_centerX).offset(0);
            make.width.equalTo(@(130));
            make.height.equalTo(@(40));
            make.top.equalTo(_tipView.mas_bottom).offset(0);
        }];
        
        
        _iKnowBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:_iKnowBtn.frame.size]];
        //        [_loginBtn setBackgroundImage:KIMG(@"login_gradualColor") forState:UIControlStateNormal];
        [_iKnowBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        _iKnowBtn.adjustsImageWhenHighlighted = 0;
        _iKnowBtn.layer.cornerRadius = 40/2;
        _iKnowBtn.layer.masksToBounds = 1;
        [_iKnowBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _iKnowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        @weakify(self)
        [[_iKnowBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self removeChildView];
        }];
    }
    _tipView.hidden = NO;
    _iKnowBtn.hidden = NO;
    _closeBtn.hidden = YES;
    
//    WeakSelf
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//
//        });
//    });
    
}
-(UIImageView *)shareTipImageView {
    if(_shareTipImageView == nil) {
        _shareTipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_coin_tip"]];
    }
    return _shareTipImageView;
}

//- (MKImageBtnVIew *)mkZanView{
//    if (!_mkZanView) {
//        _mkZanView = [[MKImageBtnVIew alloc] initWithFrame:CGRectZero];
//        _mkZanView.mkImageView.image = KIMG(@"喜欢-未点击");
//        _mkZanView.mkTitleLable.text = @"点赞";
//    }return _mkZanView;
//}
//
//- (MKImageBtnVIew *)mkCommentView{
//    if (!_mkCommentView) {
//        _mkCommentView = [[MKImageBtnVIew alloc] initWithFrame:CGRectZero];
//        _mkCommentView.mkImageView.image = KIMG(@"信息");
//        _mkCommentView.mkTitleLable.text = @"评论";
//    }return _mkCommentView;
//}

@end
