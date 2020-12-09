//
//  UserInfoTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UserInfoTBVCell.h"

@interface UserInfoTBVCell ()

@end

@implementation UserInfoTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    UserInfoTBVCell *cell = (UserInfoTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UserInfoTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:ReuseIdentifier
                                              marginX:3
                                              marginY:10];
        cell.contentView.backgroundColor = HEXCOLOR(0x242A37);
        [cell shadowCell];
    }return cell;
}

-(void)drawRect:(CGRect)rect{
    self.headPortraitIMGV.alpha = 1;
    self.userNameLab.alpha = 1;
    self.userOtherInfoLab.alpha = 1;
    self.userSignatureLab.alpha = 1;
    self.editIMGV.alpha = 1;
    self.attentionBtn.alpha = 1;
    self.fansBtn.alpha = 1;
    self.likeBtn.alpha = 1;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return isiPhoneX_series() ? (MAINSCREEN_HEIGHT / 4.5) : (MAINSCREEN_HEIGHT / 4);
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:MyVCModel.class]) {
        MyVCModel *myVCModel = (MyVCModel *)model;
        self.userOtherInfoLab.text = [NSString stringWithFormat:@"%@     %@岁     %@",
                                  [NSString ensureNonnullString:myVCModel.area ReplaceStr:@"未知世界"],
                                      [NSString ensureNonnullString:myVCModel.age.stringValue ReplaceStr:@"年龄未知"],
                                  [NSString ensureNonnullString:myVCModel.constellation ReplaceStr:@"未知星座"]];
        self.userSignatureLab.text = [NSString isNullString:myVCModel.remark] ? @"填写个性签名，更容易获得别人关注哦" : myVCModel.remark;
        self.userNameLab.text = [NSString stringWithFormat:@"%@",[NSString ensureNonnullString:myVCModel.nickname ReplaceStr:@"该用户未设置昵称"]];
        [self.headPortraitIMGV sd_setImageWithURL:[NSURL URLWithString:myVCModel.headImage]
                             placeholderImage:KIMG(@"替代头像")];
        [self.attentionBtn setTitle:[NSString stringWithFormat:@"关注 %@",[NSString ensureNonnullString:myVCModel.focusNum.stringValue
                                                                                       ReplaceStr:@"0"]]
                       forState:UIControlStateNormal];
        [self.fansBtn setTitle:[NSString stringWithFormat:@"粉丝 %@",[NSString ensureNonnullString:myVCModel.fansNum.stringValue
                                                                                  ReplaceStr:@"0"]]
                  forState:UIControlStateNormal];
        [self.likeBtn setTitle:[NSString stringWithFormat:@"获赞 %@",[NSString ensureNonnullString:myVCModel.praiseNum.stringValue
                                                                                  ReplaceStr:@"0"]]
                  forState:UIControlStateNormal];
        //更新本地数据库
        MKLoginModel *loginModel = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
        loginModel.nickName = [NSString ensureNonnullString:myVCModel.nickname ReplaceStr:@"该用户未设置昵称"];
        loginModel.area = [NSString ensureNonnullString:myVCModel.area ReplaceStr:@"未知世界"];
        loginModel.age = [NSString ensureNonnullString:myVCModel.age ReplaceStr:@"年龄未知"];
        loginModel.constellation = [NSString ensureNonnullString:myVCModel.constellation ReplaceStr:@"未知星座"];
        loginModel.remark = [NSString ensureNonnullString:myVCModel.remark ReplaceStr:@"填写个性签名，更容易获得别人关注哦"];
        loginModel.headImage = [NSString ensureNonnullString:myVCModel.headImage ReplaceStr:@"替代头像"];
        loginModel.focusNum = [NSString ensureNonnullString:myVCModel.focusNum ReplaceStr:@"0"];
        loginModel.fansNum = [NSString ensureNonnullString:myVCModel.fansNum ReplaceStr:@"0"];
        loginModel.praiseNum = [NSString ensureNonnullString:myVCModel.praiseNum ReplaceStr:@"0"];
        
//        [[MKLoginModel getUsingLKDBHelper] insertToDB:loginModel];
    }
}

-(void)action:(MKDataBlock)actionBlock{
    self.actionBlock = actionBlock;
}
#pragma mark —— 点击事件
-(void)attentionBtnClickEvent:(UIButton *)sender{
//    NSLog(@"关注");
    [NSObject feedbackGenerator];
    @weakify(self)
    [UIView addViewAnimation:sender
             completionBlock:^(id data) {
        @strongify(self)
        if (self.actionBlock) {
            self.actionBlock(sender);
        }
    }];
}

-(void)fansBtnClickEvent:(UIButton *)sender{
//    NSLog(@"粉丝");
    [NSObject feedbackGenerator];
    @weakify(self)
    [UIView addViewAnimation:sender
             completionBlock:^(id data) {
        @strongify(self)
        if (self.actionBlock) {
            self.actionBlock(sender);
        }
    }];
}

-(void)likeBtnClickEvent:(UIButton *)sender{
//    NSLog(@"获赞");
}
#pragma mark —— lazyLoad
-(UIImageView *)headPortraitIMGV{
    if (!_headPortraitIMGV) {
        _headPortraitIMGV = UIImageView.new;
        [self.contentView addSubview:_headPortraitIMGV];
        [_headPortraitIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        [UIView cornerCutToCircleWithView:_headPortraitIMGV
                          AndCornerRadius:25];
    }return _headPortraitIMGV;
}

-(UILabel *)userNameLab{
    if (!_userNameLab) {
        _userNameLab = UILabel.new;
        _userNameLab.font = [UIFont fontWithName:@"Helvetica" size:22];
        _userNameLab.textColor = kWhiteColor;
        [self.contentView addSubview:_userNameLab];
        [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortraitIMGV);
            make.left.equalTo(self.headPortraitIMGV.mas_right).offset(15);
        }];
    }return _userNameLab;
}

-(UILabel *)userOtherInfoLab{
    if (!_userOtherInfoLab) {
        _userOtherInfoLab = UILabel.new;
        _userOtherInfoLab.textColor = kWhiteColor;
        _userOtherInfoLab.font = [UIFont fontWithName:@"PingFangSC-Regular" size:10];
        [self.contentView addSubview:_userOtherInfoLab];
        [_userOtherInfoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameLab.mas_bottom);
            make.left.equalTo(self.userNameLab);
        }];
    }return _userOtherInfoLab;
}

-(UILabel *)userSignatureLab{
    if (!_userSignatureLab) {
        _userSignatureLab = UILabel.new;
        _userSignatureLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
        _userSignatureLab.textColor = kWhiteColor;
        _userSignatureLab.numberOfLines = 1;
        _userSignatureLab.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_userSignatureLab];
        [_userSignatureLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userOtherInfoLab.mas_bottom).offset(15);
            make.left.equalTo(self.userNameLab);
            make.width.equalTo(@(200*1));
        }];
    }return _userSignatureLab;
}

-(UIImageView *)editIMGV{
    if (!_editIMGV) {
        _editIMGV = UIImageView.new;
        _editIMGV.image = KIMG(@"编辑");
        [self.contentView addSubview:_editIMGV];
        [_editIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headPortraitIMGV);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.equalTo(self.contentView).offset(-15);
        }];
    }return _editIMGV;
}

-(FSCustomButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = FSCustomButton.new;
        [_attentionBtn addTarget:self
                          action:@selector(attentionBtnClickEvent:)
                forControlEvents:UIControlEventTouchUpInside];
        _attentionBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_attentionBtn setImage:KIMG(@"关注")
                       forState:UIControlStateNormal];
        _attentionBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium"
                                                        size:13];
        [_attentionBtn setTitleColor:COLOR_RGB(131,
                                               145,
                                               175,
                                               1)
                            forState:UIControlStateNormal];
        _attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(10,
                                                         0,
                                                         0,
                                                         0);
        [self.contentView addSubview:_attentionBtn];
        [_attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userSignatureLab.mas_bottom).offset(25);
            make.left.equalTo(self.contentView).offset(50);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }return _attentionBtn;
}

-(FSCustomButton *)fansBtn{
    if (!_fansBtn) {
        _fansBtn = FSCustomButton.new;
        _fansBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_fansBtn addTarget:self
                     action:@selector(fansBtnClickEvent:)
           forControlEvents:UIControlEventTouchUpInside];
        [_fansBtn setImage:KIMG(@"粉丝")
                  forState:UIControlStateNormal];
        _fansBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium"
                                                   size:13];
        [_fansBtn setTitleColor:COLOR_RGB(131,
                                          145,
                                          175,
                                          1)
                       forState:UIControlStateNormal];
        _fansBtn.titleEdgeInsets = UIEdgeInsetsMake(10,
                                                    0,
                                                    0,
                                                    0);
        [self.contentView addSubview:_fansBtn];
        [_fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userSignatureLab.mas_bottom).offset(25);
            make.centerX.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }return _fansBtn;
}

-(FSCustomButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = FSCustomButton.new;
        _likeBtn.buttonImagePosition = FSCustomButtonImagePositionTop;
        [_likeBtn addTarget:self
                     action:@selector(likeBtnClickEvent:)
           forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn setImage:KIMG(@"获赞")
                  forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium"
                                                   size:13];
        [_likeBtn setTitleColor:COLOR_RGB(131,
                                          145,
                                          175,
                                          1)
                       forState:UIControlStateNormal];
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(10,
                                                     0,
                                                     0,
                                                     0);
        [self.contentView addSubview:_likeBtn];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userSignatureLab.mas_bottom).offset(25);
            make.right.equalTo(self.contentView).offset(-50);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
    }return _likeBtn;
}




@end
