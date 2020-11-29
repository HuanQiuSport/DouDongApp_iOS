//
//  InfoTBVCell.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "InfoTBVCell.h"
#import <YYKit/YYLabel.h>
#import "MKSingeUserCenterVC.h"
@interface InfoTBVCell ()

@property(nonatomic,copy)MKDataBlock actionBlock;

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)YYLabel *content;



@end

@implementation InfoTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    InfoTBVCell *cell = (InfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:@"InfoTBVCell"];
    if (!cell) {
        cell = [[InfoTBVCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"InfoTBVCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return SCALING_RATIO(55);
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:MKChildCommentModel.class]) {
        self.childCommentModel = (MKChildCommentModel *)model;
//        [self.LikeBtn setThumbWithSelected:self.childCommentModel.isPraise.boolValue thumbNum:self.childCommentModel.praiseNum.integerValue animation:NO];
        [self.icon sd_setImageWithURL:[NSURL URLWithString:self.childCommentModel.headImg]
                     placeholderImage:[UIImage animatedGIFNamed:@"用户头像"]];
        self.heartIcon.image = KIMG(self.childCommentModel.isPraise.boolValue ? @"喜欢-红心":@"喜欢-白心");
        self.countLab.text = [NSString stringWithFormat:@"%d",self.childCommentModel.praiseNum.intValue];

        self.name.text = [NSString stringWithFormat:@"@%@",self.childCommentModel.nickname];
        self.supportBtn.userInteractionEnabled = 1;
        self.vipImageView.hidden = YES; //  ![self.childCommentModel.isVip boolValue];
        NSString *replyString = self.childCommentModel.toReplyUserName.length ? @"回复 " : @"";
        NSString *nameString = self.childCommentModel.toReplyUserName.length ? [NSString stringWithFormat:@"%@:",self.childCommentModel.toReplyUserName] : @"";
        NSString *contentString = self.childCommentModel.content;
        NSString *dateString = self.childCommentModel.commentDate;
        NSString *string = [NSString stringWithFormat:@"%@%@%@ %@",replyString,nameString,contentString,dateString];
        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange replyRange = [string rangeOfString:replyString];
        NSRange nameRange = [string rangeOfString:nameString];
        NSRange contentRange = [string rangeOfString:contentString];
        NSRange dateRange = [string rangeOfString:dateString];
        [textString setColor:HEXCOLOR(0x8391af) range:replyRange];
        [textString setColor:HEXCOLOR(0x8391af) range:nameRange];
        [textString setFont:[UIFont systemFontOfSize:12] range:replyRange];
        [textString setFont:[UIFont systemFontOfSize:12] range:nameRange];
        [textString setColor:HEXCOLOR(0x101010) range:contentRange];
        [textString setColor:HEXCOLOR(0x8391af) range:dateRange];
        [textString setFont:[UIFont systemFontOfSize:12] range:contentRange];
        [textString setFont:[UIFont systemFontOfSize:12] range:dateRange];
        self.content.attributedText = textString;
        self.childCommentModel.contentShow = string;
//        [UIView cornerCutToCircleWithView:self.imageView
//                          AndCornerRadius:SCALING_RATIO(30 / 2)];
    }
}

-(void)action:(MKDataBlock)actionBlock{
    self.actionBlock = actionBlock;
}
//点赞/取消点赞操作
- (void)likeBtnClickAction:(RBCLikeButton *)sender{
    if (self.actionBlock) {
        self.actionBlock(@{
            @"sender":sender,
            @"model":self.childCommentModel
                         });
    }
}
#pragma mark —— lazyLoad
//-(RBCLikeButton *)LikeBtn{
//    if (!_LikeBtn) {
//        _LikeBtn = [[RBCLikeButton alloc]initWithFrame:CGRectZero type:RBCLikeButtonTypeImageTop];
//        [_LikeBtn setImage:KIMG(@"喜欢-白心")
//          forState:UIControlStateNormal];
//        [_LikeBtn setImage:KIMG(@"喜欢-红心")
//           forState:UIControlStateSelected];
////        _LikeBtn.layer.cornerRadius = SCALING_RATIO(55 / 4);
////        _LikeBtn.layer.borderColor = kGrayColor.CGColor;
////        _LikeBtn.layer.borderWidth = 1;
//        _LikeBtn.thumpNum = 0;
//        _LikeBtn.adjustsImageWhenHighlighted = 1;
//        [_LikeBtn addTarget:self
//                     action:@selector(likeBtnClickAction:)
//           forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_LikeBtn];
//        [_LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.offset(SCALING_RATIO(13+55/2+13));
//            make.height.offset(SCALING_RATIO(55/2));
//            make.right.offset(0);
//            make.centerY.equalTo(self.icon);
//        }];
//    }return _LikeBtn;
//}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = UIImageView.new;
        _icon.layer.cornerRadius = 15;
        _icon.layer.masksToBounds = 1;
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(65);
            make.height.width.offset(30);
            make.top.offset(0);
        }];
        _icon.userInteractionEnabled = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerIconClick)];
        [_icon addGestureRecognizer:tap];
    }
    return _icon;
}
- (void)headerIconClick {
    if (self.headerBlock) {
        self.headerBlock(@{@"videoid":self.childCommentModel.userId});
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
- (UILabel *)name {
    if (!_name) {
        _name = UILabel.new;
        _name.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.centerY.mas_equalTo(self.icon.mas_centerY).offset(0);
            make.height.offset(30);
            make.width.mas_lessThanOrEqualTo(150);
        }];
        _name.textColor = RGBCOLOR(52, 135, 255);
    }
    return _name;
}
- (YYLabel *)content {
    if (!_content) {
        _content = YYLabel.new;
        _content.numberOfLines = 0;

        [self.contentView addSubview:_content];
        [_content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_right).offset(10);
            make.right.offset(-46);
            make.top.mas_equalTo(self.name.mas_bottom).offset(-10);
            make.bottom.offset(0);
        }];
    }
    return _content;
}

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
        @weakify(self)
        [[_supportBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.btnBlock) {
                self.btnBlock(self->_supportBtn,self->_countLab,self->_heartIcon);
            }
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
            make.left.equalTo(self.name.mas_right).offset(6*KDeviceScale);
            make.centerY.equalTo(self.name.mas_centerY).offset(0);
        }];
    }
    return _vipImageView;
}
@end
