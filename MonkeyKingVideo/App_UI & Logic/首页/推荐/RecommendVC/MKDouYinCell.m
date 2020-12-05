//
//  MKDouYinCell.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKDouYinCell.h"
#import "MKRightBtnView.h"
#import "ZFUtilities.h"
#import "UIView+Extras.h"
#import "GKDoubleLikeView.h"
#import "WPAlertControl.h"
@interface MKDouYinCell()

@end
@implementation MKDouYinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.contentView.backgroundColor = UIColor.blackColor;
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.rightBtnView];
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.mkVipImage];
        [self.contentView addSubview:self.focusBtn];
        [self.contentView addSubview:self.content];
        [self addMasonry];
          }
    return self;
}
- (void)refreshComment:(NSNotification *)noti {
    NSString *string = noti.object;
    NSInteger count = string.integerValue;
    self.videoModel.commentNum = [NSString stringWithFormat:@"%ld",self.rightBtnView.mkCommentView.mkTitleLable.text.integerValue + count];
    self.rightBtnView.mkCommentView.mkTitleLable.text = [NSString stringWithFormat:@"%ld",self.rightBtnView.mkCommentView.mkTitleLable.text.integerValue + count];
}
#pragma mark - setData
- (void)setModel:(MKVideoDemandModel *)model {
    self.videoModel = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[model.videoImg stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:KIMG(@"av")];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[model.headImage stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
    self.mkVipImage.hidden = YES;
    if (self.mkVipImage.hidden) {
        [self.focusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon.mas_centerY).offset(0);
            make.height.offset(20);
            make.width.offset(44);
            make.left.mas_equalTo(self.name.mas_right).offset(4);
        }];
    }else{
        [self.focusBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.icon.mas_centerY).offset(0);
            make.height.offset(20);
            make.width.offset(44);
            make.left.mas_equalTo(self.mkVipImage.mas_right).offset(4);
        }];
    }
    
    
    self.rightBtnView.mkZanView.mkTitleLable.text = model.praiseNum;
    [self.rightBtnView.mkZanView.mkButton setSelected:[model.isPraise boolValue]];
    self.rightBtnView.mkZanView.mkImageView.image = KIMG([model.isPraise boolValue] ? @"喜欢-点击" : @"喜欢-未点击");
    self.rightBtnView.mkZanView.mkButton.selected = [model.isPraise boolValue] ?YES:NO;
    self.rightBtnView.mkCommentView.mkTitleLable.text = model.commentNum;
    self.content.text = model.videoTitle;
    self.name.text = [NSString stringWithFormat:@"@%@",[NSString ensureNonnullString:model.author ReplaceStr:@"抖动用户"]];
    if ([model.areSelf isEqualToString:@"1"]) {
        self.focusBtn.hidden = YES;
    }else{
        self.focusBtn.hidden = [model.isAttention integerValue] == 1?YES :NO;
        NSMutableDictionary *dict =  [MKTools mkGetAttentionArrayOfCurrentLogin];
        if ([dict.allKeys containsObject:model.authorId]) {
            NSNumber *mkTempAttentionNum   =   [dict objectForKey:model.authorId.mutableCopy];
            BOOL mkTempAttention =  [mkTempAttentionNum boolValue];
            self.focusBtn.hidden = mkTempAttention;
            model.isAttention = [dict objectForKey:model.authorId] == 0 ?@"0":@"1";
        }
    }
    
    NSMutableDictionary *dict2 =  [MKTools mkGetLikeVideoArrayOfCurrentLogin];
    if ([MKTools mkDictionaryEmpty:dict2])
    { return;
    }
    else{
        if ([dict2.allKeys containsObject:model.videoId])
        {
            NSArray *array = [dict2 objectForKey:model.videoId];
            if ([MKTools mkSingleArrayEmpty:array]) { return ;}
            NSNumber *mkTempPraiseNum = array.firstObject;
            BOOL mkTemppraise =  [mkTempPraiseNum boolValue];
            self.rightBtnView.mkZanView.mkImageView.image = KIMG( mkTemppraise ? @"喜欢-点击" : @"喜欢-未点击" );
            self.rightBtnView.mkZanView.mkButton.selected = mkTemppraise;
            self.rightBtnView.mkZanView.mkTitleLable.text = [NSString stringWithFormat:@"%@",array.lastObject];
            model.isPraise  = mkTemppraise ?@"1":@"0";
        }
    }
}


#pragma mark -masonry
- (void)addMasonry {
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    if (self.mkListType == MKVideoListType_A) {
        [self.rightBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(0 * KDeviceScale);
            make.width.equalTo(@(34+15*2));
            make.height.equalTo(@(180 + 20));
            make.bottom.offset(-42*KDeviceScale);
        }];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16*KDeviceScale);
            make.height.greaterThanOrEqualTo(@(21));
            make.height.lessThanOrEqualTo(@(40));
            make.right.offset(-160);
            make.bottom.offset(-19*KDeviceScale);
        }];
    }else{
        [self.rightBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(0 * KDeviceScale);
            make.width.equalTo(@(34+15*2));
            make.height.equalTo(@(180 + 20));
            make.bottom.offset(-22*KDeviceScale - KBottomHeight - kTabBarHeight);
        }];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16*KDeviceScale);
            make.height.greaterThanOrEqualTo(@(21));
            make.height.lessThanOrEqualTo(@(40));
            make.right.offset(-160);
            make.bottom.offset(0*KDeviceScale - KBottomHeight - kTabBarHeight);
        }];
    }
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.content.mas_top).offset(-8);
        make.width.height.offset(37);
        make.left.offset(16*KDeviceScale);
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(3);
        make.height.offset(24);
        make.width.mas_lessThanOrEqualTo(200);
        make.centerY.mas_equalTo(self.icon.mas_centerY).offset(0);
    }];
    [self.mkVipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.icon.mas_centerY).offset(0);
        make.height.offset(17);
        make.width.offset(19);
        make.left.mas_equalTo(self.name.mas_right).offset(4);
    }];
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.icon.mas_centerY).offset(0);
        make.height.offset(20);
        make.width.offset(44);
        make.left.mas_equalTo(self.mkVipImage.mas_right).offset(4);
    }];
    
    
}

#pragma mark - getter
- (UIImageView *)mkVipImage{
    
    if (!_mkVipImage) {
        
        _mkVipImage = [[UIImageView alloc]init];
        _mkVipImage.image = KIMG(@"icon_userVIP");
        _mkVipImage.hidden = YES;
    }
    return _mkVipImage;
}
- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.tag = kPlayerView;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _coverImageView;
}
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}
- (void)setMkListType:(MKVideoListType)mkListType{
    _mkListType =  mkListType;
    if (self.mkListType == MKVideoListType_A) {
        [self.rightBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(0 * KDeviceScale);
            make.width.offset(34+15*2);
            make.height.offset(200);
            make.bottom.offset(-42*KDeviceScale);
        }];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16*KDeviceScale);
            make.height.greaterThanOrEqualTo(@(21));
            make.height.lessThanOrEqualTo(@(40));
            make.right.offset(-160);
            make.bottom.offset(-19*KDeviceScale);
        }];
    }else{
        [self.rightBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(0 * KDeviceScale);
            make.width.offset(34+15*2);
            make.height.offset(200);
            make.bottom.offset(-22*KDeviceScale - KBottomHeight - kTabBarHeight);
        }];
        
        [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16*KDeviceScale);
            make.height.greaterThanOrEqualTo(@(21));
            make.height.lessThanOrEqualTo(@(40));
            make.right.offset(-160);
            make.bottom.offset(0*KDeviceScale - KBottomHeight - kTabBarHeight);
        }];
    }
}
- (MKRightBtnView *)rightBtnView {
    if (!_rightBtnView) {
        _rightBtnView = MKRightBtnView.new;
        @weakify(self)
        [_rightBtnView.mkZanView.mkButton addAction:^(UIButton *btn) {
            @strongify(self)
                if (![MKTools mkLoginIsYESWith:[self getCurrentVC]]) {
                    return;
                }
            [UIView addViewAnimation:self->_rightBtnView.mkZanView.mkImageView
                         completionBlock:nil];
                
            if ([self.videoModel.mkCustomtype isEqualToString:@"1"]) {
                    return;
                }
            if ([self.videoModel.isPraise isEqualToString:@"1"]) { // 已经点赞，取消点赞
                    
                    self->_rightBtnView.mkZanView.mkImageView.image = KIMG(@"喜欢-未点击");
                self.videoModel.isPraise = @"0";
                }else{ // 未点赞，去点赞
                    self->_rightBtnView.mkZanView.mkImageView.image = KIMG(@"喜欢-点击");
                    self.videoModel.isPraise = @"1";
                    
                    [self.doubleLikeView createAnimationWithSuperView:[self getCurrentVC].view];
                    @weakify(self)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        @strongify(self)
                        [self.doubleLikeView createAnimationWithSuperView:[self getCurrentVC].view];
                    });
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        @strongify(self)
                        [self.doubleLikeView createAnimationWithSuperView:[self getCurrentVC].view];
                    });

                }
            if (self.delegate && [self.delegate respondsToSelector:@selector(cellAction:type:view:withIndexPath:)]) {
                [self.delegate cellAction:self.videoModel type:type_support view:self.rightBtnView withIndexPath:self.mkCellIndex];
            }
        }];
        [_rightBtnView.mkCommentView.mkButton addAction:^(UIButton *btn) {
            @strongify(self)
            if (self.delegate && [self.delegate respondsToSelector:@selector(cellAction:type:view:withIndexPath:)]) {
                [self.delegate cellAction:self.videoModel type:type_comment view:nil withIndexPath:self.mkCellIndex];
            }
        }];
        [_rightBtnView.mkShareView.mkButton addAction:^(UIButton *btn) {
            @strongify(self)
            if (self.delegate && [self.delegate respondsToSelector:@selector(cellAction:type:view:withIndexPath:)]) {
                [self.delegate cellAction:self.videoModel type:type_share view:nil withIndexPath:self.mkCellIndex];
            }
        }];
    }
    return _rightBtnView;
}
- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
//        _icon.backgroundColor = [UIColor redColor];
        _icon.layer.cornerRadius = 18.5;
        _icon.layer.masksToBounds = YES;
        _icon.userInteractionEnabled = YES;
        @weakify(self)
        [_icon addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
            @strongify(self)
            if (self.delegate && [self.delegate respondsToSelector:@selector(cellAction:type:view:withIndexPath:)]) {
                [self.delegate cellAction:self.videoModel type:type_userInfo view:nil withIndexPath:self.mkCellIndex];
            }
        }];
    }
    return _icon;
}
- (UILabel *)name {
    if (!_name) {
        _name = UILabel.new;
        _name.textColor = UIColor.whiteColor;
        _name.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
    }
    return _name;
}
- (UIButton *)focusBtn {
    if (!_focusBtn) {
        _focusBtn = UIButton.new;
        [_focusBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_focusBtn setBackgroundImage:KIMG(@"clearColor") forState:UIControlStateSelected];
        [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        _focusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [_focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        
        [_focusBtn setTitle:@"" forState:UIControlStateSelected];
        
        [_focusBtn titleLabel].font = [UIFont systemFontOfSize:10 weight:UIFontWeightRegular];
        
        [_focusBtn setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
        
        _focusBtn.layer.cornerRadius = 10;
        @weakify(self)
        [_focusBtn addAction:^(UIButton *btn) {
            @strongify(self)
            if (self.delegate && [self.delegate respondsToSelector:@selector(cellAction:type:view:withIndexPath:)]) {
                [self.delegate cellAction:self.videoModel type:type_focus view:btn withIndexPath:self.mkCellIndex];
            }
            
        }];
        _focusBtn.layer.cornerRadius = 10;
        _focusBtn.layer.masksToBounds = 1;
    }
    return _focusBtn;
}
- (UILabel *)content {
    if (!_content) {
        _content = UILabel.new;
        _content.textColor = UIColor.whiteColor;
        _content.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        _content.numberOfLines = 0;
    }
    return _content;
}
- (UIImage *)placeholderImage {
    if (!_placeholderImage) {
        _placeholderImage = [ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)];
    }
    return _placeholderImage;
}
- (GKDoubleLikeView *)doubleLikeView {
    if (!_doubleLikeView) {
        _doubleLikeView = [GKDoubleLikeView new];
    }
    return _doubleLikeView;
}
- (void)setMkCellIndex:(NSIndexPath *)mkCellIndex{
    _mkCellIndex = mkCellIndex;
}
@end
