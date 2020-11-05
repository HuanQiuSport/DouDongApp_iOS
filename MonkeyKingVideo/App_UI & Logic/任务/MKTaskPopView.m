//
//  MKTaskPopView.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/29.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKTaskPopView.h"
#import "MKTaskVerticalView.h"
@interface MKTaskPopView()
{
    NSString *parameter;
}
@property(nonatomic,strong)UIView * bgView ;
@property(nonatomic,strong)UIButton * closeBtn ;
@property(nonatomic,strong)UIImageView * vipImgView ;
@property(nonatomic,strong)UIButton * openVipBtn ;

@property(nonatomic,strong) MKTaskVerticalView *taskVerticalView;

@end
@implementation MKTaskPopView

- (instancetype)initWithFrame:(CGRect)frame WithParameter:(NSString *)par{
    self = [super initWithFrame:frame];
    if (self) {
        parameter = par;
        [self creatSubView];
        [self showAlertView];
    }
    return self;
}

#pragma mark -- 事件
//显示
-(void)showAlertView{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.bgView.transform = CGAffineTransformScale(self.bgView.transform, 1000, 1000);
//        self.backgroundColor = [UIColor colorWithString:@"000000" alpha:0.40];
    } completion:^(BOOL finished) {
        
    }];
}

//隐藏
-(void)removeAlertView{
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
           self.bgView.transform = CGAffineTransformScale(self.bgView.transform, 0.001, 0.001);
//           self.backgroundColor = [UIColor colorWithString:@"000000" alpha:0];
       } completion:^(BOOL finished) {
           [self removeFromSuperview];
       }];
}

-(void)openVipAction{
//    [ToolTipView showMessage:@"点击：开通会员" offset:-15];
    self.popblock();
    [self removeAlertView] ;
}

#pragma mark -- UI
-(void)creatSubView{
    self.backgroundColor = [UIColor clearColor];
    self.layer.backgroundColor = RGBA_COLOR(0, 0, 0, 0.7).CGColor;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAlertView)]];
//    self.bgView.backgroundColor = [UIColor redColor];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.closeBtn];
    [self.bgView addSubview:self.vipImgView];
    [self.bgView addSubview:self.openVipBtn];
    
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0,49, SCREEN_W, SCREEN_H/2)];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.transform = CGAffineTransformScale(_bgView.transform, 0.001, 0.001);
    }
    return _bgView;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W-KDeviceScale*57, KDeviceScale*60, 36, 36)];
        [_closeBtn setImage:KIMG(@"登录注册关闭@3x") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(removeAlertView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn ;
}

-(UIImageView *)vipImgView{
    if (!_vipImgView) {
        _vipImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_task_baoxiang"]];
        _vipImgView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W-20) ;
        NSString *text = [NSString stringWithFormat:@"%@抖币",parameter];

        NSInteger fontSize1 = 42; // 金币数量
        NSInteger fontSize2 = 18; // 标题
        CGFloat fontRatio = 0.3;//基线偏移比率

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,_vipImgView.bounds.size.height - KDeviceScale*80, SCREEN_W, 60)];
        label.textAlignment = NSTextAlignmentCenter;
        [_vipImgView addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.vipImgView.mas_bottom).offset(-(21*KDeviceScale));
//            make.left.equalTo(_bgView).offset(0);
//            make.right.equalTo(_bgView).offset(0);
//        }];
        label.text = text;

        NSMutableAttributedString *attributedStringM = [[NSMutableAttributedString alloc] initWithString:text];

        [attributedStringM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize2] range:NSMakeRange(text.length - 2, 2)];
        [attributedStringM addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 2, 2)];

        [attributedStringM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize1] range:NSMakeRange(0, text.length - 2)];
        [attributedStringM addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(255,235,189) range:NSMakeRange(0, text.length - 2)];

    //    [attributedStringM addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize2] range:NSMakeRange(text.length - 3, 3)];
    //    [attributedStringM addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 3, 3)];

        //不同大小的文字水平中部对齐(默认是底部对齐)
        [attributedStringM addAttribute:NSBaselineOffsetAttributeName value:@(fontRatio * (fontSize1 - fontSize2)) range:NSMakeRange(text.length - 2, 2)];

        label.attributedText = attributedStringM;

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0,_vipImgView.bounds.size.height - KDeviceScale*110, SCREEN_W, 60)];//UILabel.new;
        [_vipImgView addSubview:lab];
//        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(label.mas_top).offset(8);
//            make.left.equalTo(_bgView).offset(0);
//            make.right.equalTo(_bgView).offset(0);
//        }];
        lab.text = @"恭喜您获得";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:26];
        lab.textColor = RGBCOLOR(255,235,189);
    }
    return _vipImgView;
}

-(UIButton *)openVipBtn{
    if (!_openVipBtn) {
        _openVipBtn = [[UIButton alloc]initWithFrame:CGRectMake(KDeviceScale*57, SCREEN_H/2-42, SCREEN_W - (KDeviceScale*57)*2, 42)];
        _openVipBtn.backgroundColor = RGBCOLOR(255,125,0);
        [_openVipBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _openVipBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_openVipBtn setTitle:@"邀请好友狂赚37.6w抖币" forState:UIControlStateNormal];
        _openVipBtn.layer.cornerRadius = 21;
        _openVipBtn.layer.masksToBounds = 1;
        [_openVipBtn addTarget:self action:@selector(openVipAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openVipBtn ;
}


-(MKTaskVerticalView *)taskVerticalView {
    if(_taskVerticalView == nil) {
        _taskVerticalView = [[MKTaskVerticalView alloc] initWithFrame:CGRectZero];
    }
    return  _taskVerticalView;
}

@end
