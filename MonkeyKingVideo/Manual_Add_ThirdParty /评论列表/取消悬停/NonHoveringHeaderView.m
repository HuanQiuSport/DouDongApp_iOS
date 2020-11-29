//
//  NonHoveringHeaderView.m
//  HeaderDemo
//
//  Created by zyd on 2018/6/22.
//  Copyright © 2018年 zyd. All rights reserved.
//

#import "NonHoveringHeaderView.h"
#import "UITableViewHeaderFooterView+Attribute.h"
#import <YYKit/YYLabel.h>
#import "MKSingeUserCenterVC.h"
@interface NonHoveringHeaderView ()

@property(nonatomic,copy)MKDataBlock actionBlock;
@property(nonatomic,strong)UIImageView *headerIMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)YYLabel *contentLab;
@property(nonatomic,strong)RBCLikeButton *LikeBtn;

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)MKFirstCommentModel *firstCommentModel;


@end

@implementation NonHoveringHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                               withData:(id)data{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.result.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
        UIView *backgraoudView = [[UIView alloc]initWithFrame:CGRectZero];
        backgraoudView.backgroundColor = [UIColor clearColor];;
        self.backgroundView = backgraoudView;
        
        if ([data isKindOfClass:MKFirstCommentModel.class]) {
            self.firstCommentModel = (MKFirstCommentModel *)data;
            
            [self.headerIMGV sd_setImageWithURL:[NSURL URLWithString:self.firstCommentModel.headImg]
                               placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
            self.titleStr = [NSString stringWithFormat:@"@%@",self.firstCommentModel.nickname];
            self.contentStr = self.firstCommentModel.content;
            self.titleLab.alpha = 1;
            self.contentLab.alpha = 1;
            
            self.vipImageView.hidden =  YES; // ![self.firstCommentModel.isVip boolValue];
            //            [self.LikeBtn setThumbWithSelected:self.firstCommentModel.isPraise.boolValue thumbNum:self.firstCommentModel.praiseNum.integerValue animation:NO];
            self.heartIcon.image = KIMG(self.firstCommentModel.isPraise.boolValue ? @"喜欢-红心":@"喜欢-白心");
            self.countLab.text = [NSString stringWithFormat:@"%d",self.firstCommentModel.praiseNum.intValue];
        }
    }return self;
}

-(void)resultAction:(UIControl *)sender{
    NSLog(@"%@",sender);
    if (self.actionBlock) {
        self.actionBlock(@{
        @"sender":sender,
        @"model":self.firstCommentModel
                     });//UIControl
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:[self.tableView rectForHeaderInSection:self.section]];
}

-(void)actionBlock:(MKDataBlock)actionBlock{
    self.actionBlock = actionBlock;
}
//点赞/取消点赞操作
- (void)likeBtnClickAction:(RBCLikeButton *)sender{
    if (self.actionBlock) {
        self.actionBlock(@{
            @"sender":sender,
            @"model":self.firstCommentModel
                         });//RBCLikeButton
    }
}
#pragma mark —— lazyLoad
-(UIControl *)result{
    if (!_result) {
        _result = UIControl.new;
        [_result addTarget:self
                    action:@selector(resultAction:)
          forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_result];
        [_result mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _result;
}

-(UIImageView *)headerIMGV{
    if (!_headerIMGV) {
        _headerIMGV = UIImageView.new;
        [self.contentView addSubview:_headerIMGV];
        [_headerIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.equalTo(self.contentView).offset(16);
            make.top.offset(0);
        }];
        _headerIMGV.layer.cornerRadius = 20;
        _headerIMGV.layer.masksToBounds = 1;
        _headerIMGV.userInteractionEnabled = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerIconClick)];
        [_headerIMGV addGestureRecognizer:tap];
    }return _headerIMGV;
}

- (void)headerIconClick {
    if (self.headerBlock) {
        self.headerBlock(@{@"videoid":[NSString stringWithFormat:@"%ld",(long)self.firstCommentModel.userId]});
    }
//    [MKSingeUserCenterVC ComingFromVC:[self getCurrentVC] comingStyle:ComingStyle_PUSH presentationStyle:UIModalPresentationFullScreen requestParams:@{@"videoid":[NSString stringWithFormat:@"%ld",self.firstCommentModel.userId]} success:^(id data) {
//
//    } animated:YES];
}

- (void)contentClick{
    if (self.actionBlock) {
        self.actionBlock(@{
            @"sender":self.result,
            @"model":self.firstCommentModel
                         });//RBCLikeButton
    }
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
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        _titleLab.textColor = RGBCOLOR(52, 135, 255);
        [self.contentView addSubview:_titleLab];
        _titleLab.text = self.titleStr;
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.height.offset(40);
            make.left.equalTo(self.headerIMGV.mas_right).offset(10);
            make.width.mas_lessThanOrEqualTo(200);
        }];
    }return _titleLab;
}

-(YYLabel *)contentLab{
    if (!_contentLab) {
        _contentLab = YYLabel.new;
        _contentLab.numberOfLines = 0;
        NSString *contentString = self.firstCommentModel.content;
        NSString *dateString = self.firstCommentModel.commentDate;
        NSString *string = [NSString stringWithFormat:@"%@  %@",contentString,dateString];
        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange contentRange = [string rangeOfString:contentString];
        NSRange dateRange = [string rangeOfString:dateString];
        [textString setColor:HEXCOLOR(0x101010) range:contentRange];
        [textString setColor:HEXCOLOR(0x999999) range:dateRange];
        [textString setFont:[UIFont systemFontOfSize:12] range:contentRange];
        [textString setFont:[UIFont systemFontOfSize:12] range:dateRange];
        _contentLab.attributedText = textString;
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLab.mas_bottom).offset(-10);
            make.bottom.offset(0);
            make.right.offset(-46);
            make.left.equalTo(self.headerIMGV.mas_right).offset(10);
        }];
        [_contentLab addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentClick)]];
    }return _contentLab;
}

//-(RBCLikeButton *)LikeBtn{
//    if (!_LikeBtn) {
//        _LikeBtn = [[RBCLikeButton alloc]initWithFrame:CGRectZero type:RBCLikeButtonTypeImageTop];
//        [_LikeBtn setImage:KIMG(@"喜欢-白心")
//                  forState:UIControlStateNormal];
//        [_LikeBtn setImage:KIMG(@"喜欢-红心")
//                   forState:UIControlStateSelected];
//        _LikeBtn.thumpNum = 0;
//        [_LikeBtn addTarget:self
//                     action:@selector(likeBtnClickAction:)
//           forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_LikeBtn];
//        [_LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(55 / 2), SCALING_RATIO(55 / 2)));
//            make.width.offset(SCALING_RATIO(13+55/2+13));
//            make.height.offset(SCALING_RATIO(55/2));
//            make.right.offset(0);
//            make.centerY.mas_equalTo(self.headerIMGV.mas_centerY).offset(0);
//        }];
//    }return _LikeBtn;
//}

- (UIImageView *)heartIcon {
    if (!_heartIcon) {
        _heartIcon = UIImageView.new;
        _heartIcon.userInteractionEnabled = 1;
        [self.contentView addSubview:_heartIcon];
        [_heartIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.width.height.offset(30);
            make.right.offset(-12);
        }];
    }
    return _heartIcon;
}
//131 145 175
- (UILabel *)countLab {
    if (!_countLab) {
        _countLab = UILabel.new;
        _countLab.textColor = RGBCOLOR(131, 145, 175);
        _countLab.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_countLab];
        [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_heartIcon.mas_centerX).offset(0);
            make.top.mas_equalTo(_heartIcon.mas_bottom).offset(-3);
            make.height.offset(18);
            make.width.offset(18+14*2);
        }];
        _countLab.textAlignment = NSTextAlignmentCenter;
    }
    return _countLab;
}
- (UIButton *)supportBtn {
    if (!_supportBtn) {
        _supportBtn = UIButton.new;
        [self.contentView addSubview:_supportBtn];
        [_supportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.offset(0);
            make.width.offset(18+14*2);
            make.height.offset(36+9);
        }];
    }
    return _supportBtn;
}

- (UIImageView *)vipImageView
{
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc]init];
        _vipImageView.image = KIMG(@"icon_userVIP");
        [self.contentView addSubview:_vipImageView];
        
        [_vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(19 *KDeviceScale));
            make.height.equalTo(@(17 *KDeviceScale));
            make.left.equalTo(self.titleLab.mas_right).offset(6*KDeviceScale);
            make.centerY.equalTo(self.titleLab.mas_centerY).offset(0);
        }];
    }
    return _vipImageView;
}

@end
